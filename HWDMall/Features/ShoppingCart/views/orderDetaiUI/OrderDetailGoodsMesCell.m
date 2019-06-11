//
//  OrderDetailGoodsMesCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderDetailGoodsMesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OrderDetailGoodsMesCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsGuige;
@property (weak, nonatomic) IBOutlet UILabel *tuikuan;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsCount;

@end

@implementation OrderDetailGoodsMesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellMesWithGoodsImge:(NSString *)goodsimage GoodsName:(NSString *)goodsname GoodsGuige:(NSString *)guige GoodsPrice:(NSString *)goodsprice GoodsCount:(NSString *)count TuikanStatus:(NSString *)tuikuanstatus{
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:goodsimage] placeholderImage:GetImage(@"taken_image_details_product")];
    self.goodsName.text = goodsname;
    self.goodsGuige.text = guige;
    self.goodsPrice.text = goodsprice;
    self.goodsCount.text = count;
    self.tuikuan.text = tuikuanstatus;
}

@end
