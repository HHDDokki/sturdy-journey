//
//  HHDCommonUtil.h
//  HWDMall
//
//  Created by HandC1 on 2018/11/19.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHDCommonUtil : NSObject

+ (void)showAlert:(NSString *)msg Target:(id)sender;
+ (void)showAlert:(NSString *)msg Target:(id)sender Tag:(NSInteger)tag;
+ (void)showAlert:(NSString *)msg Target:(id)sender Tag:(NSInteger)tag
            Cancel:(NSString *)cancelButton Other:(NSString *)otherButton;

+ (void)showMessage:(NSString *)msg target:(id)sender;
+ (NSString *)getIPAddress;

+ (void)showToast:(NSString *)toastString;
+ (CGSize)getImageSizeWithURL:(id)imageURL;

//微信小程序限制图片大小
+ (NSData *)zipImageToData:(UIImage *)dataImage;

+ (UIImage *)getLauchingImage;

@end

NS_ASSUME_NONNULL_END
