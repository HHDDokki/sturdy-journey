//
//  OrderDetailTopOneLineWithtimedownCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderDetailTopOneLineWithtimedownCell.h"
#import "UILabel+TimeDown.h"

@interface OrderDetailTopOneLineWithtimedownCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeDownLbl;
@property (nonatomic,assign) NSInteger timedown; // 倒计时

@end

@implementation OrderDetailTopOneLineWithtimedownCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView setGradientBackgroundWithColors:@[kMainRedColor,kMainYellowColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
    }
    return self;
}

- (void)countDownNotification {
    /// 判断是否需要倒计时 -- 可能有的cell不需要倒计时,根据真实需求来进行判断
    if (!self.timedown) {
        return;
    }
    /// 计算倒计时
    TimedownModel *model = self.mytimedownmodel;
    NSInteger timeInterval;
    if (self.mytimedownmodel.timedownSourceName) {
        timeInterval = [kCountDownManager timeIntervalWithIdentifier:self.mytimedownmodel.timedownSourceName];
    }else {
        timeInterval = kCountDownManager.timeInterval;
    }
    NSInteger countDown = self.timedown - timeInterval;
    /// 当倒计时到了进行回调
    if (countDown <= 0) {
        self.timeDownLbl.text = @"倒计时:00:00:00";
        if (self.timedownBlock) {
            self.timedownBlock(model);
        }
        return;
    }
    /// 重新赋值
    self.timeDownLbl.text = [NSString stringWithFormat:@"倒计时:%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellMesWithTitle:(NSString *)titleStr
                     HeadImage:(NSString *)headimage
                      TimeDown:(NSInteger)timedown{
    self.headimage.image = GetImage(headimage);
    self.statusLbl.text = titleStr;
    // 手动刷新数据
     self.timedown = timedown;
    [self countDownNotification];
   
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
