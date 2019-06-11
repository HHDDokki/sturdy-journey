//
//  UIButton+Badge.m
//  HWDMall
//
//  Created by sk on 2018/11/7.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import "UIButton+Badge.h"

@implementation UIButton (Badge)
- (void)setBadge:(NSString *)number andFont:(int)font{
    
    CGFloat width = self.bounds.size.width;
    
    
    
    
    UILabel *badge = [[UILabel alloc] initWithFrame:CGRectMake(width*3/4, -width/4, width/2, width/2)];
    int num = [number intValue];
    if (num >9 && num <99) {
        badge.frame = CGRectMake(width*3/4, -width/4, 20*SCALE_750, width/2);
    }else if(num >99){
        number = @"99+";
        badge.frame = CGRectMake(width*3/4, -width/4, 20*SCALE_750, width/2);
    }
    badge.text = number;
    badge.textColor = [UIColor colorWithHexString:@"#ED5E3B"];
    
    badge.textAlignment = NSTextAlignmentCenter;
    
    badge.font = [UIFont systemFontOfSize:font];
    
    badge.backgroundColor = [UIColor whiteColor];
    
    badge.layer.cornerRadius = width/4;
    
    badge.layer.masksToBounds = YES;
    badge.layer.borderWidth = 1;
    badge.layer.borderColor = [UIColor colorWithHexString:@"#ED5E3B"].CGColor;
    
    [self addSubview:badge];
    
}


-(void)setBadge:(NSString *)number andFont:(int)font cornerRadius:(CGFloat)cornerRadius{
    CGFloat width = self.bounds.size.width;
    
    for (UILabel *baL  in self.subviews) {
        if ([baL isKindOfClass:[UILabel class]]) {
            if ([baL.text isEqualToString:@"购物车"]) {
                
            }else{
                [baL removeFromSuperview];
            }
        }
        
    }
    
    UILabel *badge = [[UILabel alloc] initWithFrame:CGRectMake(width*8/13, width/8, width/3, width/3)];
    int num = [number intValue];
    
    
    if (num >9 && num <99) {
        badge.frame = CGRectMake(width*9/13, width/7, 15, 12);
        badge.layer.cornerRadius = 12/2;
    }else if(num >99){
        number = @"99+";
        badge.frame = CGRectMake(width*9/13, width/7, 21, 12);
        badge.layer.cornerRadius = 12/2;
    }else{
        badge.layer.cornerRadius = badge.height/2;
    }
    
    if (num == 0) {
        badge.layer.borderWidth = 0;
    }else{
        badge.text = number;
        badge.layer.borderWidth = 1;
    }
    
    badge.textColor = [UIColor whiteColor];
    
    badge.textAlignment = NSTextAlignmentCenter;
    
    badge.font = [UIFont systemFontOfSize:font];
    
    badge.backgroundColor = [UIColor whiteColor];
    
    badge.layer.masksToBounds = YES;
    
    badge.layer.borderColor = [UIColor colorWithHexString:@"#ED5E3B"].CGColor;
    
    badge.backgroundColor = [UIColor hexColor:@"#EB473A"];
    
    if (![number isEqualToString:@"0"]) {
        [self addSubview:badge];
    }
    
}



@end
