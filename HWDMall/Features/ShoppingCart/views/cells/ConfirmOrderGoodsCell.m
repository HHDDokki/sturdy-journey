//
//  ConfirmOrderGoodsCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/17.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmOrderGoodsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ConfirmOrderGoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsHead;
@property (weak, nonatomic) IBOutlet UILabel *goodsname;
@property (weak, nonatomic) IBOutlet UILabel *goodsguige;
@property (weak, nonatomic) IBOutlet UILabel *goodsprice;
@property (weak, nonatomic) IBOutlet UILabel *goodsnum;

@end

@implementation ConfirmOrderGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellMesWithHeadUrl:(NSString *)goodshead GoodsName:(NSString *)goodsname GoodsGuige:(NSString *)goodsguige GoodsPrice:(NSString *)goodsprice GoodsNum:(NSString *)goodsnum{
    
    [self.goodsHead sd_setImageWithURL:[NSURL URLWithString:goodshead] placeholderImage:GetImage(@"taken_image_details_product")];
    
    self.goodsname.text = goodsname;
    self.goodsguige.text = goodsguige;
    self.goodsnum.text = goodsnum;
    self.goodsprice.text = goodsprice;
}

@end
