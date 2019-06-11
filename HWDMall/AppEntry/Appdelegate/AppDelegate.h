//
//  AppDelegate.h
//  HWDMall
//
//  Created by stewedr on 2018/10/16.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSMutableArray *browserRecordArray;
@property (nonatomic,strong) CYLTabBarController * mainTabbar;

@end

