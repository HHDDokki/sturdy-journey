//
//  BaseModel.h
//  Alliance
//
//  Created by sk on 2018/7/18.
//  Copyright © 2018年 duyiwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UITableView
@property(nonatomic,assign)BOOL showNoNumberView;//没有更多数据
@property (nonatomic, assign) BOOL numberViewSourceNum;//有无数据源
@property (nonatomic, copy) NSString *footerTitle;//没有更多数据显示文字

@end
