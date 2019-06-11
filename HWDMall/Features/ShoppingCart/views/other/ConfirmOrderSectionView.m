//
//  ConfirmOrderSectionView.m
//  HWDMall
//
//  Created by stewedr on 2018/10/18.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmOrderSectionView.h"


@interface ConfirmOrderSectionView ()
@property (weak, nonatomic) IBOutlet UILabel *shopnameLbl;

@end

@implementation ConfirmOrderSectionView

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap addTarget:self action:@selector(tapAction)];
    [self.contentView addGestureRecognizer:tap];
}

- (void)updateHeaderWithName:(NSString *)shopname{
    self.shopnameLbl.text = shopname;
}

#pragma mark -- tapAction
- (void)tapAction{
    if (self.tapBlock) {
        self.tapBlock();
    }
}

@end
