//
//  BaseModel.m
//  HWDMall
//
//  Created by stewedr on 2018/12/4.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if ([oldValue isEqual: [NSNull null]]) {
        
        if ([oldValue isKindOfClass:[NSArray class]]) {
            
            return  @[];
            
        }else if([oldValue isKindOfClass:[NSDictionary class]]){
            
            return @{};
            
        }else{
            
            return @"";
            
        }
        
    }
    
    return oldValue;
    
}
@end
