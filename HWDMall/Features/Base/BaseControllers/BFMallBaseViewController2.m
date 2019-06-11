//
//  BFMallBaseViewController2.m
//  BFMan
//
//  Created by HandC1 on 2019/5/21.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallBaseViewController2.h"
typedef enum{
    NO_PARAM = 0,                //直接登录
}OPEN_LOGIN_PAGE_TYPE;
#define NAV_H self.navigationController.navigationBar.height+kTOP_BAR_HEIGHT
static dispatch_queue_t _concurrentQueue;

@interface BFMallBaseViewController2 ()

@end

@implementation BFMallBaseViewController2

@synthesize shouldShowErr = _shouldShowErr;

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self judgeControllerCounts];
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController.navigationBar setTranslucent:NO];
    self.shouldShowErr = YES;
}

// 设置导航栏
- (void)setNavigationView {
    
    self.navigationView = [[UIView alloc] init];
    self.navigationView.frame = CGRectMake(0,0,SCREEN_W, kSafeAreaTopHeight);
    self.navigationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navigationView];
    
}

- (void)setNavigationBottomLine {
    
    self.navigationKeyline = [[UIView alloc] init];
    self.navigationKeyline.frame =
    CGRectMake(0,NAV_H-PX(1),SCREEN_W,PX(1));
    self.navigationKeyline.backgroundColor = [UIColor hexColor:@"#dddddd"];
    [self.navigationView addSubview:self.navigationKeyline];
    
}

// 设置标题
- (void)setNavigationTitle {
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(75, kTOP_BAR_HEIGHT, SCREEN_W-152,self.navigationView.height-kTOP_BAR_HEIGHT);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    //    self.titleLabel.font = [UIFont fontWithName:@"苹方-简 常规体" size:19*SCALE_750];
    self.titleLabel.font = kFont(19*SCALE_750);
    self.titleLabel.text = self.title;
    [self.navigationView addSubview:self.titleLabel];
    
}

// 设置返回按钮
- (void)setNavigationBackButton {
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(0, kTOP_BAR_HEIGHT, viewX(50), self.navigationView.height-kTOP_BAR_HEIGHT);
    [self.backButton setImage:IMAGE_NAME(@"btn_nav_back") forState:UIControlStateNormal];
    //    [button setImage:IMAGE_NAME(@"details_nav_icon_back_normal") forState:UIControlStateHighlighted];
    [self.backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:self.backButton];
    
}

// 返回
- (void)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//登录页面
- (void)loginWithFromPage:(OPEN_LOGIN_PAGE_TYPE)pageType {
    
    //登录界面
    UIViewController *vc = [[UIViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:NO completion:nil];
    
}

// 没有网络页面
- (void)addNoNetworkView {
    self.nonetworkView = [[UIView alloc] init];
    self.nonetworkView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    self.nonetworkView.backgroundColor = [UIColor hexColor:@"#efefef"];
    [self.view addSubview:self.nonetworkView];
    
    UIImage *image = [UIImage imageNamed:@"logo_icon"];
    CGFloat img_h = 140*image.size.height/image.size.width;
    UIImageView *logo = [[UIImageView alloc] initWithImage:image];
    logo.frame = CGRectMake((SCREEN_W - 140)/2, SCREEN_H/3 - 25, 140, img_h);
    [self.nonetworkView addSubview:logo];
    
    self.nonetworkRemindLabel = [[UILabel alloc] init];
    self.nonetworkRemindLabel.frame = CGRectMake(0, SCREEN_H/2, SCREEN_W, 25);
    self.nonetworkRemindLabel.backgroundColor = [UIColor clearColor];
    self.nonetworkRemindLabel.font = [UIFont systemFontOfSize:16];
    self.nonetworkRemindLabel.textAlignment = NSTextAlignmentCenter;
    self.nonetworkRemindLabel.text = @"您现在网络不佳,请确认是否联网!";
    self.nonetworkRemindLabel.textColor = [UIColor hexColor:@"#999999"];
    [self.nonetworkView addSubview:self.nonetworkRemindLabel];
    
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    reloadButton.frame = CGRectMake((SCREEN_W - 180)/2, SCREEN_H/2 + 50, 180, 40);
    reloadButton.layer.cornerRadius = 20;
    reloadButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    reloadButton.backgroundColor = [UIColor redColor];
    [reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reloadButton addTarget:self action:@selector(nonetworkViewReloadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.nonetworkView addSubview:reloadButton];
}

// 重新加载
- (void)nonetworkViewReloadButtonClicked {
    //    //三个点btn
    //    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [moreBtn setImage:[UIImage imageNamed:@"details_nav_icon_more_normal"] forState:UIControlStateNormal];
    //    moreBtn.frame = CGRectMake(kScreenWidth - viewX(58), kTOP_BAR_HEIGHT, viewX(50), self.naviHeight-kTOP_BAR_HEIGHT);
    //    [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    //    //        [leftBtn setEnlargedMargin:ceil((10/kiPhone6Width * kScreenWidth))];
    //    [self.navi addSubview:moreBtn];
    //
    //    //    分享
    //    UIButton *fenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [fenBtn setImage:[UIImage imageNamed:@"details_nav_icon_share_normal"] forState:UIControlStateNormal];
    //    fenBtn.frame = CGRectMake(kScreenWidth - viewX(116), kTOP_BAR_HEIGHT, viewX(50), self.naviHeight-kTOP_BAR_HEIGHT);
    //    [fenBtn addTarget:self action:@selector(fenClick) forControlEvents:UIControlEventTouchUpInside];
    //    //        [leftBtn setEnlargedMargin:ceil((10/kiPhone6Width * kScreenWidth))];
    //    [self.navi addSubview:fenBtn];
}

// 显示请求转圈
- (void)showHUD {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.view makeToastActivity];

    });
    
}

// 取消请求转圈
- (void)hideHUD {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view hideToastActivity];
    });
    
}

// 请求数据返回error时的操作
- (BOOL)isErrorResponse:(NSDictionary *)responseObject {
    
    if(![responseObject isKindOfClass:[NSDictionary class]]) {
        if (self.shouldShowErr) {
            self.shouldShowErr = NO;
            [self showDataErrorAlert];
        }
        return YES;
    }
    if (![responseObject[@"code"] isEqualToString:@"0"]) {
        
        NSString *errorMsg = [responseObject objectForKey:@"msg"];
        if (self.shouldShowErr) {
            self.shouldShowErr = NO;
            [self.view makeToast:errorMsg];
        }
        
        return YES;
    }
    return NO;
}

- (BOOL)isErrorResponseWithStyle:(NSDictionary *)responseObject {
//        if ([responseObject[@"response"] isEqualToString:@"error"]) {
//            NSString *errorMsg = [[responseObject objectForKey:@"error"] objectForKey:@"text"];
//            if(errorMsg.length > 0) {
//                if ([[responseObject stringForKey:@"style"] isEqualToString:@"1"]) {
//                    [HHDCommonUtil showAlert:errorMsg Target:self Tag:0];
//                }else if ([[responseObject stringForKey:@"style"] isEqualToString:@"2"]) {
//                    [HHDCommonUtil showToast:errorMsg];
//                }
//            }
//            return YES;
//        }
    return NO;
}

- (void)setNavigationSearchBarForShop {
    
    //    CGFloat content_h = kSafeAreaTopHeight - 20;
    //    UIView *contentView = [[UIView alloc] init];
    //    contentView.frame = CGRectMake(46*SCALE_750, 0, 283*SCALE_750,content_h);
    //    contentView.backgroundColor = [UIColor redColor];
    //    [self.navigationView addSubview:contentView];
    //
    self.searchButton = [[UIButton alloc] initWithFrame:CGRectMake(285*SCALE_750, kTOP_BAR_HEIGHT+2*SCALE_750, viewX(50), self.navigationView.height-kTOP_BAR_HEIGHT - 2*SCALE_750)];
    self.searchButton.centerY = self.backButton.centerY;
    [self.searchButton setImage:IMAGE_NAME(@"shop_search_small") forState:UIControlStateNormal];
    [self.navigationView addSubview:self.searchButton];
    
    
    self.searchBar = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBar.frame =
    CGRectMake(46*SCALE_750,kTOP_BAR_HEIGHT+9*SCALE_750,283*SCALE_750,32*SCALE_750);
    self.searchBar.centerY = self.backButton.centerY;
    self.searchBar.backgroundColor = [UIColor hexColor:@"#ececec"];
    self.searchBar.titleLabel.font = kFont(13*SCALE_750);
    
    self.searchBar.hidden = NO;
    NSString *temp_s = @"";
    NSString *btn_title = (temp_s && temp_s.length)? temp_s:@"搜索店内商品";
    UILabel *search_label = [[UILabel alloc] initWithFrame:CGRectMake(42*SCALE_750, 0, 200*SCALE_750, 32*SCALE_750)];
    search_label.text = btn_title;
    search_label.textAlignment = NSTextAlignmentLeft;
    search_label.textColor = [UIColor hexColor:@"#BFBFBF"];
    search_label.font = kFont(14*SCALE_750);
    [self.searchBar addSubview:search_label];
    [UIBezierPath bezierRoundView:self.searchBar withRadii:CGSizeMake(16, 16)];
    [self.navigationView addSubview:self.searchBar];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:IMAGE_NAME(@"shop_search_inbar")];
    icon.frame = CGRectMake(21*SCALE_750, 9*SCALE_750, 15*SCALE_750, 15*SCALE_750);
    [self.searchBar addSubview:icon];
    
}

- (void)setNavigationShareButton {
    
    self.shareButton = [[UIButton alloc] initWithFrame:CGRectMake(322*SCALE_750, kTOP_BAR_HEIGHT+2*SCALE_750, viewX(50), self.navigationView.height-kTOP_BAR_HEIGHT)];
    self.shareButton.centerY = self.backButton.centerY;
    [self.shareButton setImage:IMAGE_NAME(@"shop_share") forState:UIControlStateNormal];
    [self.navigationView addSubview:self.shareButton];
    
}

- (void)showNetworkErrorAlert {
    
    [self.view makeToast:@"您现在网络不佳，请确认是否联网"];
}

- (void)showDataErrorAlert {
    
    [self.view makeToast:@"数据解析错误"];
}

// 退出
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//
//    [self.navigationController popViewControllerAnimated:NO];
//
//}

- (instancetype)init
{
    if (self = [super init]) {
        _concurrentQueue = dispatch_queue_create("com.person.syncQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (BOOL)shouldShowErr {
    
    static BOOL tShouldShowErr;
    dispatch_sync(_concurrentQueue, ^{
        tShouldShowErr = self->_shouldShowErr;
    });
    return tShouldShowErr;
    
}

- (void)setShouldShowErr:(BOOL)shouldShowErr {
    
    dispatch_barrier_async(_concurrentQueue, ^{
        
        self->_shouldShowErr = shouldShowErr;
        
    });
    
}

- (void)judgeControllerCounts{
    if (self.navigationController.childViewControllers.count == 1) {
        //        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.backButton.hidden = YES;
        self.navigationController.navigationBar.hidden = YES;
    }else{
        //        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        self.backButton.hidden = NO;
        self.navigationController.navigationBar.hidden = YES;
    }
}
@end
