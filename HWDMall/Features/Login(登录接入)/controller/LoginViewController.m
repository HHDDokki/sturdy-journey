//
//  LoginViewController.m
//  BFMan
//
//  Created by HandC1 on 2019/5/30.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginUserModel.h"
#import <NSObject+YYModel.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.height.equalTo(100);
    }];
}

- (void)loadData {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[NSString stringWithFormat:@"EYamnI-2HPy1ftFfvXLox_iD-uF5Tk-cgEGd9rcknfkPHyb6N7ZFogHDuI1uBY-b6x3vXhoEBTd3shDLffOiwm-5tgByiO0-5P2kw22fCbMf5c8a89ae9ea0330c7b7"] forKey:@"st"];
    [param setValue:[NSString stringWithFormat:@"a89ae9ea0330c7b7"] forKey:@"bfcsid"];
    NSString *url = @"http://47.93.216.16:7081/login/mobileLogin.json";
    [[WebServiceTool shareHelper]postWithURLString:url parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"0"]) {
            
            LoginUserModel *model = [LoginUserModel modelWithJSON:responseObject[@"result"]];
            
            [GVUserDefaults standardUserDefaults].isLogin = YES;
            [GVUserDefaults standardUserDefaults].viptype = [model.isVip integerValue];
            if ([model.isVip integerValue] == 1) {
                [GVUserDefaults standardUserDefaults].isVip = YES;
                [GVUserDefaults standardUserDefaults].userType = Usertype_Member;
            } else {
                [GVUserDefaults standardUserDefaults].isVip = NO;
                [GVUserDefaults standardUserDefaults].userType = Usertype_Common;
            }
            [GVUserDefaults standardUserDefaults].userId = model.userId;
            [GVUserDefaults standardUserDefaults].outUserCode = model.outUserCode;
            [GVUserDefaults standardUserDefaults].nickname = model.nickname;
            [GVUserDefaults standardUserDefaults].headImg = model.headImg;
            
            [self. navigationController popViewControllerAnimated:NO];
//            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
            
//            if (self.selectedIndex > 0) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:@{@"selectedIndex":NSStringFormat(@"%ld", (long)self.selectedIndex)}];
//            }
            RDLog(@"======token  %@", [GVUserDefaults standardUserDefaults].token);
            [[ToolsManage getCurrentVC].view makeToast:@"登录成功"];
            
        } else if ([responseObject[@"code"] isEqualToString:@"10001"]) {
           
        } else if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            [self.view makeToast:responseObject[@"msg"]];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
}

@end
