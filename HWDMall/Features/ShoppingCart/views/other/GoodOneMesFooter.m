//
//  GoodOneMesFooter.m
//  HWDMall
//
//  Created by stewedr on 2018/12/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "GoodOneMesFooter.h"

@interface GoodOneMesFooter()
@property (weak, nonatomic) IBOutlet UILabel *goodscountLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodPriceLbl;

@end

@implementation GoodOneMesFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)updateMesWithGoodsCount:(NSString *)goodscount GoodsPrice:(NSString *)goodprice{
    self.goodscountLbl.text = goodscount;
    self.goodPriceLbl.text = goodprice;
}
@end
