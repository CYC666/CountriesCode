//
//  CountryPickerVC.h
//  DearcareGlobal
//
//  Created by caoyicheng on 2021/2/20.
//  Copyright © 2021 laojingxing. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CountryPickerVCBlock)(NSString *name, NSString *code);

@interface CountryPickerVC : BaseViewController

@property (copy, nonatomic) CountryPickerVCBlock sureBlock;


@end

@interface CountryPickerVCCell : UITableViewCell

@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;

@end

NS_ASSUME_NONNULL_END
