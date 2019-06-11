//
//  TimedownModel.h
//  HWDMall
//
//  Created by stewedr on 2018/12/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BaseModel.h"

@interface TimedownModel : BaseModel

@property (nonatomic,copy) NSString *timedownSourceName;
@property (nonatomic,assign) BOOL isTimeout;


@end

