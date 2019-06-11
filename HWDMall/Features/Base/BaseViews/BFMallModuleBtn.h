//
//  BFMallModuleBtn.h
//  BFMan
//
//  Created by HandC1 on 2019/5/22.
//  Copyright © 2019 HYK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFMallModuleBtn : UIButton

@property (nonatomic, strong) NSString *pageType;
@property (nonatomic, strong) NSString *pageParam;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *modulePosition;
@property (nonatomic, strong) NSString *detailPosition;

@end

NS_ASSUME_NONNULL_END
