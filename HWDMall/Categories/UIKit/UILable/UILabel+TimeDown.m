//
//  UILabel+TimeDown.m
//  HWDMall
//
//  Created by stewedr on 2018/10/25.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "UILabel+TimeDown.h"
#import "NSString+Common.h"

@implementation UILabel (TimeDown) // 倒计时
- (void)startTime:(NSInteger)timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle timeStringColor:(UIColor *)timeColor{
    __block NSInteger timeOut=timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.text = tittle;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                NSString * lblStr = NSStringFormat(@"%@%@",waitTittle,[NSString getHMSStringFromSeconds:timeOut]);
                NSMutableAttributedString * atrStr = [[NSMutableAttributedString alloc]initWithString:lblStr];
                NSRange range = [lblStr rangeOfString:[NSString getHMSStringFromSeconds:timeOut]];
                [atrStr addAttribute:NSForegroundColorAttributeName value:timeColor range:range];
                self.attributedText = atrStr;
            });
            timeOut--;
            
        }
    });
    dispatch_resume(_timer);
    
}
@end
