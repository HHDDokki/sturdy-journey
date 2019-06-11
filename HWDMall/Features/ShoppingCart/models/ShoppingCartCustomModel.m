//
//  ShoppingCartCustomModel.m
//  HWDMall
//
//  Created by stewedr on 2018/11/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ShoppingCartCustomModel.h"
#import "ShoppingCartModel.h"

@implementation ShoppingCartCustomModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.shopGoodMuarr = [[NSMutableArray alloc]init];
        self.isUsable = YES;
    }
    return self;
}


@end
