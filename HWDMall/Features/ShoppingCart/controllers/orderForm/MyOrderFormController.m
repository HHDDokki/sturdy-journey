//
//  MyOrderFormController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/26.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "MyOrderFormController.h"
#import "CAPSPageMenu.h" // 分栏
#import "OrderOfAllController.h" // 全部
#import "OrderWaitPayController.h" // 待付款
#import "OrderWaitShareController.h" // 待分享
#import "OrderConsignmentController.h" // 待发货
#import "OrderConsigneeController.h" // 待收货
#import "OrderAllController.h"

@interface MyOrderFormController ()
{
    CAPSPageMenu * _pagemenu; // 分栏页
}

@property (nonatomic,strong) NSMutableArray *controllerMuarr; // 控制器arr
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation MyOrderFormController

 - (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_pagemenu viewDidLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"我的订单"]];
    [self set_leftButton];
    [self set_navigationHeight];
    [self setNav];
    [self setUI];
}
#pragma mark -- lazyload
-  (NSMutableArray *)controllerMuarr{
    if (!_controllerMuarr) {
        _controllerMuarr = [[NSMutableArray alloc]init];
    }
    return _controllerMuarr;
}

#pragma mark -- setUI

- (UIButton *)set_leftButton{
     UIButton * leftBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [leftBtn setImage:GetImage(@"btn_nav_back") forState:UIControlStateNormal];
    return leftBtn;
}

- (void)setUI{
    OrderAllController * all = [[OrderAllController alloc]init];
    all.basecontroller = self;
    all.title = @"全部";
    all.hideNonet = YES;
    all.orderStatus = 0;
    
    OrderWaitPayController * waitpay = [[OrderWaitPayController alloc]init];
    waitpay.basecontroller = self;
    waitpay.title = @"待付款";
    waitpay.hideNonet = YES;
    waitpay.orderStatus = 1;
    
    OrderWaitShareController * waitshare = [[OrderWaitShareController alloc]init];
    waitshare.basecontroller = self;
    waitshare.title = @"待发货";
    waitshare.hideNonet = YES;
    waitshare.orderStatus = 3;

    OrderConsignmentController * consignent = [[OrderConsignmentController alloc]init];
    consignent.basecontroller = self;
    consignent.title = @"待收货";
    consignent.hideNonet = YES;
    consignent.orderStatus = 4;
    
    OrderConsigneeController * consignee = [[OrderConsigneeController alloc]init];
    consignee.basecontroller = self;
    consignee.title = @"已完成";
    consignee.hideNonet = YES;
    consignee.orderStatus = 6;


    [self.controllerMuarr addObject:all];
    [self.controllerMuarr addObject:waitpay];
    [self.controllerMuarr addObject:waitshare];
    [self.controllerMuarr addObject:consignent];
    [self.controllerMuarr addObject:consignee];
    NSDictionary *parameters = @{CAPSPageMenuOptionMenuItemSeparatorWidth: @(4.5),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(YES),
                                 CAPSPageMenuOptionMenuItemSeparatorPercentageHeight: @(0.1),
                                 CAPSPageMenuOptionMenuItemWidth:@(30),
                                 CAPSPageMenuOptionMenuItemSeparatorWidth:@(1000),
                                 CAPSPageMenuOptionMenuItemFont:kFont(14),
                                 CAPSPageMenuOptionSelectionIndicatorColor:[UIColor blackColor],
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor:UIColorFromHex(0x999999),
                                 CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor:UIColorFromHex(0x333333),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES)
                                 };

    _pagemenu = [[CAPSPageMenu alloc] initWithViewControllers:self.controllerMuarr frame:CGRectMake(0.0, kSafeAreaTopHeight, self.view.frame.size.width, self.view.frame.size.height + 20) options:parameters currentPageIndex:self.currentIndex];
    [_pagemenu moveToPage:self.currentIndex];
    [self.view addSubview:_pagemenu.view];
}
#pragma mark -- tableviewDelegate and DataSource
#pragma mark -- buttonAction

- (void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)set_navigationHeight{
    return kSafeAreaTopHeight;
}

- (void)setNav{
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    self.navigationItem.rightBarButtonItems = @[rightitem];
}

- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(0, 0, 22, 44);
        [_closeBtn setImage:IMAGE_NAME(@"关闭") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(clossAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
