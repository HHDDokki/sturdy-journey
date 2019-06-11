//
//  UIImage+Scale.h
//  HWDMall
//
//  Created by HandC1 on 2018/12/7.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Scale)
//等比缩放一张图片，并作竖排照片的翻转
//maxResolution:是指图片长或者宽的最大尺寸。缩放时按照长宽中比较大的值为基准
//例如：maxResolution = 640，图片的实际尺寸是w=1920,h=1000,那么等比缩放后图片为w=640，h=333
//例如：maxResolution = 640，图片的实际尺寸是w=1000,h=1920,那么等比缩放后图片为w=333，h=640
- (UIImage *)scaleAndRotateImage:(float)maxResolution;
@end

NS_ASSUME_NONNULL_END
