//
//  BFMallGoodsDetailManager.m
//  BFMan
//
//  Created by HandC1 on 2019/5/24.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallGoodsDetailManager.h"
#import "BFMallGoodsDetailMainDescView.h"
#import "XHWebImageAutoSize.h"

//Model
#import "BFMallGoodsDetailModel.h"

#import <SDWebImage/UIImageView+WebCache.h>

#define SPACE 7
@interface BFMallGoodsDetailManager ()<UIScrollViewDelegate, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *scroll_product_header;
@property (nonatomic, strong) UILabel *proporLabel;
@property (nonatomic, strong) BFMallGoodsDetailMainDescView *namePriceStrip;
@property (nonatomic, strong) UIView *topImgView;
@property (nonatomic, strong) NSMutableArray *modelArr;

//Model
@property (nonatomic, strong) BFMallGoodsDetailModel *productModel;

@end

@implementation BFMallGoodsDetailManager

- (void)configWithModel:(NSMutableArray *)modelArr {
    self.modelArr = modelArr;
    self.productModel = modelArr[0];
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    
    if (index > 1) {
        return [self createDetailImageViewWithIndex:index].height;
    }
    
    switch (index) {
        case 0:
            return SCREEN_W;
            break;
        case 1:
            return [self setupNamePriceView].height;
            break;
        default:
            break;
    }
    return 0;
    
}

//根据身份与商品属性显示正确底部按钮
- (int)getBottomBtnType{
    return 1;
}

#pragma mark - 产品滚动头图（横向）
- (UIView *)setupHeaderScroll {
    
    if (self.topImgView) {
        return self.topImgView;
    }
    
    self.topImgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 0)];
    self.scroll_product_header.contentSize = CGSizeMake(SCREEN_W * self.productModel.imgUrls.count, SCREEN_W);
    self.scroll_product_header.backgroundColor = [UIColor hexColor:@"#EEEEEE"];
    [self.topImgView addSubview:self.scroll_product_header];
    
    for (NSUInteger i = 0; i < self.productModel.imgUrls.count; i++) {
        
        NSString *imageUrl = self.productModel.imgUrls[i];
        NSUInteger index = i;
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:URL_STR(imageUrl) placeholderImage:IMAGE_NAME(@"taken_image_details_shop")];
        //            [imageView sd_setImageWithURL:URL_STR(imageUrl) placeholderImage:IMAGE_NAME(@"oneToOne_default")];
        imageView.frame = CGRectMake(0+SCREEN_W*(CGFloat)index, 0, SCREEN_W, SCREEN_W);
        [self.scroll_product_header addSubview:imageView];
        
        //大图点击按钮添加
        UIButton *btn_image_tap = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_image_tap.frame = imageView.frame;
        btn_image_tap.tag = 200 + index;
        [btn_image_tap addTarget:self action:@selector(pictureClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll_product_header addSubview:btn_image_tap];
    }
    
    self.proporLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W-51, self.scroll_product_header.bottom-28, 33, 14)];
    self.proporLabel.backgroundColor = [UIColor hexColor:@"#787D84"];
    self.proporLabel.alpha = 0.6;
    self.proporLabel.textColor = [UIColor whiteColor];
    self.proporLabel.textAlignment = NSTextAlignmentCenter;
    self.proporLabel.font = kFont(8);
    self.proporLabel.text = [NSString stringWithFormat:@"1/%lu",self.productModel.imgUrls.count];
    [UIBezierPath bezierRoundView:self.proporLabel withRadii:CGSizeMake(9, 9)];
    [self.topImgView addSubview:self.proporLabel];
    self.topImgView.height = self.scroll_product_header.bottom+36;
    
    return self.topImgView;
    
}

#pragma mark - 商品名称，活动介绍，价格 View块
- (UIView *)setupNamePriceView {

    if (self.namePriceStrip) {
        return self.namePriceStrip;
    }
    self.namePriceStrip = [[BFMallGoodsDetailMainDescView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 0) proModel:self.productModel];
    
    [self.namePriceStrip.buyVipBtn addTarget:self
                                      action:@selector(beVipClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.namePriceStrip.height, SCREEN_W, SPACE)];
    lineView.backgroundColor = [UIColor hexColor:@"#EEEEEE"];
    [self.namePriceStrip addSubview:lineView];
    self.namePriceStrip.height = lineView.bottom;
    return self.namePriceStrip;
    
}

- (UIImageView *)createDetailImageViewWithIndex:(NSInteger)index {
    
    CGFloat y = 40*SCALE_750;
    if (index != 2) {
        y = 0.0;
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, SCREEN_W, 0)];
    //    float imgH = 45.0;
    float imgHH = 0.0;
    imgHH = [XHWebImageAutoSize imageHeightForURL:URL_STR(self.productModel.imgDetail[index - 2]) layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:1];

    //    imgH = imgH + imgHH;
    imageView.height = imgHH;
    NSString *strUrl = self.productModel.imgDetail[index-2];
    WK(weakSelf);
    [imageView sd_setImageWithURL:URL_STR(strUrl) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        /** 缓存image size */
        [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
            /** reload  */
            if(result)  [weakSelf.baseController.mainTable xh_reloadDataForURL:imageURL];
        }];
    }];
    return imageView;
}

#pragma mark - 大图滚动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _scroll_product_header) {
        if ((int)(scrollView.contentOffset.x / SCREEN_W + 1) == 0) {
            self.proporLabel.text = [NSString stringWithFormat:@"%d/%lu", 1,(unsigned long)self.productModel.imgUrls.count];
        }else {
            self.proporLabel.text = [NSString stringWithFormat:@"%d/%lu", (int)(scrollView.contentOffset.x / SCREEN_W + 1),(unsigned long)self.productModel.imgUrls.count];
        }
    }
    
}

#pragma mark -- buttonClicked
//大图点击事件
- (void)pictureClick:(UIButton *)sender {
    NSInteger index = sender.tag - 200;
    
    if (self.pictureBlock) {
        self.pictureBlock(index, self.productModel.imgUrls);
    }
}

- (void)beVipClick:(UIButton *)sender {
    
    if (self.toBeVipBlock) {
        self.toBeVipBlock();
    }

}


#pragma mark -- lazyload
- (NSMutableArray *)modelArr {
    
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
    
}

- (UIScrollView *)scroll_product_header {
    
    if (!_scroll_product_header) {
        _scroll_product_header = [[UIScrollView alloc] init];
        _scroll_product_header.backgroundColor = [UIColor whiteColor];
        _scroll_product_header.pagingEnabled = YES;
        _scroll_product_header.delegate = self;
        _scroll_product_header.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_W);
        _scroll_product_header.showsVerticalScrollIndicator = NO;
        _scroll_product_header.showsHorizontalScrollIndicator = NO;
    }
    return _scroll_product_header;
}


@end
