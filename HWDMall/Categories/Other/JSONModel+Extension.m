//
//  JSONModel+Extension.m
//  HWDMall
//
//  Created by HandC1 on 2018/11/15.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "JSONModel+Extension.h"

@implementation JSONModel (Extension)

+ (id)objectForModelObject:(id)object
                 withError:(NSError * __autoreleasing *)error {
    if ([object isKindOfClass:[NSDictionary class]]) {
        id currentObject = [[self alloc] initWithDictionary:object error:error];
        return currentObject;
    }
    else if ([object isKindOfClass:[NSArray class]]) {
        return [self arrayOfModelsFromDictionaries:object error:error];
    }
    return nil;
}

+ (id)objectByTraversingObject:(id)object
                     withError:(NSError * __autoreleasing *)error {
    id createdObject = [self objectForModelObject:object withError:error];
    if (createdObject) {
        return createdObject;
    }
    else if (!createdObject && [object isKindOfClass:[NSDictionary class]]) {
        for (id key in object) {
            id internalObject = [self objectForModelObject:object[key] withError:error];
            if (internalObject) {
                return internalObject;
            }
        }
    }
    return nil;
}

@end
