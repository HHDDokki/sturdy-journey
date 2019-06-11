//
//  OrderGoodsCollectionCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderGoodsCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OrderGoodsCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@end

@implementation OrderGoodsCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.goodsImage.layer.cornerRadius = 20;
//    self.goodsImage.layer.masksToBounds = YES;
    
}

- (void)setImgeurlStr:(NSString *)imgeurlStr{
    if (_imgeurlStr != imgeurlStr) {
        _imgeurlStr = imgeurlStr;
    }
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:imgeurlStr] placeholderImage:GetImage(@"taken_image_details_product")];
//    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:imgeurlStr] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        RDLog(@"错误信息:%@,%@",error,imageURL);
//    }];
}

@end
