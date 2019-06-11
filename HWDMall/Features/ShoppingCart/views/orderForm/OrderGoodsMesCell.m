//
//  OrderGoodsMesCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderGoodsMesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OrderGoodsMesCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsname;
@property (weak, nonatomic) IBOutlet UILabel *goodsprice;
@property (weak, nonatomic) IBOutlet UILabel *goodsnum;

@property (weak, nonatomic) IBOutlet UILabel *goodsguige;
@end

@implementation OrderGoodsMesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)updateGoodsMesWithHeadImage:(NSString *)headerurl
                          Goodsname:(NSString *)goodsname
                         Goodsprice:(CGFloat)price
                         GoodsGuige:(NSString *)guige
                           GoodsNum:(NSInteger)goodsnum{
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:headerurl] placeholderImage:GetImage(@"taken_image_details_product")];
    self.goodsname.text = goodsname;
    self.goodsprice.text = NSStringFormat(@"￥%.2f",price);
    self.goodsguige.text = guige;
    self.goodsnum.text = NSStringFormat(@"x%ld",(long)goodsnum);
}

@end
