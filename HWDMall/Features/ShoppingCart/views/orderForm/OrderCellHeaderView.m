//
//  OrderCellHeaderView.m
//  HWDMall
//
//  Created by stewedr on 2018/10/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderCellHeaderView.h"

@interface OrderCellHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *shopHead;
@property (weak, nonatomic) IBOutlet UIButton *shopName;
@property (weak, nonatomic) IBOutlet UILabel *orderName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation OrderCellHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor = UIColorFromHex(0xeeeeee);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap addTarget:self action:@selector(mytapAction)];
    [self.shopName addTarget:self
                      action:@selector(mytapAction) forControlEvents:UIControlEventTouchDown];
    self.contentView.userInteractionEnabled = YES;
    [self.contentView addGestureRecognizer:tap];
}

- (void)updateHeaderWithMoreShops:(BOOL)haveShops
                         ShopName:(NSString *)shopName
                   AndOrderStatus:(NSString *)shopStatus{
    if (haveShops) { // 多个店铺显示好货多logo 和 好货多商城
        [self.shopName setTitle:@"好货多" forState:UIControlStateNormal];
    }else{
        [self.shopName setTitle:shopName forState:UIControlStateNormal];
    }
    
    self.orderName.text = shopStatus;
}

- (void)setIsTop:(BOOL)isTop{
    if (_isTop != isTop) {
        _isTop = isTop;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.isTop) {
        self.topConstraint.constant = 10;
    }else{
        self.topConstraint.constant = 0;
    }
}


#pragma mark -- tapAction
- (void)mytapAction{
    RDLog(@"头部点击");
    if (self.tapBlock) {
        self.tapBlock();
    }
}

@end
