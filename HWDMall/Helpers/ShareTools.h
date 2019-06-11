//
//  ShareTools.h
//  HWDMall
//
//  Created by 肖旋 on 2018/12/15.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    XCXType_Main = 0,   // 主
    XCXType_Pin,        // 拼团
    XCXType_Kan         // 砍价
} XCXType;

@interface ShareTools : NSObject

+ (instancetype)sharedSingleton;


/**
 分享到小程序

 @param type 小程序类型 0:主 1:拼团 2:砍价
 @param path 目的页面路径
 @param imageData 图片data
 @param title 标题
 @param description 描述
 */
- (void)shareToXCXWithType:(XCXType)type path:(NSString *)path imageData:(NSData *)imageData title:(NSString *)title description:(NSString *)description;

- (void)shareLongImgToWCTimelineWithImage:(UIImage *)image;
- (void)shareLongImgToWCWithImage:(UIImage *)image;

@end
