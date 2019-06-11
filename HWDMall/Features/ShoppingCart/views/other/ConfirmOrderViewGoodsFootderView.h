//
//  ConfirmOrderViewGoodsFootderView.h
//  HWDMall
//
//  Created by stewedr on 2018/11/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderViewGoodsFootderView : UITableViewHeaderFooterView

- (void)updateFooterWithYunfei:(NSString *)yunfei
                      GoodsNum:(NSString *)goodsnum
                    GoodsPrice:(NSString *)goodsprice;

@end


