//
//  PaywayCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/24.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PaywayBlock)(Payway payway);
@interface PaywayCell : UITableViewCell
@property (nonatomic,copy) PaywayBlock payBlock;

@property (nonatomic,assign) BOOL titlehidden;


@end

NS_ASSUME_NONNULL_END
