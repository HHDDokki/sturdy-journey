//
//  GoodsTypeBtnsView.h
//  HWDMall
//
//  Created by sk on 2018/11/6.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^chooseBlock)(NSInteger index,NSInteger menuTag);
@interface GoodsTypeBtnsView : UIView

@property (nonatomic, strong) UIColor *btnBgColor;
@property (nonatomic, assign) CGSize heightSize;
@property (nonatomic, strong) UIView *ltView;
@property (nonatomic, strong) NSArray *arrDataSourse;

@property (nonatomic, strong) UIButton *btn;


@property(copy,nonatomic) chooseBlock block;

-(void)setChooseBlock:(chooseBlock)block;
- (void)setLabelBackgroundColor:(UIColor *)color;
- (void)getArrayDataSourse:(NSArray *)array;
- (CGSize)returnSize;
@end
