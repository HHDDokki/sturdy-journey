//
//  ShoppingcartUnusebleHeader.m
//  HWDMall
//
//  Created by stewedr on 2018/11/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ShoppingcartUnusebleHeader.h"

@implementation ShoppingcartUnusebleHeader
- (IBAction)DeleteAllGoods:(id)sender {
    RDLog(@"清除...");
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}


@end
