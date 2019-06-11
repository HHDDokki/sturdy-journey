//
//  BaseModel.h
//  Alliance
//
//  Created by sk on 2018/7/18.
//  Copyright © 2018年 duyiwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseTableViewCellDelegate <NSObject>
@optional
- (void)baseTableViewCellTextDidChanged:(NSString *)text indexPath:(NSIndexPath *)cellIndexPath;

@end
