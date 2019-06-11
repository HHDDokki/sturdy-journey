//
//  NSLayoutConstraint+IBDesignable.m
//  HWDMall
//
//  Created by HandC1 on 2019/1/22.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "NSLayoutConstraint+IBDesignable.h"

@implementation NSLayoutConstraint (IBDesignable)

- (void)setAdapterScreen:(BOOL)adapterScreen{
    
    if (adapterScreen){
        self.constant = self.constant * KsuitParam;
    }
}

- (BOOL)adapterScreen{
    return YES;
}

@end
