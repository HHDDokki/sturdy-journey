//
//  ConfirmOrderParam.m
//  HWDMall
//
//  Created by HandC1 on 2018/12/8.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmOrderParam.h"

#define key_ordertype @"orderType"
#define key_buyType @"buyType"
#define key_sku @"sku"
#define key_quantity @"quantity"
#define key_addressId @"addressId"
#define key_couponId @"couponId"
#define key_useCoin @"useCoin"
#define key_foundId @"foundId"
#define key_activityId @"activityId"

@implementation ConfirmOrderParam

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.attributeDic= [[NSMutableDictionary alloc] init];
        
    }
    return self;
}


- (void)setAttribute:(id)aobj forKey:(id)akey{
    assert(akey!=nil);
    if(aobj==nil){
        [self.attributeDic removeObjectForKey:akey];
    }else{
        [self.attributeDic setObject:aobj forKey:akey];
    }
}


- (id)attributeForKey:(id)akey{
    
    return [self.attributeDic objectForKey:akey];
    
}

- (void)setAllProperValueExceptPayWay {
    
    [self.attributeDic removeAllObjects];
    [self.attributeDic setValue:[NSNumber numberWithInt:_ordertype] forKey:key_ordertype];
    [self.attributeDic setValue:[NSNumber numberWithInt:_buytype] forKey:key_buyType];
    [self.attributeDic setValue:[NSNumber numberWithInteger:_sku] forKey:key_sku];
    [self.attributeDic setValue:[NSNumber numberWithInteger:_quantity] forKey:key_quantity];
    if (_addressId) {
        [self.attributeDic setValue:[NSNumber numberWithInteger:_addressId] forKey:key_addressId];
    }
    [self.attributeDic setValue:[NSNumber numberWithInteger:_grouponId] forKey:key_couponId];
    [self.attributeDic setValue:[NSNumber numberWithInteger:_usecoin] forKey:key_useCoin];
    [self.attributeDic setValue:[NSNumber numberWithInteger:_foundId] forKey:key_foundId];
    [self.attributeDic setValue:[NSNumber numberWithInteger:_activity] forKey:key_activityId];
    
}

- (void)setAllProperValueWithPayWay {
    
    [self setAllProperValueExceptPayWay];
    [self.attributeDic setValue:[NSNumber numberWithInt:_payType] forKey:@"paymentMethod"];
}

@end
