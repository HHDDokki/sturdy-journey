//
//  BFMallConfirmOrderAddressCell.h
//  HWDMall
//
//  Created by HandC1 on 2019/5/27.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFMallConfirmOrderAddressCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *phoneLab;
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UIButton *arrowImg;

- (void)updateCellMesWithName:(NSString *)name Phone:(NSString *)phone Address:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
