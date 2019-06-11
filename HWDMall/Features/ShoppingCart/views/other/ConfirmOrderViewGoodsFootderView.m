//
//  ConfirmOrderViewGoodsFootderView.m
//  HWDMall
//
//  Created by stewedr on 2018/11/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmOrderViewGoodsFootderView.h"

@interface ConfirmOrderViewGoodsFootderView ()
@property (weak, nonatomic) IBOutlet UILabel *yunfeiLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsnumLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLbl;

@end

@implementation ConfirmOrderViewGoodsFootderView


- (void)updateFooterWithYunfei:(NSString *)yunfei GoodsNum:(NSString *)goodsnum GoodsPrice:(NSString *)goodsprice{
    self.yunfeiLbl.text = yunfei;
    self.goodsnumLbl.text = goodsnum;
    self.goodsPriceLbl.text = goodsprice;
}

@end
