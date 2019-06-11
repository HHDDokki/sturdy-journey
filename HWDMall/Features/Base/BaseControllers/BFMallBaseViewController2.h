//
//  BFMallBaseViewController2.h
//  BFMan
//
//  Created by HandC1 on 2019/5/21.
//  Copyright © 2019 HYK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMallBaseViewController2 : UIViewController <UIAlertViewDelegate>

//搜索框
@property (nonatomic, strong) UIButton *searchBar;
//搜索按钮
@property (nonatomic, strong) UIButton *searchButton;
//分享按钮
@property (nonatomic, strong) UIButton *shareButton;
//返回按钮
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIView  *nonetworkView;
@property (nonatomic, strong) UILabel *nonetworkRemindLabel;
//导航条
@property (nonatomic, strong) UIView *navigationView;
//导航条背景
@property (nonatomic, strong) UIImageView *navigationBackImageView;
//导航条下部分割线
@property (nonatomic, strong) UIView *navigationKeyline;

//统计相关
@property (nonatomic, strong) NSString *refValue;
@property (nonatomic, strong) NSString *refBIParam;
@property (nonatomic, strong) NSString *objectParameter;

//title
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *hhd_title;


@property (assign) BOOL shouldShowErr;


// 导航到相应的页面
//- (void)openViewWithType:(NSString *)type param:(NSString *)param;

// 设置导航栏
- (void)setNavigationView;

// 设置标题
- (void)setNavigationTitle;

//设置底部分割线
- (void)setNavigationBottomLine;

// 设置返回按钮
- (void)setNavigationBackButton;
//- (void)backButtonClicked:(id)sender;

// 设置搜索框
- (void)setNavigationSearchBarForShop;

// 设置导航条分享按钮
- (void)setNavigationShareButton;

// 没有网络页面
- (void)addNoNetworkView;

// 重新加载
- (void)nonetworkViewReloadButtonClicked;

// 显示请求转圈
- (void)showHUD;

// 取消请求转圈
- (void)hideHUD;

// 请求数据返回error时的操作
- (BOOL)isErrorResponse:(NSDictionary *)responseObject;
- (BOOL)isErrorResponseWithStyle:(NSDictionary *)responseObject;

- (void)showNetworkErrorAlert;
- (void)showDataErrorAlert;


- (void)backButtonClicked:(id)sender;

@end
