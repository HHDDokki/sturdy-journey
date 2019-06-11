//
//  MemberModel.m
//  HWDMall
//
//  Created by HandC1 on 2018/11/1.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "MemberModel.h"

@interface MemberModel ()


@end

@implementation MemberModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"dtoList" : @"SaveMemberModel",
             };
}

//- (CGFloat)cellHeight{
//    
//    NSArray *arr = @[@"1", @"2", @"3"];
//    CGFloat textH = arr.count *50*SCALE_750;
//    _cellHeight = 92*SCALE_750 +textH + 125*SCALE_750;
//    
//    return _cellHeight;
//}

@end


@implementation SaveMemberModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

@end

@implementation PriceModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end


