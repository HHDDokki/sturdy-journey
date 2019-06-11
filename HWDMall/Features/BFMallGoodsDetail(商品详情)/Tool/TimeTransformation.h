//
//  TimeTransformation.h
//  Alliance
//
//  Created by 王学志 on 2018/8/7.
//  Copyright © 2018年 duyiwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTransformation : NSObject
//获取当前时间的 时间戳
+(NSInteger)getNowTimestamp;
//将某个时间转化成 时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//将某个时间戳转化成 时间
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
@end
