//
//  JSONModel+Extension.h
//  HWDMall
//
//  Created by HandC1 on 2018/11/15.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSONModel (Extension)

+ (id)objectForModelObject:(id)object withError:(NSError * __autoreleasing *)error;
+ (id)objectByTraversingObject:(id)object withError:(NSError * __autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
