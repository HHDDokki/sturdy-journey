//
//  OrderDetailTopTwoLineCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderDetailTopTwoLineCell.h"

#import "UITableViewCell+MqlClock.h"

@interface OrderDetailTopTwoLineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;


@end

@implementation OrderDetailTopTwoLineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView setGradientBackgroundWithColors:@[kMainRedColor,kMainYellowColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)udpateCellMesWithHeadImage:(NSString *)imageName Status:(NSString *)status Suttitle:(NSString *)subtitle TimeDownLblHidden:(BOOL)timedownhidden TimeDown:(NSInteger)timedown{
    self.headimage.image = GetImage(imageName);
    self.statusLbl.text= status;
    self.subTitleLbl.text = subtitle;
    if (timedownhidden) {
        self.timeDownLbl.hidden =YES;
    }else{
        self.timeDownLbl.hidden =NO;
        self.mcStartSecond = NSStringFormat(@"%ld",timedown);
        [self runCADisplayLinkTimer];

    }
}

- (void)showTheCountDownTime:(NSString *)time{
    if ([time isEqualToString:@"00:00:00"]) {
        if (self.timedownBlock) {
            self.timedownBlock(nil);
        }
    }else{
         self.timeDownLbl.text = NSStringFormat(@"倒计时：%@",time);
    }
   
}


- (void)dealloc{
    [self resetCountDownTime];
}


@end
