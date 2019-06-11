//
//  BasePayViewController.m
//  HWDMall
//
//  Created by 肖旋 on 2018/11/12.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import "BasePayViewController.h"

#define ALI_SCHEME @"haohuoduoalipay"

@interface BasePayViewController ()

@end

@implementation BasePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isCanceled = NO;
}


- (void)payWithOrderNo:(NSString *)orderNo paymentMethod:(NSString *)paymentMethod {
    self.isCanceled = NO;
    NSString *url = NSStringFormat(@"%@%@", @"http://47.93.216.16:7081", API_Pay_Order);
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:paymentMethod forKey:@"paymentMethod"];
    [parameters setValue:orderNo forKey:@"orderSn"];
    [[WebServiceTool shareHelper] postWithURLString:url parameters:parameters success:^(id  _Nonnull responseObject) {
        SLog(@"获取支付信息✅----%@", responseObject);
        if ([responseObject[@"code"] isEqualToString:@"0"] && [paymentMethod isEqualToString:@"1"]) {
            PayReq *payReq = [[PayReq alloc] init];
            payReq.partnerId    = responseObject[@"result"][@"partnerid"];
            payReq.prepayId     = responseObject[@"result"][@"prepayid"];
            payReq.nonceStr     = responseObject[@"result"][@"noncestr"];
            payReq.timeStamp    = [responseObject[@"result"][@"timestamp"] intValue];
            payReq.package      = responseObject[@"result"][@"package"];
            payReq.sign         = responseObject[@"result"][@"sign"];
            [self wechatPayWithPayReq:payReq];
        } else if ([responseObject[@"code"] isEqualToString:@"0"] && [paymentMethod isEqualToString:@"2"]) {
            [self alipayPayWithOrder:responseObject[@"result"][@"orderString"] success:^{
                
            } failure:^{
                
            }];
        }else{
            [kWindow makeToast:[responseObject objectForKey:@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [self paySuccess:NO channel:paymentMethod];
        SLog(@"获取支付信息❎----%@", error);
    }];
}

- (void)payWithOrderVipNo:(NSString *)orderNo paymentMethod:(NSString *)paymentMethod {
    self.isCanceled = NO;
    NSString *url = NSStringFormat(@"%@%@", @"http://47.93.216.16:7081", API_Vip);
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:paymentMethod forKey:@"paymentMethod"];
    [parameters setValue:orderNo forKey:@"orderSn"];
    [[WebServiceTool shareHelper] postWithURLString:url parameters:parameters success:^(id  _Nonnull responseObject) {
        SLog(@"获取支付信息✅----%@", responseObject);
        if ([responseObject[@"code"] isEqualToString:@"0"] && [paymentMethod isEqualToString:@"1"]) {
            PayReq *payReq = [[PayReq alloc] init];
            payReq.partnerId    = responseObject[@"result"][@"partnerid"];
            payReq.prepayId     = responseObject[@"result"][@"prepayid"];
            payReq.nonceStr     = responseObject[@"result"][@"noncestr"];
            payReq.timeStamp    = [responseObject[@"result"][@"timestamp"] intValue];
            payReq.package      = responseObject[@"result"][@"package"];
            payReq.sign         = responseObject[@"result"][@"sign"];
            [self wechatPayWithPayReq:payReq];
        } else if ([responseObject[@"code"] isEqualToString:@"0"] && [paymentMethod isEqualToString:@"2"]) {
            [self alipayPayWithOrder:responseObject[@"result"][@"orderString"] success:^{
                
            } failure:^{
                
            }];
        }
    } failure:^(NSError * _Nonnull error) {
        [self paySuccess:NO channel:paymentMethod];
        SLog(@"获取支付信息❎----%@", error);
    }];
}



- (void)paySuccess:(BOOL)success channel:(NSString *)channel {
    RDLog(@"✅1");
    if (success) {
        RDLog(@"支付成功");
    } else {
        RDLog(@"支付失败");
    }
}

- (void)alipayPayWithOrder:(NSString *)orderString success:(void (^)(void))success failure:(void (^)(void))failure {
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:ALI_SCHEME callback:^(NSDictionary *resultDic) {
        
        RDLog(@"reslut = %@",resultDic);
        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            [self paySuccess:YES channel:@"2"];
            !success ?: success();
        } else {
            if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
                self.isCanceled = YES;
            }
            [self paySuccess:NO channel:@"2"];
            !failure ?: failure();
        }
    }];
}

- (void)wechatPayWithPayReq:(PayReq *)payReq {
    
    if (![WXApi isWXAppInstalled]) {

        RDLog(@"用户未安装微信");

        return;
    }
    
    [WXApi sendReq:payReq];
}

//微信支付回调通知
- (void)wechatPayAction:(NSNotification *)notification {
    
    BaseResp *resp = notification.object[@"resultDic"];
    
    if (resp.errCode == WXSuccess) {
        
        RDLog(@"微信支付成功");
        [self wechatPaySuccess:YES];
        [self paySuccess:YES channel:@"1"];
    } else {
        if (resp.errCode == WXErrCodeUserCancel) {
            self.isCanceled = YES;
        }
        RDLog(@"微信支付失败--errCode:%d--errMsg:%@", resp.errCode, resp.errStr);
        [self wechatPaySuccess:NO];
        [self paySuccess:NO channel:@"1"];
    }
}

//支付宝支付回调通知
- (void)aliPayAction:(NSNotification *)notification {
    
    NSDictionary *resultDic = notification.object[@"resultDic"];
    
    if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        [self paySuccess:YES channel:@"2"];
    } else {
        if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
            self.isCanceled = YES;
        }
        [self paySuccess:NO channel:@"2"];
    }
}

- (void)wechatPaySuccess:(BOOL)success {
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPayAction:) name:@"wechatPayNofi" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayAction:) name:@"aliPayNofi" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"wechatPayNofi" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"aliPayNofi" object:nil];
}

- (void)dealloc{
    RDLog(@"dealloc");
}

@end
