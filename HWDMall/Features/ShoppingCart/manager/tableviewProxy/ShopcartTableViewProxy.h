//
//  ShopcartTableViewProxy.h
//  HWDMall
//
//  Created by stewedr on 2018/11/8.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UpdateTotalPriceModel.h"

typedef void(^ShopcartProxyProductSelectBlock)(BOOL isSelected, NSIndexPath *indexPath); // 选中一行
typedef void(^ShopcartProxyBrandSelectBlock)(BOOL isSelected, NSInteger section); // 选中一组
typedef void(^ShopcartProxyChangeCountBlock)(NSInteger count, NSIndexPath *indexPath); // 改变商品数量
typedef void(^ShopcartProxyDeleteBlock)(NSIndexPath *indexPath); // 删除
typedef void(^ShopcartProxyDeleteUnuseBlock)(void); // 清空失效商品
typedef void(^ShopcartProxyCellSelectedBlock)(NSIndexPath *indexPath); // 点击某一行
typedef void(^ShopcartProxyCellSelectedShopBlock)(NSInteger section); // 点击店铺
typedef void(^ShopcartProxyCellSelectedVIPBlock)(BOOL state);

typedef void(^ShopcartProxyCellSelectedAllBlock)(BOOL btnStatus); // 全选


@interface ShopcartTableViewProxy : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UpdateTotalResultModel *resultModel;
@property (nonatomic, copy) ShopcartProxyProductSelectBlock shopcartProxyProductSelectBlock;
@property (nonatomic, copy) ShopcartProxyBrandSelectBlock shopcartProxyBrandSelectBlock;
@property (nonatomic, copy) ShopcartProxyChangeCountBlock shopcartProxyChangeCountBlock;
@property (nonatomic, copy) ShopcartProxyDeleteBlock shopcartProxyDeleteBlock;
@property (nonatomic,copy) ShopcartProxyDeleteUnuseBlock deleteUnuseBlock;// 删除不可用
@property (nonatomic,copy) ShopcartProxyCellSelectedBlock selectedBlock; // 点击某一行
@property (nonatomic,copy) ShopcartProxyCellSelectedShopBlock selectShopBlock; // 点击店铺

@property (nonatomic,copy) ShopcartProxyCellSelectedVIPBlock selectVipBlock;
@property (nonatomic,copy) ShopcartProxyCellSelectedAllBlock selectAllBlock; //全选

@end
