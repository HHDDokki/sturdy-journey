
//
//  NSString+Common.m
//  Alliance
//
//  Created by sk on 2018/7/18.
//  Copyright © 2018年 duyiwang. All rights reserved.
//

#import "NSString+Common.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
@implementation NSString (Common)
- (CGFloat)getLabSizeWithFont:(CGFloat )font AndSize:(CGFloat)sizeWidth{
    CGRect rect = [self boundingRectWithSize:CGSizeMake((sizeWidth - 70)*2*[UIScreen mainScreen].bounds.size.width/640, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.height+15;
}

- (CGSize)gettextSizeWithFont:(CGFloat)font AndSize:(CGFloat)sizeWidth {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(sizeWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size;
    
}

- (CGFloat)getStringSingleLineWidthWithFont:(UIFont*)font
{
    CGSize size =[self sizeWithAttributes:@{NSFontAttributeName:font}];
    
    return size.width;
}

//是否包含emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

//正则匹配用户身份证号15或18位
+(BOOL)validateIDCardNumber:(NSString *)value {
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        //不满足15位和18位，即身份证错误
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    // 检测省份身份行政区代码
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    //分为15位、18位身份证进行校验
    switch (length) {
        case 15:
            //获取年份对应的数字
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                
                int S = [value substringWithRange:NSMakeRange(0,1)].intValue*7 + [value substringWithRange:NSMakeRange(10,1)].intValue *7 + [value substringWithRange:NSMakeRange(1,1)].intValue*9 + [value substringWithRange:NSMakeRange(11,1)].intValue *9 + [value substringWithRange:NSMakeRange(2,1)].intValue*10 + [value substringWithRange:NSMakeRange(12,1)].intValue *10 + [value substringWithRange:NSMakeRange(3,1)].intValue*5 + [value substringWithRange:NSMakeRange(13,1)].intValue *5 + [value substringWithRange:NSMakeRange(4,1)].intValue*8 + [value substringWithRange:NSMakeRange(14,1)].intValue *8 + [value substringWithRange:NSMakeRange(5,1)].intValue*4 + [value substringWithRange:NSMakeRange(15,1)].intValue *4 + [value substringWithRange:NSMakeRange(6,1)].intValue*2 + [value substringWithRange:NSMakeRange(16,1)].intValue *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 3：获取校验位
                //4：检测ID的校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}
+ (NSString *)getTimeString:(NSInteger)day {
    //设置日期格式
    NSDate *nowDate = [NSDate date];
    NSTimeInterval oneDay =24*60*60*1;//1天的长度
    NSDate *theDate = [nowDate initWithTimeIntervalSinceNow:+oneDay*day];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setLocale:[NSLocale currentLocale]];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    
    //日期格式转成字符串
    
    NSString * date1 = [formatter stringFromDate:theDate];
    return date1;
}

+(NSString *)getstringtimeString:(NSString *)string {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];;
    [inputFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString * date1 = [formatter stringFromDate:inputDate];
    return date1;
}

+ (NSString *)getstringTime:(NSString *)string {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];;
    [inputFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}

+ (NSString*)getdayString:(NSString *)string {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];;
    [inputFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
    NSInteger interval1 = [zone1 secondsFromGMTForDate: inputDate];
    NSDate *inputDate1 = [inputDate  dateByAddingTimeInterval: interval1];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"MM月dd日"];
    NSString *str1 = [outputFormatter stringFromDate:inputDate];
    
    NSDateFormatter *outputFormatter2 = [[NSDateFormatter alloc] init];
    [outputFormatter2 setLocale:[NSLocale currentLocale]];
    [outputFormatter2 setDateFormat:@"HH:mm"];
    NSString *str2 = [outputFormatter2 stringFromDate:inputDate];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: today];
    NSDate *localeDate = [today  dateByAddingTimeInterval: interval];
    NSDate *tomorrow, *yesterday, *thirdDay;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    thirdDay = [tomorrow dateByAddingTimeInterval:secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[localeDate description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    NSString * thiedString = [[thirdDay description] substringToIndex:10];
    
    NSString * dateString = [[inputDate1 description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString]) {
        dateString = @"今天";
    } else if ([dateString isEqualToString:yesterdayString]) {
        dateString = @"昨天";
    }else if ([dateString isEqualToString:tomorrowString]) {
        dateString = @"明天";
    } else if ([dateString isEqualToString:thiedString]) {
        dateString = @"后天";
    } else {
        dateString = @"";
    }
    return [NSString stringWithFormat:@"%@ %@ %@",str1, dateString, str2];
}

+ (NSString *)getTime:(NSString *)time {
    
    NSTimeInterval interval = [time floatValue];//（时间戳单位是微秒/1000）
    
    //时间戳转成date
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    //设置日期格式
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setLocale:[NSLocale currentLocale]];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //日期格式转成字符串
    
    NSString * date1 = [formatter stringFromDate:date];
    
    return date1;
}
+ (NSString *)getYYYYMMDD:(NSString *)timeStr{
    NSTimeInterval interval = [timeStr floatValue];//（时间戳单位是微秒/1000）
    
    
    //时间戳转成date

    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];

    //设置日期格式

    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];

    [formatter setLocale:[NSLocale currentLocale]];

    [formatter setDateFormat:@"yyyy.MM.dd"];

    //日期格式转成字符串

    NSString * date1 = [formatter stringFromDate:date];
    
    
   
   
    
    return date1;
}
+ (NSString *)getYYMMDD:(NSDate *)date {
    //设置日期格式
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //日期格式转成字符串
    NSString * date1 = [formatter stringFromDate:date];
    return date1;
}

+ (NSString *)minutesTurnHour:(NSString *)minutes {
    CGFloat num = [minutes floatValue];
    NSString *time = nil;
    if (num < 60) {
        time = [NSString stringWithFormat:@"%.0f分",num];
    } else {
        time = [NSString stringWithFormat:@"%.1f小时",num/60];
    }
    return time;
}

+ (NSString *)getHMSStringFromSeconds:(NSInteger )seconds{
    int totalTime = (int)seconds;
    int second = totalTime % 60;
    int minutes = (totalTime / 60) % 60;
    int hours = totalTime / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, second];
}

+ (NSString *)distanceString:(NSString *)string {
    CGFloat num = [string floatValue];
    NSString *fansNum = nil;
    if (num < 1000) {
        fansNum = [NSString stringWithFormat:@"%.0f米",num];
    } else {
        fansNum = [NSString stringWithFormat:@"%.1f千米",num/1000];
    }
    return fansNum;
}

+ (NSString *)getTimeStringFromString:(NSString * )time {
    //    NSDate * d = [NSDate date];
    //
    //    NSTimeInterval late = [d timeIntervalSince1970]*1;
    //
    NSString * timeStr = nil;
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha = now - [time doubleValue]/1000;
    if (cha/3600 < 1) {
        
        timeStr = [NSString stringWithFormat:@"%f", cha/60];
        
        timeStr = [timeStr substringToIndex:timeStr.length-7];
        
        int num= [timeStr intValue];
        
        if (num <= 1) {
            
            timeStr = [NSString stringWithFormat:@"刚刚..."];
            
        }else{
            
            timeStr = [NSString stringWithFormat:@"%@分钟前", timeStr];
            
        }
        
    }
    
    if (cha/3600 > 1 && cha/86400 < 1) {
        
        timeStr = [NSString stringWithFormat:@"%f", cha/3600];
        
        timeStr = [timeStr substringToIndex:timeStr.length-7];
        
        timeStr = [NSString stringWithFormat:@"%@小时前", timeStr];
        
    }
    
    if (cha/86400 > 1)
        
    {
        
        timeStr = [NSString stringWithFormat:@"%f", cha/86400];
        
        timeStr = [timeStr substringToIndex:timeStr.length-7];
        
        int num = [timeStr intValue];
        
        if (num < 2) {
            
            timeStr = [NSString stringWithFormat:@"昨天"];
            
        }else if(num == 2){
            
            timeStr = [NSString stringWithFormat:@"前天"];
            
        }else if (num > 2 && num <7){
            
            timeStr = [NSString stringWithFormat:@"%@天前", timeStr];
            
        }else if (num >= 7 && num <= 10) {
            
            timeStr = [NSString stringWithFormat:@"1周前"];
            
        }else if(num > 10){
            
            timeStr = [NSString stringWithFormat:@"%d天前",num];
            
        }
        
    }
    
    return timeStr;
}

+ (NSString *)getCurrentTimeString {
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",interval];
}

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return  YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString*)trimStringback:(NSString*)origiStr
{
    return [origiStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSString *)moneytrimSubDomZero
{
    // NSString *moeny = [NSString stringWithFormat:@"%.2f",20.00];
    
    int length = (int)self.length;
    NSString *sub = [self substringFromIndex:length-2];
    int index = -1;
    for (int i = (int)sub.length-1; i>=0; i--) {
        NSString *tmpStr = [sub substringWithRange:NSMakeRange(i, 1)];
        if(![tmpStr isEqualToString:@"0"])
        {
            break;
        }else{
            index++;
        }
    }
    if(index == 1)
    {
        return [self substringToIndex:length-3];
    }else if(index == 0)
    {
        return [self substringToIndex:length-1];
    }
    return self;
}

+ (NSString*)isEmpty:(NSString *)string
{
    if(string == nil || string == NULL || [string isKindOfClass:[NSNull class]] ){
        return @"";
    }else{
        return [NSString stringWithFormat:@"%@",string];
    }
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    
    NSString * strMd5 = [NSString stringWithFormat:
                         @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                         result[0], result[1], result[2], result[3],
                         result[4], result[5], result[6], result[7],
                         result[8], result[9], result[10], result[11],
                         result[12], result[13], result[14], result[15]
                         ];
    
    return strMd5;
}
-(BOOL)isPhoneNum{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSString *regex = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    NSPredicate *regextestAll = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if(([regextestmobile evaluateWithObject:self] == YES)
       || ([regextestcm evaluateWithObject:self] == YES)
       || ([regextestct evaluateWithObject:self] == YES)
       || ([regextestcu evaluateWithObject:self] == YES)
       || ([regextestPHS evaluateWithObject:self] == YES)
       || ([regextestAll evaluateWithObject:self] == YES)){
        return YES;
    }else{
        return NO;
    }
    
}

-(BOOL)isEmail{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
    
    
}


+(NSString *)HmacSha1:(NSString *)key data:(NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    // Sha256:
    //     unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    //    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    //
    //sha1
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    NSString *hash = [NSString hexStringFromString:HMAC];
    hash = [hash uppercaseString];
    return hash;
}

+ (NSString *)hexStringFromString:(NSData *)myD{
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


+ (NSString *)PhoneWithSecret:(NSString *)phoneStr{
    if (phoneStr && phoneStr.length > 7) {
    phoneStr = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(phoneStr.length -8, 4) withString:@"****"];//防止号码有前缀所以使用倒数第8位开始替换
    }
    return phoneStr;
}

+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

+ (NSString *)stringFromBase64String:(NSString *)base64Str {
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:base64Str options:0];
    
    return [[NSString alloc]initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
}
// 去空格
- (NSString *)deleteBlank{
//    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
// 计算高度
- (CGFloat)getItemSizeWithFont:(UIFont *)font Width:(CGFloat)width{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
    
}


@end
