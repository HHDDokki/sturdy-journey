//
//  BFMallConfirmOrderGoodsCell.m
//  HWDMall
//
//  Created by HandC1 on 2019/5/27.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallConfirmOrderGoodsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define GoodsCellID  @"GOODSCELLDI"

@interface BFMallConfirmOrderGoodsCell ()

@property (nonatomic, strong) UIImageView *goodsHead;
@property (nonatomic, strong) UILabel *goodsname;
@property (nonatomic, strong) UILabel *goodsguige;
@property (nonatomic, strong) UILabel *goodsprice;
@property (nonatomic, strong) UILabel *goodsVipPrice;
@property (nonatomic, strong) UILabel *goodsnum;
@property (nonatomic, strong) UILabel *tuikuan;
@property (nonatomic, strong) UIImageView *vipMan;


/* - - - - - - - - - - - - - - - order list - - - - - - - - - - - - - - -*/
@property (nonatomic, strong) UILabel *totalLabel;


@end

@implementation BFMallConfirmOrderGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
        
    }
    return self;
    
}

- (void)setUI {
    
    [self.contentView addSubview:self.goodsHead];
    [self.contentView addSubview:self.goodsname];
    [self.contentView addSubview:self.goodsguige];
    [self.contentView addSubview:self.goodsprice];
    [self.contentView addSubview:self.goodsVipPrice];
    [self.contentView addSubview:self.goodsnum];
    [self.contentView addSubview:self.vipMan];
    [self.contentView addSubview:self.totalLabel];
    
    [self.goodsHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(14);
        make.left.equalTo(15);
        make.width.height.equalTo(86);
    }];
    
    [self.goodsname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsHead.mas_top);
        make.left.equalTo(self.goodsHead.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-17);
//        make.height.equalTo(36);
        
    }];
    
    [self.goodsguige mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsHead.mas_right).offset(10);
        make.top.equalTo(self.goodsname.mas_bottom).offset(7);
        make.width.equalTo(220);
        make.height.equalTo(12);
    }];
    
    [self.goodsprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsHead.mas_right).offset(10);
        make.top.equalTo(self.goodsguige.mas_bottom).offset(11);
        make.width.equalTo(200);
        make.height.equalTo(9);
    }];
    
    [self.vipMan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsprice.mas_bottom).offset(5);
        make.left.equalTo(self.goodsHead.mas_right).offset(10);
        make.width.equalTo(23);
        make.height.equalTo(11);
    }];

    
    [self.goodsVipPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vipMan.mas_right).offset(3);
        make.top.equalTo(self.goodsprice.mas_bottom).offset(5);
        make.width.equalTo(200);
        make.height.equalTo(9);
    }];
    
    [self.goodsnum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-18);
        make.centerY.equalTo(self.goodsguige.mas_centerY);
        make.width.equalTo(30);
        make.height.equalTo(11);
    
    }];
    
    [self.contentView addSubview:self.tuikuan];
    [self.tuikuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
        make.height.equalTo(11);
        make.width.equalTo(50);
        
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.bottom.equalTo(self.goodsHead.mas_bottom).offset(-3);;
        make.left.equalTo(self.goodsHead.mas_right).offset(2);
        make.height.equalTo(15);
    }];
    
}


- (void)updateCellMesWithHeadUrl:(NSString *)goodshead
                       GoodsName:(NSString *)goodsname
                      GoodsGuige:(NSString *)goodsguige
                      GoodsPrice:(NSString *)goodsprice
                        GoodsNum:(NSString *)goodsnum
                   GoodsVipPrice:(NSString *)vipPrice {
    
    
    self.totalLabel.hidden = YES;
    [self.goodsHead sd_setImageWithURL:[NSURL URLWithString:goodshead] placeholderImage:GetImage(@"taken_image_details_product")];
    self.goodsname.text = goodsname;
    [self.goodsname sizeToFit];
    self.goodsguige.text = goodsguige;
    self.goodsnum.text = goodsnum;
    self.goodsprice.text = NSStringFormat(@"商品价：%@",goodsprice);
    self.goodsVipPrice.text = vipPrice;
}

- (void)updateCellMesWithGoodsImge:(NSString *)goodsimage GoodsName:(NSString *)goodsname GoodsGuige:(NSString *)guige GoodsPrice:(NSString *)goodsprice GoodsCount:(NSString *)count TuikanStatus:(NSString *)tuikuanstatus GoodsVipPrice:(NSString *)vipPrice {
    
    self.totalLabel.hidden = YES;
    [self.goodsHead sd_setImageWithURL:[NSURL URLWithString:goodsimage] placeholderImage:GetImage(@"taken_image_details_product")];
    self.goodsname.text = goodsname;
    [self.goodsname sizeToFit];
    self.goodsguige.text = guige;
    self.goodsnum.text = count;
    self.goodsprice.text = NSStringFormat(@"商品价：%@",goodsprice);
    self.goodsVipPrice.text = vipPrice;
    self.tuikuan.text = tuikuanstatus;
    
}


- (void)updateGoodsMesWithHeadImage:(NSString *)headerurl
                          Goodsname:(NSString *)goodsname
                         Goodsprice:(CGFloat)price
                         GoodsGuige:(NSString *)guige
                           GoodsNum:(NSInteger)goodsnum
                        TuikanStatus:(NSInteger)tuikuanstatus{
    
    self.vipMan.hidden = YES;
    self.goodsVipPrice.hidden = YES;
    self.totalLabel.hidden = NO;
    
//    if (tuikuanstatus == 1 || tuikuanstatus == 2) {
        self.tuikuan.hidden = YES;
//        self.totalLabel.hidden = YES;
//    }
    if (tuikuanstatus == 2) {
        self.totalLabel.text = @"退款成功";
    }else if(tuikuanstatus == 1){
        self.totalLabel.text = @"退款中";
    }else {
        self.totalLabel.text = NSStringFormat(@"合计：¥%.2f", price);
    }
    
    [self.goodsHead sd_setImageWithURL:[NSURL URLWithString:headerurl] placeholderImage:GetImage(@"taken_image_details_product")];
    self.goodsname.text = goodsname;
    self.goodsguige.text = guige;
    self.goodsnum.text = NSStringFormat(@"x%ld",(long)goodsnum);
    
}



#pragma mark - lazyLoad
- (UIImageView *)goodsHead {
    
    if (!_goodsHead) {
        _goodsHead = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _goodsHead;
    
}

- (UILabel *)goodsname {
    
    if (!_goodsname) {
        _goodsname = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodsname.textColor = [UIColor hexColor:@"#0E0E0E"];
        _goodsname.font = kFont(14);
        _goodsname.numberOfLines = 2;
        
    }
    return _goodsname;
    
}

- (UILabel *)goodsguige {
    
    if (!_goodsguige) {
        _goodsguige = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodsguige.textColor = [UIColor hexColor:@"#9DA6B1"];
        _goodsguige.font = kFont(11);
    }
    return _goodsguige;
    
}

- (UILabel *)goodsnum {
    
    if (!_goodsnum) {
        _goodsnum = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodsnum.textColor = [UIColor hexColor:@"#9DA6B1"];
        _goodsnum.font = kFont(10);
        _goodsnum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsnum;
    
}

- (UILabel *)goodsVipPrice {
    
    if (!_goodsVipPrice) {
        _goodsVipPrice = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodsVipPrice.textColor = [UIColor hexColor:@"#FF7200"];
        _goodsVipPrice.font = kBoldFont(10);
    }
    return _goodsVipPrice;
    
}

- (UILabel *)goodsprice {
    
    if (!_goodsprice) {
        _goodsprice = [[UILabel alloc] initWithFrame:CGRectZero];
        _goodsprice.textColor = [UIColor hexColor:@"#0E0E0E"];
        _goodsprice.font = kBoldFont(8);
    }
    return  _goodsprice;
    
}

- (UILabel *)tuikuan {
    
    if (!_tuikuan) {
        _tuikuan = [[UILabel alloc] initWithFrame:CGRectZero];
        _tuikuan.font = kFont(10);
        _tuikuan.textColor = [UIColor hexColor:@"#FF7200"];
        _tuikuan.textAlignment = NSTextAlignmentRight;
    }
    return _tuikuan;
    
}

- (UIImageView *)vipMan {
    
    if (!_vipMan) {
        _vipMan = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_vipMan setImage:IMAGE_NAME(@"man")];
    }
    return _vipMan;
    
}

- (UILabel *)totalLabel {
    
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _totalLabel.font = kFont(14);
        _totalLabel.textColor = [UIColor hexColor:@"#FF7200"];
        _totalLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalLabel;
    
}

@end
