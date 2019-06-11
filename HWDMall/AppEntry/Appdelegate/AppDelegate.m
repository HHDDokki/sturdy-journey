//
//  AppDelegate.m
//  HWDMall
//
//  Created by stewedr on 2018/10/16.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "WebMemberController.h"  //会员H5
#import "UITabBar+CustomBadge.h"
#import "UITabBar+Badge.h"
#import "GetShopCarModel.h"
#import <NSObject+YYModel.h>
#import <UserNotifications/UNUserNotificationCenter.h>

NSString * const MiPushSocketMessage = @"MiPushSocketMessage";
NSString * const HomePopADNotification = @"HomePopADNotification";
NSString * const LaunchPopADNotification = @"LaunchPopADNotification";
NSString * const XNSiteid = @"py_1000";
NSString * const XNSDKKey = @"a6bf5956-c73c-4b47-8a9e-3b24dcf717a5";

@interface AppDelegate ()<WXApiDelegate,WXApiLogDelegate,UITabBarControllerDelegate, CYLTabBarControllerDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setMainTabbar];
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    self.window = window;
    self.window.rootViewController = self.mainTabbar;
    [self configMiPush];
    [self configWXLogin];
//    NSString * deviceID =[UMConfigure deviceIDForIntegration];
//    NSLog(@"集成测试的deviceID:%@", deviceID);
    

//    //老版本iOS统计SDK请使用如下代码段：
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if (cls && [cls respondsToSelector: deviceIDSelector]) {
//        deviceID = [cls performSelector: deviceIDSelector];
//    }
//    NSData * jsonData =[NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
//                                                       options: NSJSONWritingPrettyPrinted
//                                                         error: nil];
//    NSLog(@"%@", [[NSString alloc] initWithData: jsonData encoding: NSUTF8StringEncoding]);
    
    [self.window makeKeyAndVisible];
    [self getShopCartCount];
    [self configTabBarController:self.mainTabbar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getShopCartCount) name:PostCenterName object:nil]; // 获取购物车数量
    // 处理点击通知打开app的逻辑
    NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo){//推送信息
        self.mainTabbar.selectedIndex = 0;
        // 用于统计
//        NSString *messageId = [userInfo objectForKey:@"_id_"];
//        if (messageId != nil) {
//            [MiPushSDK openAppNotify:messageId];
//        }
    }
    [self checkLoginState];
    if ([GVUserDefaults standardUserDefaults].isLogin) {//小能登录
//        [[NTalker standardIntegration] loginWithUserid:[GVUserDefaults standardUserDefaults].outUserCode andUsername:[GVUserDefaults standardUserDefaults].nickname andUserLevel:@"0"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:@"loginSuccess" object:nil];
    
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        
    } else {
        WK(weakSelf)
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

    self.browserRecordArray = nil;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self checkUpdateInFirstTime:NO];
    [self checkLoginState];
    if ([GVUserDefaults standardUserDefaults].isLogin) {//小能登录同步信息
//        [[NTalker standardIntegration] loginWithUserid:[GVUserDefaults standardUserDefaults].outUserCode andUsername:[GVUserDefaults standardUserDefaults].nickname andUserLevel:@"0"];
    }
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -- Push
//小米推送
- (void)configMiPush {
    
//    [MiPushSDK registerMiPush:self type:UIRemoteNotificationTypeNone connect:YES];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 注册APNS成功, 注册deviceToken
//    [MiPushSDK bindDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    // 注册APNS失败
    // 自行处理
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //程序在前台时接收推送不处理
//    if (application.applicationState == UIApplicationStateActive) {
//        return;
//    }
//    if(userInfo != nil) {
//        [MiPushSDK handleReceiveRemoteNotification :userInfo];
//        //用与统计
//        NSString *messageId = [userInfo objectForKey:@"_id_"];
//        if (messageId != nil) {
//            [MiPushSDK openAppNotify:messageId];
//        }
//    }
}

// iOS10新加入的回调方法
// 应用在前台收到通知
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [MiPushSDK handleReceiveRemoteNotification:userInfo];
//    }
//    //    completionHandler(UNNotificationPresentationOptionAlert);
//}

// 点击通知进入应用
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)) {
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    self.mainTabbar.selectedIndex = 0;
//    UINavigationController *nav = (UINavigationController *)self.mainTabbar.viewControllers[0];
//    [nav popToRootViewControllerAnimated:NO];
//    [[ToolsManage getCurrentVC] dismissViewControllerAnimated:NO completion:nil];
//
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [MiPushSDK handleReceiveRemoteNotification:userInfo];
//    }
//    completionHandler();
//}

//- (void)miPushReceiveNotification:(NSDictionary *)data {
//    NSLog(@"小米推送消息%@", data);
//    [MiPushSDK handleReceiveRemoteNotification:data];
//    // 长连接收到的消息。消息格式跟APNs格式一样
////    [[NSNotificationCenter defaultCenter] postNotificationName:MiPushSocketMessage object:data];
//}

#pragma mark -- setMainTabbar
- (void)setMainTabbar{
    UIViewController * home = [[UIViewController alloc]init];
    UINavigationController * homeNav = [[UINavigationController alloc]initWithRootViewController:home];
    
    UIViewController * classi = [[UIViewController alloc]init];
    UINavigationController * classiNav = [[UINavigationController alloc]initWithRootViewController:classi];

    WebMemberController *mem = [[WebMemberController alloc] init];
    mem.type = BFMALL_MAIN;
    UINavigationController * memNav = [[UINavigationController alloc]initWithRootViewController:mem];
    mem.navigationController.navigationBar.hidden = YES;
    
    UIViewController * shoppcart = [[UIViewController alloc]init];
    BaseNavigationController * shoppcartNav = [[BaseNavigationController alloc]initWithRootViewController:shoppcart];
//    shoppcartNav.tabBarItem.badgeValue = @"10";
//    if (@available(iOS 10.0, *)) {
//        [UITabBarItem appearance].badgeColor = [UIColor yellowColor];
//        []
//        [[UITabBarItem appearance]  setBadgeTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
//    } else {
//        // Fallback on earlier versions
//    }
    UIViewController * me = [[UIViewController alloc]init];
    UINavigationController * meNav = [[UINavigationController alloc]initWithRootViewController:me];
    
    CYLTabBarController * tabbarController = [[CYLTabBarController alloc]init];
    [self customizeTabBarForController:tabbarController];
    [tabbarController setViewControllers:@[
                                           homeNav,
                                           classiNav,
                                           memNav,
                                           shoppcartNav,
                                           meNav
                                           ]];
    tabbarController.delegate = self;
    [[UITabBar appearance] setTranslucent:NO];
    self.mainTabbar = tabbarController;
    
}
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"tab_icon_home_gret",
                            CYLTabBarItemSelectedImage : @"tab_icon_home_normal",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"分类",
                            CYLTabBarItemImage : @"tab_icon_kind_grey1",
                            CYLTabBarItemSelectedImage : @"tab_icon_kind_grey",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"会员",
                            CYLTabBarItemImage : @"tab_icon_vip_grey",
                            CYLTabBarItemSelectedImage : @"tab_icon_vip_normal",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"购物车",
                            CYLTabBarItemImage : @"tab_icon_cart_grey",
                            CYLTabBarItemSelectedImage : @"tab_icon_cart_normal",
                            };
    NSDictionary *dict5 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"tab_icon_mine_grey",
                            CYLTabBarItemSelectedImage : @"tab_icon_mine_normal",
                            };
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = UIColorFromHex(0xc3c3c3);
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = UIColorFromHex(0xed5e3b);
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    NSArray *tabBarItemsAttributes = @[ dict1,dict2,dict3,dict4,dict5 ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

- (void)configTabBarController:(CYLTabBarController *)tabBarController{
    if ([GVUserDefaults standardUserDefaults].isLogin && [GVUserDefaults standardUserDefaults].userType && [GVUserDefaults standardUserDefaults].shopcartcount) {
        NSString *tabbadgeStr;
        if ([GVUserDefaults standardUserDefaults].shopcartcount < 99) {
            tabbadgeStr = NSStringFormat(@"%ld",(long)[GVUserDefaults standardUserDefaults].shopcartcount);
        }else{
            tabbadgeStr = @"99+";
        }
        [tabBarController.tabBar updateBadge:tabbadgeStr bgColor:[UIColor whiteColor] atIndex:3];
        [tabBarController.tabBar updateBadgeLayerColor:UIColorFromHex(0xED5E3B) atIndex:3];
        [tabBarController.tabBar updateBadgeTextFont:kFont(8) atIndex:3];
        [tabBarController.tabBar updateBadgeTextColor:UIColorFromHex(0xED5E3B) atIndex:3];
    }else{
        [tabBarController.tabBar removeBadgeAtIndex:3];
    }
    
    
//    [tabBarController.tabBar showBadgeOnItemIndex:1];
//    UIViewController *viewController = tabBarController.viewControllers[3];
//    UIView *tabBadgePointView0 = [UIView cyl_tabBadgePointViewWithClolor:kMainRedColor radius:6];
//    tabBadgePointView0.backgroundColor = [UIColor whiteColor];
//    tabBadgePointView0.frame = CGRectMake(0, 0, 50, 12);
//    tabBadgePointView0.layer.borderColor = UIColorFromHex(0xED5E3B).CGColor;
//    tabBadgePointView0.layer.borderWidth = 1;
//    UILabel * badgeLbl = [UILabel new];
//    badgeLbl.text = @"99+";
//    badgeLbl.textAlignment = NSTextAlignmentCenter;
//    badgeLbl.textColor = kMainRedColor;
//    badgeLbl.font = kFont(8);
//    [tabBadgePointView0 addSubview:badgeLbl];
//    [badgeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(tabBadgePointView0);
//    }];
//    [viewController.tabBarItem.cyl_tabButton cyl_setTabBadgePointView:tabBadgePointView0];
//    [viewController.tabBarItem ]
//    [viewController cyl_showTabBadgePoint];
    
//    UIView *tabBadgePointView1 = [UIView cyl_tabBadgePointViewWithClolor:kMainRedColor radius:4.5];
//    @try {
//        [tabBarController.viewControllers[1] cyl_setTabBadgePointView:tabBadgePointView1];
//        [tabBarController.viewControllers[1] cyl_showTabBadgePoint];
//
//        UIView *tabBadgePointView2 = [UIView cyl_tabBadgePointViewWithClolor:kMainRedColor radius:4.5];
//        [tabBarController.viewControllers[2] cyl_setTabBadgePointView:tabBadgePointView2];
//        [tabBarController.viewControllers[2] cyl_showTabBadgePoint];
//
//        [tabBarController.viewControllers[3] cyl_showTabBadgePoint];
//
//        //添加提示动画，引导用户点击
//    } @catch (NSException *exception) {}
}

#pragma mark --  CheckUpdagte
- (void)checkUpdateInFirstTime:(BOOL)isFirstTime {
    NSString *url = NSStringFormat(@"%@%@", kApiPrefix, API_getNewest);
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setValue:@"2" forKey:@"type"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [parameters setValue:app_Version forKey:@"version"];
    [[WebServiceTool shareHelper] postWithURLString:url parameters:parameters success:^(id  _Nonnull responseObject) {
        SLog(@"获取版本信息✅----%@", responseObject);
        if ([responseObject[@"code"] isEqualToString:@"0"]) {
            if ([responseObject[@"result"][@"forceUpgrade"] intValue] != 0) {
             
            } else if ([responseObject[@"result"][@"remindUpgrade"] intValue] != 0) {
                if (isFirstTime) {
                }
            } else {
                if (isFirstTime) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:HomePopADNotification object:nil];
                }
            }
        }
        
    } failure:^(NSError * _Nonnull error) {
        SLog(@"获取版本信息❎----%@", error);
        if (isFirstTime) {
            [[NSNotificationCenter defaultCenter] postNotificationName:HomePopADNotification object:nil];
        }
    }];
}

- (void)showAlertWithMessage:(NSString *)message urlStr:(NSString *)urlStr isForce:(BOOL)isForce {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请升级" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }]];
    WK(weakSelf)
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (isForce) {
            [weakSelf exitApplication];
        }
    }]];
    [self.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

- (void)exitApplication {
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:NO];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    self.window.bounds = CGRectMake(0, 0, 0, 0);
    [UIView commitAnimations];
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
}

#pragma mark -- CheckLoginState
- (void)checkLoginState {
    if ([GVUserDefaults standardUserDefaults].isLogin == NO) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *url = NSStringFormat(@"%@%@",kApiPrefix,kApi_userappPersonalCenter);
    
    [[WebServiceTool shareHelper] checkLoginWithURLString:url parameters:params success:^(id  _Nonnull responseObject) {
    } failure:^(NSError * _Nonnull error) {
        [[GVUserDefaults standardUserDefaults] cleanInfos];
        [self.mainTabbar.tabBar removeBadgeAtIndex:3];
        self.mainTabbar.selectedIndex = 0;
    }];
}

#pragma mark --  tabBarDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    // 点击button
}

//未登录跳转
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
        return YES;
    
}

- (void)loginSuccess:(NSNotification *)text {
    self.mainTabbar.selectedIndex = [text.object[@"selectedIndex"] integerValue];
}


#pragma mark -- wxlogin and delegate

- (void)configWXLogin{
    [WXApi registerApp:kSocial_WX_ID enableMTA:YES];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([url.scheme isEqualToString:kSocial_WX_ID]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    else if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //支付宝钱包支付回调
            RDLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"aliPayNofi" object:@{@"resultDic":resultDic}];
        }];
        return YES;
    }
    else {
        return nil;
    }
}

- (void)onResp:(BaseResp *)resp{
    RDLog(@"%d",resp.errCode);
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp * rep = (SendAuthResp *)resp;
        if (rep.errCode == 0) {
            RDLog(@"成功%@",rep.code);
            [[NSNotificationCenter defaultCenter]postNotificationName:WXAuthSuccess object:@{@"code":rep.code}];
        }else{
            RDLog(@"失败");
        }
    }
    else if ([resp isKindOfClass:[PayResp class]]) {
        RDLog(@"微信支付回调");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"wechatPayNofi" object:@{@"resultDic":resp}];
    }
    else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        RDLog(@"微信分享回调");
        [[NSNotificationCenter defaultCenter]postNotificationName:WXShareSuccess object:nil];
    }
    else{
        RDLog(@"失败");
    }
}

- (void)onLog:(NSString *)log logLevel:(WXLogLevel)level {
    RDLog(@"%@",log);
}

#pragma mark -- 购物车数量
- (void)getShopCartCount{
    __weak typeof(self) weakSelf = self;
    [[WebServiceTool shareHelper]getWithURLString:NSStringFormat(@"%@%@",kApiPrefix,kApi_findCartCount) parameters:@[] success:^(id  _Nonnull responseObject) {
        
        GetShopCarModel * model = [GetShopCarModel mj_objectWithKeyValues:responseObject];
        if ([model.code isEqualToString:@"0"]) {
            [GVUserDefaults standardUserDefaults].shopcartcount = model.result.cartCount;
            [weakSelf configTabBarController:self.mainTabbar];
        }else{
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//设置打开次数，并且评分评价
- (void)setLaunchCount {
    
}

//评分评论
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0){
    }else if (buttonIndex==1){
        //AppStore评论页面
        [[UIApplication sharedApplication]
         openURL:[NSURL URLWithString:URL_APPSTORE_REVIEW]];
    }
}

@end
