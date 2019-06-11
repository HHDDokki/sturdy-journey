
//
//  NSString+Common.h
//  Alliance
//
//  Created by sk on 2018/7/18.
//  Copyright © 2018年 duyiwang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Common)
/*
 计算文本高度
 */
- (CGFloat)getLabSizeWithFont:(CGFloat )font AndSize:(CGFloat)sizeWidth;
/*
 计算文本Size
 */
- (CGSize)gettextSizeWithFont:(CGFloat)font AndSize:(CGFloat)sizeWidth;

/*
 单行文本高度(先试试)
 */

- (CGFloat)getStringSingleLineWidthWithFont:(UIFont*)font;

/*
 对字符串中含有表情处理
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (NSString*)trimStringback:(NSString*)origiStr;
/*
 将时间转化成
 */
+ (NSString *)getTimeStringFromString:(NSString *)time;
+ (NSString *)getTime:(NSString *)time;
+ (NSString *)getTimeString:(NSInteger)day;
+ (NSString *)getstringTime:(NSString *)string;
+ (NSString*)getdayString:(NSString *)string;
+ (NSString *)getYYMMDD:(NSDate *)date;
+ (NSString *)getHMSStringFromSeconds:(NSInteger )seconds; // 秒转z时分秒
+ (NSString *)getYYYYMMDD:(NSString *)timeStr;
+(NSString *)getstringtimeString:(NSString *)string;

+ (NSString *)getCurrentTimeString;

+ (BOOL)isBlankString:(NSString *)string;
+(BOOL)validateIDCardNumber:(NSString *)value;//分钟数处理

+ (NSString *)minutesTurnHour:(NSString *)minutes;



/**
 *  粉丝数处理
 */
+ (NSString *)distanceString:(NSString *)string;
/**
 *  money 去除钱小数点2未的最后位 为0
 */

- (NSString *)moneytrimSubDomZero;

/**
 防止空字符串 容错处理
 
 @param string 字符串
 @return 容错处理后
 */
+ (NSString*)isEmpty:(NSString *)string;

/*md5加密*/
+ (NSString *)md5:(NSString *)str;


/*hmacsha1加密*/
+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)data;
/*电话号判断*/
- (BOOL)isPhoneNum;
+ (NSString *)PhoneWithSecret:(NSString *)phoneStr; // 手机号中间四位号码
/*email判断*/
- (BOOL)isEmail;
+ (BOOL)isNineKeyBoard:(NSString *)string;

+ (NSString *)stringFromBase64String:(NSString *)base64Str;

// 去空格
- (NSString *)deleteBlank;
// 计算高度
- (CGFloat)getItemSizeWithFont:(UIFont *)font Width:(CGFloat)width; // 高度
@end
