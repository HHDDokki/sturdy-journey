//
//  HYStepper.h
//  HYStepper
//
//  Created by zhuxuhong on 2017/7/16.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HYStepperCallback)(double value);

@interface HYStepper : UIView

@property(nonatomic)BOOL isValueEditable;
@property(nonatomic)double minValue;
@property(nonatomic)double maxValue;
@property(nonatomic)double value;
@property(nonatomic)double stepValue;
@property (nonatomic,strong) UIColor * stepBtnCorlor;
@property (nonatomic,strong) UIColor * btnTitleCorlor;
@property (nonatomic,strong) UIColor * textfieldTextCorlor;
@property (nonatomic,assign) CGFloat borderWidth;
@property (nonatomic,assign) float widthMultiple;
@property (nonatomic,copy) NSString * miniBtnImage;
@property (nonatomic,copy) NSString * maxBtnImage;
@property(nonatomic,copy)HYStepperCallback valueChanged;
@property (nonatomic, assign) NSInteger carid; // 购物车商品id

@property (nonatomic,assign,getter=isDetailSubviews) BOOL detailSubviews; // 作为详情页的控件


@end
