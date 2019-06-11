//
//  HHDWebView.h
//  HWDMall
//
//  Created by HandC1 on 2019/2/28.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PayBlock)(NSString *orderId, NSString *paymentMethod);
typedef void(^FinishLoadBlock)(NSString *title);

@interface HHDWebView : UIView

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *mainWebView;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) PayBlock payblock;
@property (nonatomic, copy) FinishLoadBlock finishblock;

//- (void)gobackAction;
//- (void)shareFromAppAction;
//+ (instancetype)shareInstance;
//- (void)showPrivacyAgreementStateView;
//- (instancetype)initWithFrame:(CGRect)frame VipType:(VipType)vipType;

- (void)evaluateJs:(NSString *)js;
- (instancetype)initWithFrame:(CGRect)frame Url:(NSString *)url;
- (void)reload;
@end

NS_ASSUME_NONNULL_END
