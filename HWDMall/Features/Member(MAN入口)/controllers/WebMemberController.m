//
//  WebMemberController.m
//  HWDMall
//
//  Created by HandC1 on 2019/2/28.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "WebMemberController.h"
#import "BFMallDetailRightPopView.h"
#import "HHDWebView.h"
#import "MemberModel.h"

#import "ShoppingcartViewController.h" // 购物车
#import "MyOrderFormController.h" // 我的订单
#import "LoginViewController.h" // 登录

#import "BFMallMyCollectionController.h" //收藏
#import "ConsigneeAddressController.h" //地址收藏
#define ALI_SCHEME @"haohuoduoalipay"

@interface WebMemberController ()

@property (nonatomic, strong) HHDWebView *webView;
@property (nonatomic, assign) VipType vipType;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) UITableView *mainTable;
@property (nonatomic) BOOL isLogin;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *rootBtn;
@property (nonatomic, strong) UIButton *mainPopBtn;
@property (nonatomic, assign) BOOL isCanceled;

@end

@implementation WebMemberController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.isCanceled = NO;
    [self setNavigationView];
    [self setNavigationContentView];
    [self setNavigationTitle];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.navigationController.navigationBar.translucent = YES;

    self.hidesBottomBarWhenPushed = 0;
    self.vipType = [GVUserDefaults standardUserDefaults].viptype;
    self.token = [GVUserDefaults standardUserDefaults].token;
    if (self.webUrl) {
        self.webView = [[HHDWebView alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight, SCREEN_W, SCREEN_H-kTabbarHeight-kSafeAreaTopHeight) Url:self.webUrl];
    }else {
        NSString *url = @"http://39.106.97.82:8107";
        self.webView = [[HHDWebView alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight, SCREEN_W, SCREEN_H-kTabbarHeight-kSafeAreaTopHeight) Url:url];
    }
    
    [self.view addSubview:self.webView];
    WK(weakSelf)
    self.webView.payblock = ^(NSString * _Nonnull orderId, NSString * _Nonnull paymentMethod) {
        [weakSelf payWithOrderVipNo:orderId paymentMethod:paymentMethod];

    };
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"wechatPayNofi" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"aliPayNofi" object:nil];
    if (self.navigationController.childViewControllers.count > 1) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }

//    [self.navigationController.view addSubview:self.navigationController.navigationBar];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    if ([GVUserDefaults standardUserDefaults].isLogin) {
        
        NSDictionary *userDic = @{@"headImg": [GVUserDefaults standardUserDefaults].headImg,@"nickname" : [GVUserDefaults standardUserDefaults].nickname, @"id":[GVUserDefaults standardUserDefaults].userId, @"isVip": NSStringFormat(@"%d",[GVUserDefaults standardUserDefaults].isVip)};
        NSDictionary *textDic = @{@"token":[GVUserDefaults standardUserDefaults].token,@"userInfo":  userDic};
        
        NSError *error = nil;
        NSData *jsonData = nil;
        jsonData = [NSJSONSerialization dataWithJSONObject:textDic options:nil error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString * jsStr = [NSString stringWithFormat:@"javascript:setH5ToInitData(%@)", jsonString];
        [self.webView evaluateJs:jsStr];
        
        [self bf_setButtonImageWithUrl:[GVUserDefaults standardUserDefaults].headImg];
    }
    
//    [self.navigationController.navigationBar removeFromSuperview];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPayAction:) name:@"wechatPayNofi" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayAction:) name:@"aliPayNofi" object:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = YES;
//    if (self.vipType != [GVUserDefaults standardUserDefaults].viptype || self.token != [GVUserDefaults standardUserDefaults].token) {
//        self.vipType = [GVUserDefaults standardUserDefaults].viptype;
//        self.token = [GVUserDefaults standardUserDefaults].token;
//        NSString *webUrl = NSStringFormat(@"http://172.16.4.40:8080/#/test?token=%@&vipCode=%lu", [GVUserDefaults standardUserDefaults].token, (unsigned long)self.vipType);
//        self.webView.url = webUrl;
//        [self.webView reload];
//    }
    [self memberLoadData];


}

#pragma mark ----会员数据
- (void)memberLoadData {
    
}

- (void)setNavigationContentView {
    
    switch (self.type) {
        case BFMALL_MAIN:
        {
            self.navigationView.backgroundColor = [UIColor blackColor];
            UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectZero];
            [imageBtn setTitle:@"选" forState:UIControlStateNormal];
            imageBtn.titleLabel.font = kBoldFont(14);
            [imageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [imageBtn setImage:IMAGE_NAME(@"nav_man") forState:UIControlStateNormal];
            [self.navigationView addSubview:imageBtn];
            [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
                make.centerX.equalTo(self.navigationView.mas_centerX).offset(-10);
                make.width.equalTo(71.6);
                make.height.equalTo(30);
            }];
        
            [self.navigationView addSubview:self.mainPopBtn];
            [self.mainPopBtn setImage:IMAGE_NAME(@"非会员默认头像") forState:UIControlStateNormal];
            [self.mainPopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.navigationView.mas_right).offset(-15);
                make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
                make.height.width.equalTo(27);
            }];
            
        }
            break;
        case BFMALL_LIST:
        {
            
            self.navigationView.backgroundColor = [UIColor whiteColor];
            [self setNavigationBackButton];
//            [self.backButton setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
//            [self.navigationView addSubview:self.mainPopBtn];
            [self.navigationView addSubview:self.rootBtn];
            [self.rootBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.navigationView.mas_right).offset(-12);
                make.width.equalTo(22);
                make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
                make.height.equalTo(22);
            }];
            
//            [self.mainPopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(self.rootBtn.mas_left).offset(-25);
//                make.right.mas_equalTo(self.navigationView.mas_right);
//                make.width.equalTo(22);
//                make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
//                make.height.equalTo(22);
//            }];

        }
            break;
        case BFMALL_COMMON:
        {
            self.navigationView.backgroundColor = [UIColor whiteColor];
            [self setNavigationBackButton];
//            [self.navigationView addSubview:self.shareBtn];
//            [self.navigationView addSubview:self.mainPopBtn];
            [self.navigationView addSubview:self.rootBtn];
            
            [self.rootBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.navigationView.mas_right).offset(-12);
                make.width.equalTo(22);
                make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
                make.height.equalTo(22);
            }];
            
//            [self.mainPopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(self.rootBtn.mas_left).offset(-25);
//                make.right.mas_equalTo(self.navigationView.mas_right);
//                make.width.equalTo(22);
//                make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
//                make.height.equalTo(22);
//            }];
            
//            [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(self.mainPopBtn.mas_left).offset(-25);
//                make.width.equalTo(22);
//                make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
//                make.height.equalTo(22);
//            }];
            return;
        }
        case BAMALL_NORMAL:
        {
            self.navigationView.backgroundColor = [UIColor whiteColor];
            [self setNavigationBackButton];
            [self.navigationView addSubview:self.shareBtn];
            [self.navigationView addSubview:self.mainPopBtn];
            [self.navigationView addSubview:self.rootBtn];
            
            [self.rootBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.navigationView.mas_right).offset(-12);
                make.width.equalTo(22);
                make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
                make.height.equalTo(22);
            }];
            
            [self.mainPopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.rootBtn.mas_left).offset(-25);
                make.width.equalTo(22);
                make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
                make.height.equalTo(22);
            }];
            
            [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mainPopBtn.mas_left).offset(-25);
                make.width.equalTo(22);
                make.bottom.equalTo(self.navigationView.mas_bottom).offset(-10);
                make.height.equalTo(22);
            }];

        }
            break;
        default:
            break;
    }
}

- (void)mainPopBtnClick:(UIButton *)btn {
    
    
    
    if (![GVUserDefaults standardUserDefaults].isLogin) {

        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];

    }else {
    
        [BFMallDetailRightPopView setTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]];
        if ([BFMallDetailRightPopView isShow]){
            
            [BFMallDetailRightPopView dismissMenu];
            
        } else {
            WK(weakSelf);
            [BFMallDetailRightPopView showMenuInView:self.view fromRect:btn.frame selected:^(NSInteger index, NSString * _Nonnull type) {
                if ([type isEqualToString:TYPE_SHOPPINGCART]) {
                    ShoppingcartViewController *vc = [[ShoppingcartViewController alloc] init];
                    weakSelf.navigationController.navigationBar.hidden = NO;
                    vc.fromDetailView = 0;
                    [weakSelf.navigationController pushViewController:vc animated:NO];
                }
                else if ([type isEqualToString:TYPE_MYORDER]) {
                    
                    MyOrderFormController *orderController = [[MyOrderFormController alloc]init];
                    weakSelf.navigationController.navigationBar.hidden = NO;
                    orderController.hidesBottomBarWhenPushed = YES;
                    orderController.currentIndex = 0;
                    [self.navigationController pushViewController:orderController animated:YES];
                    
                }else if ([type isEqualToString:TYPE_MYCOLLECTION]) {
                    
                    BFMallMyCollectionController *vc = [[BFMallMyCollectionController alloc] init];
                    weakSelf.navigationController.navigationBar.hidden = NO;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([type isEqualToString:TYPE_ADDRESS_MANAGER]) {
                    
                    ConsigneeAddressController *vc = [[ConsigneeAddressController alloc] init];
                    weakSelf.navigationController.navigationBar.hidden = NO;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([type isEqualToString:TYPE_BUY_VIP]) {
                                        
                    NSString *url = @"http://39.106.97.82:8107/payVip";
                    WebMemberController *vc = [[WebMemberController alloc] init];
                    vc.webUrl = url;
                    vc.type = BFMALL_COMMON;
                    vc.title = @"会员中心";
                    [[ToolsManage getCurrentVC].navigationController pushViewController:vc animated:NO];
                }
            }];
            
        }
        
    }
    
}

- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:IMAGE_NAME(@"分享") forState:UIControlStateNormal];
//        [_shareBtn addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIButton *)rootBtn {
    if (!_rootBtn) {
        _rootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rootBtn setImage:IMAGE_NAME(@"关闭") forState:UIControlStateNormal];
        [_rootBtn addTarget:self action:@selector(clossAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rootBtn;
}

- (UIButton *)mainPopBtn {
    if (!_mainPopBtn) {
        _mainPopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mainPopBtn setImage:IMAGE_NAME(@"我的") forState:UIControlStateNormal];
        [_mainPopBtn addTarget:self action:@selector(mainPopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainPopBtn;
}

#pragma mark ---立即支付
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
        [GVUserDefaults standardUserDefaults].isVip = YES;
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


- (void)bf_setButtonImageWithUrl:(NSString *)urlStr {
    
    NSURL * url = [NSURL URLWithString:urlStr];
    dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
    dispatch_async(xrQueue, ^{
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainPopBtn setImage:img forState:UIControlStateNormal];
        });
    });
    
}


@end
