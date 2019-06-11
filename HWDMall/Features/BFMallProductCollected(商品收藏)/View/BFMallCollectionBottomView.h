//
//  BFMallCollectionBottomView.h
//  HWDMall
//
//  Created by HandC1 on 2019/6/2.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DeleteBlock)(void);

@interface BFMallCollectionBottomView : UIView

@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic,copy) DeleteBlock deleteBlock;

@end

NS_ASSUME_NONNULL_END
