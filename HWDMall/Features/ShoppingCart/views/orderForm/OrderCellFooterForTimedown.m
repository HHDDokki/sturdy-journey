//
//  OrderCellFooterForTimedown.m
//  HWDMall
//
//  Created by stewedr on 2018/10/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderCellFooterForTimedown.h"
#import "UILabel+TimeDown.h"
#import "NSString+Common.h"
#import <OYCountDownManager.h>
#import "OrderListModel.h"
#import "TimeTransformation.h"

static NSString * const kCountDownNotification = @"kCountDownNotificationname";

@interface OrderCellFooterForTimedown ()
@property (weak, nonatomic) IBOutlet UILabel *topLbl;
@property (weak, nonatomic) IBOutlet UILabel *timedownLbl;
@property (weak, nonatomic) IBOutlet UIButton *bottomLbl;
@property (nonatomic,assign) NSInteger time;
@end

@implementation OrderCellFooterForTimedown

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bottomLbl.layer.borderWidth = 1;
    self.bottomLbl.layer.cornerRadius = 13.5;
    self.bottomLbl.layer.borderColor = UIColorFromHex(0xED5E3B).CGColor;
    [self.bottomLbl addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchDown];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
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
    if (!self.time) {
        return;
    }
    /// 计算倒计时
    
    OrderlistResultModel * model = self.timedownmodel;
    NSInteger timeInterval;
    if (self.timedownmodel.timeSourceName) {
        timeInterval = [kCountDownManager timeIntervalWithIdentifier:self.timedownmodel.timeSourceName];
    }else {
        timeInterval = kCountDownManager.timeInterval;
    }
    
    NSInteger countDown = self.time - timeInterval;
    if (countDown <= 0) {
        // 倒计时结束时回调
        if (self.timedownBlock) {
            self.timedownBlock(model);
        }
        return;
    }
    RDLog(@"✅%@\n %ld,\n %ld,\n,%ld",self.timedownmodel.timeSourceName,countDown,self.time,kCountDownManager.timeInterval);
    /// 重新赋值
    NSString * lblStr = NSStringFormat(@"%@%@",@"剩余时间：",[NSString getHMSStringFromSeconds:countDown]);
    NSMutableAttributedString * atrStr = [[NSMutableAttributedString alloc]initWithString:lblStr];
    NSRange range = [lblStr rangeOfString:[NSString getHMSStringFromSeconds:countDown]];
    [atrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromHex(0xED5E3B) range:range];
    self.timedownLbl.attributedText = atrStr;
}

- (void)dealloc{
    [kCountDownManager removeSourceWithIdentifier:self.timedownmodel.timeSourceName];
    [kCountDownManager invalidate];
    RDLog(@"✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨");
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)updateCellmesWithTime:(NSInteger)timedown AccountMoney:(NSString *)money BottomBtnName:(NSString *)btnTitle{

    [self.bottomLbl setTitle:btnTitle forState:UIControlStateNormal];
    self.topLbl.text = money;
    NSInteger currentTime = [TimeTransformation getNowTimestamp];
    self.time =  timedown - currentTime;
//    self.time = timedown;
    [kCountDownManager reloadAllSource];
    [self countDownNotification];
    if (timedown) {
        self.bottomLbl.userInteractionEnabled = YES;
        self.bottomLbl.layer.borderColor = kMainRedColor.CGColor;
        self.bottomLbl.titleLabel.textColor = kMainRedColor;
    }else{
        self.bottomLbl.userInteractionEnabled = NO;
        self.bottomLbl.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
        [self.bottomLbl setTitleColor:UIColorFromHex(0xcccccc) forState:UIControlStateNormal];
    }
    
}


- (void)btnAction{
    if (self.bottomBlock) {
        self.bottomBlock();
    }
}


@end
