//
//  Macros.h
//  HWDMall
//
//  Created by stewedr on 2018/10/16.
//  Copyright © 2018 stewardR. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#define APP_DELEGATE       ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define SCREEN_W           [[UIScreen mainScreen] bounds].size.width
#define SCREEN_H           [[UIScreen mainScreen] bounds].size.height
#define SCREEN_FRAME       CGRectMake(0, 0, SCREEN_W, SCREEN_H)
#define SCALE_750   (SCREEN_W/375.0)
#define SCALE_640   (SCREEN_W/320.0)
#define MAIN_BUNDLE        [NSBundle mainBundle]
#define CURR_DEVICE        [UIDevice currentDevice]
#define USER_DEFAULTS      [NSUserDefaults standardUserDefaults]
#define NOTIFY_CENTER      [NSNotificationCenter defaultCenter]
#define FILE_MANAGER       [NSFileManager defaultManager]
#define SINGLE_STATE       [SingletonState sharedStateInstance]
#define PX(P)              (1.0 / [UIScreen mainScreen].scale) * (CGFloat)P
#define IMAGE_NAME(name)    [UIImage imageNamed:name]
#define URL_STR(string)     [NSURL URLWithString:string]
#define FFONT(size)         [UIFont systemFontOfSize:size]



#define kiPhone6Height 667.00
#define kiPhone6Width 375.00
#define kiPhone6sHeight 1334.00
#define kiPhone6sWidth 750.00

#pragma mark -- Masonry
#define equalTo(...)                     mas_equalTo(__VA_ARGS__)
#define greaterThanOrEqualTo(...)        mas_greaterThanOrEqualTo(__VA_ARGS__)
#define lessThanOrEqualTo(...)           mas_lessThanOrEqualTo(__VA_ARGS__)
#define offset(...)                      mas_offset(__VA_ARGS__)

#define DEBUGGER 1 //上线版本屏蔽此宏

#if DEBUGGER
/* 自定义log 可以输出所在的类名,方法名,位置(行数)*/
#define RDLog(format, ...) NSLog((@"%s [Line %d] " format), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )

#else

#define RDLog(...)

#define SLog(format, ...)

#endif


//****************** UIFont ******************//
//中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]
#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"
#define SFP [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Medium" : @"PingFang SC"

#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];

#define Font(a) (kScreenWidth/kiPhone6Width)*a
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:Font(size)]
/***  粗体 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:Font(size)]
/** Medium */
#define kMindleFont(size) [UIFont systemFontOfSize:Font(size) weight:UIFontWeightMedium]
/**Thin */
#define kThinFont(size) [UIFont systemFontOfSize:Font(size) weight:UIFontWeightThin]
//****************** UIFont ******************//


#pragma mark -
#pragma mark -屏幕尺寸,软件版本

/*屏幕尺寸*/
#define IPHONE_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE_6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPHoneXr
#define IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhoneXs
#define IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhoneXs Max
#define IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

//适配参数
#define KsuitParam (IPHONE_Xs_Max ?1.12:(IPHONE_6?1.0:(IPHONE_Xs ?1.01:0.85))) //以6为基准图

//#define INDEX  (iPhone6Plus?1.294:(iPhone6?1.172:1))
//以375屏宽为基底，比例
#define INDEX (IPHONE_6P ? 1.104 : (IPHONE_6 ? 1.0 : (IPHONE_X ? 1.0 : 0.853 )))
//当前window
#define kCurrentWindow [[UIApplication sharedApplication].windows firstObject]
#define kWindow  [UIApplication sharedApplication].keyWindow

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kAppdelegate ((AppDelegate*)([UIApplication sharedApplication].delegate)).window
#define kTOP_BAR_HEIGHT      ([[UIApplication sharedApplication] statusBarFrame].size.height) // 适配iPhone x 顶部高度

#define kSafeAreaTopHeight (kScreenHeight >= 812.0 ? 88 : 64)//iPhone x 顶部高度与其他机型
#define kSafeAreaBottomHeight (kScreenHeight >= 812.0 ? 34 : 0)//适配IPhoneX底部
#define TOP_H (kScreenHeight >= 812 ? 44 : 20)
#define kTabbarHeight ((IPHONE_X == YES || IPHONE_Xr == YES || IPHONE_Xs == YES || IPHONE_Xs_Max == YES) ? 83.0 : 49.0)                                                    // (IPHONE_X ? (49.f+34.f) : 49.f) // Tabbar height.
#define viewY(a) ceil((a/kiPhone6Height * kScreenHeight))
#define viewX(a) ceil((a/kiPhone6Width * kScreenWidth))

//拼接字符串

#define NSStringFormat(format,...)[NSString stringWithFormat:format,##__VA_ARGS__]

// 颜色
#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#define UIColorFromHex(hexValue)            UIColorFromHexWithAlpha(hexValue,1.0)
#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(r,g,b)               UIColorFromRGBA(r,g,b,1.0)
#define kMainColor [UIColor colorWithRed:(10)/255.0 green:(166)/255.0 blue:(246)/255.0 alpha:1.0]
#define kBgColor [UIColor colorWithRed:(239)/255.0 green:(239)/255.0 blue:(239)/255.0 alpha:1.0]

//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)


//弱引用/强引用  可配对引用在外面用MPWeakSelf(self)，block用MPStrongSelf(self)  也可以单独引用在外面用MPWeakSelf(self) block里面用weakself
#define MPWeakSelf(type)  __weak typeof(type) weak##type = type;
#define MPStrongSelf(type)  __strong typeof(type) type = weak##type;

#define weakify(...) \
ext_keywordify \
metamacro_foreach_cxt(ext_weakify_,, __weak, __VA_ARGS__)
#define strongify(...) \
ext_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
metamacro_foreach(ext_strongify_,, __VA_ARGS__) \
_Pragma("clang diagnostic pop")

#endif /* Macros_h */
