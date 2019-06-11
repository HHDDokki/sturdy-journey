//
//  OrderDetailTopOneLineCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderDetailTopOneLineCell.h"

@interface OrderDetailTopOneLineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

@end


@implementation OrderDetailTopOneLineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView setGradientBackgroundWithColors:@[kMainRedColor,kMainYellowColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updatecellMesWithHeadImage:(NSString *)imagename Status:(NSString *)status{
    self.imageView.image = GetImage(@"");
    self.imageView.image = GetImage(imagename);
    self.statusLbl.text = status;
}

@end
