//
//  BFMallGoodsDetailMainDescView.m
//  BFMan
//
//  Created by HandC1 on 2019/5/24.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallGoodsDetailMainDescView.h"
#import "BFMallGoodsDetailModel.h"
@interface BFMallGoodsDetailMainDescView ()

@property (nonatomic, strong) BFMallGoodsDetailModel *proModel;

//@property (nonatomic, strong) UILabel *minPriceLabel;
//@property (nonatomic, strong) UIView *vipView;
//@property (nonatomic, strong) UIView *promView;

@end

@implementation BFMallGoodsDetailMainDescView

- (instancetype)initWithFrame:(CGRect)frame proModel:(BFMallGoodsDetailModel *)proModel
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.proModel = proModel;
        [self creatMainView];
        
    }
    return self;
}

- (void)creatMainView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat top = 6;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 6, 343, 42)];
    nameLabel.text = self.proModel.goodsName;
    nameLabel.numberOfLines = 3;
    nameLabel.font = kFont(16);
    nameLabel.textColor = [UIColor hexColor:@"#333333"];
    [nameLabel resizeLabelVertical];
    [self addSubview:nameLabel];
    
    top = nameLabel.bottom + 18;
    
    UILabel *minPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, top, 300, 10)];
    minPriceLabel.text = NSStringFormat(@"商品价 : ¥%.2f",self.proModel.maxPrice);
    minPriceLabel.font = kBoldFont(10);
    [self addSubview:minPriceLabel];
    
    top = minPriceLabel.bottom + 5;
    
    UIImageView *vipImage = [[UIImageView alloc] init];
    [vipImage setImage:IMAGE_NAME(@"man")];
    vipImage.frame = CGRectMake(14, top, 37, 17);
    [self addSubview:vipImage];
    
    
    UILabel *maxPriceLabel = [[UILabel alloc] init];
    maxPriceLabel.frame = CGRectMake(vipImage.right+4, 0, 0, 15);
    maxPriceLabel.textColor = [UIColor hexColor:@"#FF7200"];
    maxPriceLabel.font = kBoldFont(14);
    maxPriceLabel.text = NSStringFormat(@"会员价: ¥%.2f (省¥%.2f)", self.proModel.minPrice, self.proModel.differencePrice);
    maxPriceLabel.centerY = vipImage.centerY;
    [maxPriceLabel resizeLabelHorizontal];
    [self addSubview:maxPriceLabel];
    
    self.buyVipBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 24)];
    [UIBezierPath bezierRoundView:self.buyVipBtn withRadii:CGSizeMake(10, 10)];
    self.buyVipBtn.backgroundColor = [UIColor hexColor:@"#FF7200"];
    [self.buyVipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (![GVUserDefaults standardUserDefaults].isVip) {
        [self.buyVipBtn setTitle:@"购买会员" forState:UIControlStateNormal];
    }else {
        self.buyVipBtn.hidden = YES;
    }
    self.buyVipBtn.titleLabel.font = kFont(10);
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_W-14 - 80, nameLabel.bottom+23, 80, 24)];
    shadowView.layer.shadowColor = [UIColor hexColor:@"#EB7617"].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0, 4);
    shadowView.layer.shadowOpacity = 0.4f;
    shadowView.layer.shadowRadius = 3.0;
    shadowView.layer.cornerRadius = 5.0;
    shadowView.clipsToBounds = NO;
    [self addSubview:shadowView];
    [shadowView addSubview:self.buyVipBtn];
    
    self.height = vipImage.bottom + 16;
    
}


@end
