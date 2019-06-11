//
//  ShoppingcarGoodsCell.m
//  HWDMall
//
//  Created by stewedr on 2018/11/5.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ShoppingcarGoodsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HYStepper.h"

@interface ShoppingcarGoodsCell ()

{
    CGFloat _cornerRadius;
}
@property (weak, nonatomic) IBOutlet UIView *shoppingcartGoodscontentview;
@property (weak, nonatomic) IBOutlet UILabel *manjanBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet HYStepper *stepView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsGuiGeLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsPreceLbl;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UIButton *statausBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic, strong) UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

@property (nonatomic, strong) UIButton *loseEffiLab;
@property (nonatomic, strong) UILabel *cantBuyLab;

@property (nonatomic, strong) UIImageView *vipIcon;
@property (nonatomic, strong) UILabel *vipPrice;

@end

@implementation ShoppingcarGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _cornerRadius = 5;
    // Initialization code
    self.manjanBtn.layer.cornerRadius = 7.5;
    self.manjanBtn.layer.borderWidth = 1;
    self.manjanBtn.layer.borderColor = UIColorFromHex(0xED5E3B).CGColor;
    self.shoppingcartGoodscontentview.backgroundColor = [UIColor whiteColor];
    self.stepView.minValue = 1;
    self.stepView.textfieldTextCorlor = UIColorFromHex(0x333333);
    self.stepView.isValueEditable = NO;
    self.stepView.stepBtnCorlor = [UIColor clearColor];
    self.stepView.btnTitleCorlor = [UIColor blackColor];
    self.stepView.backgroundColor = [UIColor clearColor];
    self.stepView.miniBtnImage = @"减-不可选";
    self.stepView.maxBtnImage = @"加-不可选";
    self.stepView.value = 1;
    __weak typeof(self) weakSelf = self;
    self.stepView.valueChanged = ^(double value) {
        RDLog(@"%.f",value);
        if (weakSelf.changcountblockBlock) {
            weakSelf.changcountblockBlock(value);
        }
    };
    
    self.loseEffiLab = [[UIButton alloc] initWithFrame:CGRectZero];
    self.loseEffiLab.frame = CGRectMake(0, 0, 26, 17);
    self.loseEffiLab.centerX = self.statausBtn.centerX;
    self.loseEffiLab.centerY = self.statausBtn.centerY;
    self.loseEffiLab.layer.cornerRadius = 8;
    self.loseEffiLab.backgroundColor = [UIColor hexColor:@"#CCD5E0"];
    [self.loseEffiLab setTitle:@"失效" forState:UIControlStateNormal];
    self.loseEffiLab.titleLabel.font = kFont(8);
    [self.loseEffiLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.loseEffiLab];

    
    [self.contentView addSubview:self.cantBuyLab];
    [self.cantBuyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(7);
        make.bottom.equalTo(self.goodsImageView.mas_bottom);
        make.width.equalTo(90);
        make.height.equalTo(12);
    }];
    
    self.cantBuyLab.hidden = YES;
    
    
    [self.contentView addSubview:self.vipIcon];
    [self.vipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsPreceLbl.mas_bottom).offset(3);
        make.left.equalTo(self.goodsPreceLbl.mas_left);
        make.width.equalTo(23);
        make.height.equalTo(11);
    }];
    
    [self.contentView addSubview:self.vipPrice];
    [_vipPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vipIcon.mas_top);
        make.left.equalTo(self.vipIcon.mas_right);
        make.right.equalTo(self.stepView.mas_left);
        make.height.equalTo(11);
    }];
    
    
    
//    self.shadowView = [[UIView alloc]initWithFrame:CGRectZero];
//    self.shadowView.layer.shadowColor = [UIColor colorWithRed:41/255.0 green:7/255.0 blue:4/255.0 alpha:0.1].CGColor;
//    self.shadowView.layer.shadowOffset = CGSizeMake(0,0);
//    self.shadowView.layer.shadowOpacity = 1;
//    self.shadowView.layer.shadowRadius = 6;
////    self.shadowView.layer.cornerRadius = 5;
//    self.shadowView.backgroundColor = [UIColor whiteColor];
//    [self.contentView insertSubview:self.shadowView belowSubview:self.shoppingcartGoodscontentview];
//    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.shoppingcartGoodscontentview.mas_centerX);
//        make.centerY.equalTo(self.shoppingcartGoodscontentview.mas_centerY);
//        make.width.equalTo(self.shoppingcartGoodscontentview);
//        make.height.mas_equalTo(90);
//    }];
//
    [self.statausBtn addTarget:self action:@selector(statusBtnAction:) forControlEvents:UIControlEventTouchDown];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    UIBezierPath *path;
    switch (_roundCornerType) {
        case KKRoundCornerCellTypeTop: {
            path = [UIBezierPath bezierPathWithRoundedRect:self.shoppingcartGoodscontentview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
            break;
        }

        case KKRoundCornerCellTypeBottom: {
            path = [UIBezierPath bezierPathWithRoundedRect:self.shoppingcartGoodscontentview.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
            break;
        }

        case KKRoundCornerCellTypeSingleRow: {
            path = [UIBezierPath bezierPathWithRoundedRect:self.shoppingcartGoodscontentview.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
            break;
        }

        case KKRoundCornerCellTypeDefault:
        default: {
            self.layer.mask = nil;
            return;
        }
    }

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.shoppingcartGoodscontentview.bounds;
    maskLayer.path = path.CGPath;
    self.shoppingcartGoodscontentview.layer.mask = maskLayer; // 添加圆角    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)setIsEditing:(BOOL)isEditing{
    if (_isEditing != isEditing) {
        _isEditing = isEditing;
    }
    
    if (_isEditing) {
        self.rightConstraint.constant = 0;
    }else{
        self.rightConstraint.constant = 16;
    }
}

- (void)updateCellMesWithHeadUrl:(NSString *)headurl GoodsName:(NSString *)goodsname GoodsGuige:(NSString *)goodsguige GoodsPrice:(NSString *)goodsprice GoodsCount:(NSInteger)goodscount GoodsUnuse:(BOOL)unuse GoosSeletedStatus:(BOOL)isseleted normalSinglePrice:(NSString *)normalPrice VipPrice:(NSString *)vipPrice{
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:headurl] placeholderImage:GetImage(@"taken_image_details_product")];
    RDLog(@"图片地址：%@",headurl);
    self.goodsNameLbl.text = goodsname;
    self.goodsPreceLbl.text = NSStringFormat(@"商品价：¥%@",goodsprice);
    self.goodsGuiGeLbl.text = goodsguige;
    self.stepView.value = goodscount;
    self.statausBtn.selected = isseleted;
    self.vipPrice.text = vipPrice;
    self.goodsPreceLbl.text = NSStringFormat(@"商品价：¥%@",normalPrice);

    if (unuse) {
        self.goodsPreceLbl.hidden = YES;
        self.goodsGuiGeLbl.hidden = YES;
        self.stepView.hidden = YES;
        self.statausBtn.hidden = YES;
    }else{
        self.goodsPreceLbl.hidden = NO;
        self.goodsGuiGeLbl.hidden = NO;
        self.stepView.hidden = NO;
        self.statausBtn.hidden = NO;
    }
    
    self.stepView.carid = self.cartid;
    
    self.lineView.hidden = NO;
    switch (_roundCornerType) {
        case KKRoundCornerCellTypeTop: {
            self.lineView.hidden = YES;
//            self.shadowView.layer.shadowOffset = CGSizeMake(0,0);
//            [self.shadowView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(92);
//            }];
            break;
        }

        case KKRoundCornerCellTypeBottom: {
//            self.shadowView.layer.shadowOffset = CGSizeMake(0,6);
//            [self.shadowView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(100);
//            }];
            break;
        }

        case KKRoundCornerCellTypeSingleRow: {
            self.lineView.hidden = YES;
//            self.shadowView.layer.shadowOffset = CGSizeMake(0,6);
//            [self.shadowView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(100);
//            }];
            break;
        }

        case KKRoundCornerCellTypeDefault: {
//            self.shadowView.layer.shadowOffset = CGSizeMake(0,0);
//            [self.shadowView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(92);
//            }];
            break;
        }
        default: {
            return;
        }
    }
}

- (void)statusBtnAction:(UIButton *)sender{
    if ([sender isEqual:self.statausBtn]) {
        if (self.selectBlock) {
            self.selectBlock(sender.isSelected);
        }
    }
}

- (void)setShopgoodsStatus:(ShopingCartGoodsStatus)shopgoodsStatus{
    if (_shopgoodsStatus != shopgoodsStatus) {
        _shopgoodsStatus = shopgoodsStatus;
    }
    switch (shopgoodsStatus) {
        case ShopingCartGoodsStatus_wuhuo:// 无货 == 有效
            self.statausBtn.hidden = NO;
            self.goodsPreceLbl.text = @"请重新选择规格";
            self.goodsGuiGeLbl.hidden = YES;
            self.stepView.hidden = YES;
            self.loseEffiLab.hidden = YES;
            self.cantBuyLab.hidden = YES;
            self.vipIcon.hidden = NO;
            self.vipPrice.hidden = NO;
            break;
        case ShopingCartGoodsStatus_shangjia:// 上架
            self.statusLbl.hidden = YES;
            self.goodsGuiGeLbl.hidden = NO;
            self.stepView.hidden = NO;
            self.statausBtn.hidden = NO;
             self.goodsPreceLbl.hidden =NO;
            self.loseEffiLab.hidden = YES;
            self.cantBuyLab.hidden = YES;
            self.vipIcon.hidden = NO;
            self.vipPrice.hidden = NO;
            break;
        case ShopingCartGoodsStatus_shouqing: // 售罄 == 无效
            self.statausBtn.hidden = YES;
            self.goodsPreceLbl.hidden =YES;
            self.goodsGuiGeLbl.hidden = YES;
            self.stepView.hidden = YES;
            self.statusLbl.hidden = NO;
            self.statusLbl.text = @"已售罄";
            self.loseEffiLab.hidden = NO;
            self.cantBuyLab.hidden = NO;
            self.vipIcon.hidden = YES;
            self.vipPrice.hidden = YES;
            break;
        case ShopingCartGoodsStatus_xiajia:// 下架 == 无效
            self.statausBtn.hidden = YES;
            self.goodsPreceLbl.hidden =YES;
            self.goodsGuiGeLbl.hidden = YES;
            self.stepView.hidden = YES;
            self.statusLbl.hidden = NO;
            self.statusLbl.text = @"已下架";
            self.loseEffiLab.hidden = NO;
            self.cantBuyLab.hidden = NO;
            self.vipIcon.hidden = YES;
            self.vipPrice.hidden = YES;
            break;
            
        default:
            break;
    }
    
}


- (UILabel *)cantBuyLab {
    
    if (!_cantBuyLab) {
        _cantBuyLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _cantBuyLab.text = @"商品已不能购买";
        _cantBuyLab.textColor = [UIColor hexColor:@"#FF7200"];
        _cantBuyLab.font = kFont(10);
    }
    return _cantBuyLab;
    
}

- (UIImageView *)vipIcon {
    
    if (!_vipIcon) {
        _vipIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_vipIcon setImage:IMAGE_NAME(@"man")];
    }
    return _vipIcon;
    
}

- (UILabel *)vipPrice {
    
    if (!_vipPrice) {
        _vipPrice = [[UILabel alloc] initWithFrame:CGRectZero];
        _vipPrice.font = kBoldFont(10);
        _vipPrice.textColor = [UIColor hexColor:@"#FF7200"];
        _vipPrice.text = @"会员价：¥750";
    }
    return _vipPrice;
    
}

@end
