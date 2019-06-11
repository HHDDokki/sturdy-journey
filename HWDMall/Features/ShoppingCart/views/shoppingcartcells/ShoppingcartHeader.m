//
//  ShoppingcartHeader.m
//  HWDMall
//
//  Created by stewedr on 2018/11/5.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ShoppingcartHeader.h"


@interface ShoppingcartHeader ()
@property (weak, nonatomic) IBOutlet UIButton *shopNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *seletectBtn;

@end

@implementation ShoppingcartHeader

- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor =[UIColor clearColor];
    [self.seletectBtn addTarget:self action:@selector(statusBtnAction:) forControlEvents:UIControlEventTouchDown];
    [self.shopNameBtn addTarget:self action:@selector(shopNameBtnAction:) forControlEvents:UIControlEventTouchDown];
}

- (void)updateHeaderMesWithShopName:(NSString *)shopname SeletectedStatus:(BOOL)seletedstatus{
    [self.shopNameBtn setTitle:shopname forState:UIControlStateNormal];
    self.seletectBtn.selected = seletedstatus;
}


#pragma mark -- buttonAction
- (void)statusBtnAction:(UIButton *)sender{
    if (self.selectedBlock) {
        self.selectedBlock(sender.isSelected);
    }
}

- (void)shopNameBtnAction:(UIButton *)sender{
    if (self.selectShopName) {
        self.selectShopName(NO);
    }
}

@end
