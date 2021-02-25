//
//  CountryPickerVC.m
//  DearcareGlobal
//
//  Created by caoyicheng on 2021/2/20.
//  Copyright © 2021 laojingxing. All rights reserved.
//

#import "CountryPickerVC.h"


@interface CountryPickerVC () <UITableViewDelegate, UITableViewDataSource> {
    
    
    
}

@property (strong, nonatomic) UITableView *listTableView;   // 表视图
@property (strong, nonatomic) NSMutableArray *dataArray;    // 数据列表
@property (assign, nonatomic) NSInteger currentPage;        // 当前页


@end

@implementation CountryPickerVC

#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select countries and regions";
    self.view.backgroundColor = kBGColor;
    _dataArray = [NSMutableArray array];
    // 创建视图
    [self creatSubViewsAction];
    
    
    
}


#pragma mark ========================================私有方法=============================================

#pragma mark - 创建视图
- (void)creatSubViewsAction {
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - Nav_Height) style:UITableViewStylePlain];
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 50;
    _listTableView.estimatedRowHeight = 0;
    _listTableView.estimatedSectionFooterHeight = 0;
    _listTableView.estimatedSectionHeaderHeight = 0;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerClass:[CountryPickerVCCell class] forCellReuseIdentifier:@"CountryPickerVCCell"];
    [self.view addSubview:_listTableView];
    
    
    
    [self loadListAction:NO];
    
}

#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================

#pragma mark - 获取列表
- (void)loadListAction:(BOOL)isfooter {
    
    // 中文版
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"CountryList.plist" ofType:nil];
//    NSArray *list = [[NSArray alloc] initWithContentsOfFile:path];
//    NSLog(@"%@", list);
//
//    for (NSArray *subList in list) {
//
//        for (NSObject *model in subList) {
//
//            [self.dataArray addObject:model];
//        }
//    }
    
    // 英文版
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CountryCodes.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *JSON = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions|NSJSONWritingPrettyPrinted error:nil] mutableCopy];
    // NSLog(@"%@", JSON);
    [self.dataArray addObjectsFromArray:JSON];
    
    
    // 排序
    [self.dataArray sortUsingComparator:^NSComparisonResult(NSDictionary *dic1, NSDictionary *dic2) {

        NSString *code1 = [NSString stringWithFormat:@"%@", dic1[@"dial_code"]];
        NSString *code2 = [NSString stringWithFormat:@"%@", dic2[@"dial_code"]];
        
        return code1.intValue > code2.intValue;
    }];

    [self.listTableView reloadData];
    
}


#pragma mark ========================================代理方法=============================================

#pragma mark - 表视图代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return _dataArray.count;
//    return 20;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CountryPickerVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryPickerVCCell"
                                                            forIndexPath:indexPath];
    
    if (indexPath.row < _dataArray.count) {
        NSDictionary *dic = _dataArray[indexPath.row];
        
        cell.label1.text = [NSString stringWithFormat:@"%@", dic[@"name"]];
        cell.label2.text = [NSString stringWithFormat:@"%@", dic[@"dial_code"]];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row < _dataArray.count) {
        NSDictionary *dic = _dataArray[indexPath.row];
      
        NSString *name = [NSString stringWithFormat:@"%@", dic[@"name"]];
        NSString *code = [NSString stringWithFormat:@"%@", dic[@"dial_code"]];
        
        self.sureBlock(name, code);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark ========================================通知================================================






































@end



@implementation CountryPickerVCCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = cClearColor;
        [self creatUIAction];
        
    }
    return self;
    
}

#pragma mark - 创建UI
- (void)creatUIAction {
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kSpaceSize, 0, kScreenWidth - 80 - kSpaceSize*2, 50)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.numberOfLines = 1;
    label1.textColor = kTextGray;
    label1.font = WLFont(15);
    [self.contentView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.c_right, 0, 80, label1.c_height)];
    label2.textAlignment = NSTextAlignmentRight;
    label2.numberOfLines = 1;
    label2.textColor = kTextGray;
    label2.font = WLFont(15);
    [self.contentView addSubview:label2];
    
    UIView *line= [[UIView alloc] initWithFrame:CGRectMake(label1.c_left, label1.c_bottom - kBorderWidth, label2.c_right - label1.c_left, kBorderWidth)];
    line.backgroundColor = kLineColor;
    [self.contentView addSubview:line];
    
    self.label1 = label1;
    self.label2 = label2;
    
}


@end
