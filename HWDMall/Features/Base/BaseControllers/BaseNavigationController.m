//
//  BaseNavigationController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/17.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 首页不需要隐藏tabbar
    NSString *ctrlName = NSStringFromClass([viewController class]);
    
    if ([ctrlName isEqualToString:@"ShoppingcartViewController"] ) {
        
        viewController.hidesBottomBarWhenPushed = NO;
        
    }else{
        // 其他push时需要隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这一句别忘记了啊
    [super pushViewController:viewController animated:animated];
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
