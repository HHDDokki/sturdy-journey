//
//  BaseModel.h
//  Alliance
//
//  Created by sk on 2018/7/18.
//  Copyright © 2018年 duyiwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCellDelegate.h"

@interface BaseTableViewCell : UITableViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id <BaseTableViewCellDelegate> basedelegate;
+ (NSString *)reuseIdentifier;
+ (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath;
@end
