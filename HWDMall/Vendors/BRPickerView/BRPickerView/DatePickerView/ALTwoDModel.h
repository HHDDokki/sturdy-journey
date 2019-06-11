//
//  ALTwoDModel.h
//  Alliance
//
//  Created by cxlf_ljd on 2018/8/15.
//  Copyright © 2018年 duyiwang. All rights reserved.
//

//自定义
#import <Foundation/Foundation.h>

@interface ALYearModel : NSObject

/** 对应的年份 */
@property(nonatomic ,copy) NSString *name;
/** 年份的索引 */
@property(nonatomic ,assign) NSInteger index;
/** 所处年的周数数组 */
@property(nonatomic ,strong) NSArray *weeks;

@end

@interface ALWeekModel : NSObject

/** 对应的周数 */
@property(nonatomic ,copy) NSString *name;
/** 周数的索引 */
@property(nonatomic ,assign) NSInteger index;

@property(nonatomic ,copy) NSString *timeDuan;

@end

