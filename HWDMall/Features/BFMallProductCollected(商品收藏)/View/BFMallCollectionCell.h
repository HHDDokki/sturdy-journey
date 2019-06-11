//
//  BFMallCollectionCell.h
//  HWDMall
//
//  Created by HandC1 on 2019/6/2.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMallCollectionModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectedBtnBlock)(BOOL btnStatus);

@interface BFMallCollectionCell : UITableViewCell

@property (nonatomic,copy) SelectedBtnBlock selectedBlock;

- (void)bindModel:(BFMallCollectionDetailModel *)model;
- (void)stateChangeWithState:(BOOL)state;

@end

NS_ASSUME_NONNULL_END
