//
//  BFMallOrderDetailTopTwoLineCell.m
//  HWDMall
//
//  Created by HandC1 on 2019/5/30.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallOrderDetailTopTwoLineCell.h"
#import "UITableViewCell+MqlClock.h"

@interface BFMallOrderDetailTopTwoLineCell ()

@property (nonatomic, strong) UILabel *statusLbl;
@property (nonatomic, strong) UIImageView *timeIcon;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation BFMallOrderDetailTopTwoLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
    
}

- (void)setUI {
    
    [self.contentView addSubview:self.statusLbl];
    [self.contentView addSubview:self.timeDownLbl];
    [self.contentView addSubview:self.timeIcon];
    [self.contentView addSubview:self.bottomLine];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(self.contentView.mas_width);
        make.left.equalTo(self.contentView.mas_left);
        make.height.equalTo(8);
    }];
    
    [self.statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(19);
        make.width.equalTo(120);
        make.height.equalTo(18);
    }];
    
    [self.timeDownLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.statusLbl.mas_centerY);
        make.height.equalTo(13);
        make.width.equalTo(160);
    }];
    
    [self.timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.statusLbl.mas_centerY);
        make.right.equalTo(self.timeDownLbl.mas_left);
        make.width.height.equalTo(13);
    }];


}


- (void)udpateCellMesWithHeadImage:(NSString *)imageName Status:(NSString *)status Suttitle:(NSString *)subtitle TimeDownLblHidden:(BOOL)timedownhidden TimeDown:(NSInteger)timedown{
    
    self.statusLbl.text = status;
    if (timedownhidden) {
        self.timeDownLbl.hidden = YES;
        self.timeIcon.hidden = YES;
    }else{
        self.timeDownLbl.hidden = NO;
        self.timeIcon.hidden = NO;
        self.timeDownLbl.text = @"剩余 00:58:17 订单自动关闭";
        [self.timeDownLbl sizeToFit];
//        self.mcStartSecond = NSStringFormat(@"%ld",timedown);
//        [self runCADisplayLinkTimer];

    }
}

- (void)showTheCountDownTime:(NSString *)time{
    if ([time isEqualToString:@"00:00:00"]) {
        if (self.timedownBlock) {
            self.timedownBlock(nil);
        }
    }else{
        self.timeDownLbl.text = NSStringFormat(@"倒计时：%@",time);
        [self.timeDownLbl sizeToFit];
    }
}


- (void)dealloc{
    [self resetCountDownTime];
}


#pragma mark -- lazyload

- (UIImageView *)timeIcon {
    
    if (!_timeIcon) {
        _timeIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_timeIcon setImage:IMAGE_NAME(@"")];
        _timeIcon.backgroundColor = [UIColor blackColor];
    }
    return _timeIcon;
    
}

- (UILabel *)statusLbl {
    
    if (!_statusLbl) {
        
        _statusLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLbl.font = kBoldFont(17);
        _statusLbl.textColor = [UIColor hexColor:@"#FF7200"];
        
    }
    return _statusLbl;
    
}


- (UILabel *)timeDownLbl {
    
    if (!_timeDownLbl) {
        _timeDownLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeDownLbl.font = kFont(12);
        _timeDownLbl.textColor = [UIColor hexColor:@"#FF7200"];
        _timeDownLbl.textAlignment = NSTextAlignmentRight;
        [_timeDownLbl sizeToFit];
    }
    return _timeDownLbl;
    
}

- (UIView *)bottomLine {
    
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [UIColor hexColor:@"#EEF1F3"];
    }
    return _bottomLine;
    
}

@end
