//
//  GoodsTypeSpecBottomCell.m
//  BFMan
//
//  Created by HandC1 on 2019/5/26.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "GoodsTypeSpecBottomCell.h"

@interface GoodsTypeSpecBottomCell ()

@property (nonatomic, strong) UILabel *numTitleLabel;
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation GoodsTypeSpecBottomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)bindType:(NSInteger)type withAddress:(NSString *)address {
    
    [self creatNumChoiceStrip];
//    [self creatMainView];
    
}


- (void)creatNumChoiceStrip {
    
    self.numTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 27, 13)];
    self.numTitleLabel.textColor = [UIColor hexColor:@"#333333"];
    self.numTitleLabel.font = kFont(14);
    self.numTitleLabel.text = @"数量";
    [self.numTitleLabel sizeToFit];
    [self.contentView addSubview:self.numTitleLabel];
    [self.contentView addSubview:self.subBtn];
    [self.contentView addSubview:self.addBtn];

    self.numLabel.frame = CGRectMake(self.subBtn.right, self.subBtn.mj_y, self.addBtn.left-self.subBtn.right, self.subBtn.height);
    [self.contentView addSubview:self.numLabel];
    
    
}

- (void)creatMainView {

    
    
}

- (void)subNum:(UIButton *)sender {
    
    int num = self.numLabel.text.intValue;
    num = num - 1;
    if (num < 2) {
        self.numLabel.text = @"1";
        sender.alpha = 0.1;
        sender.userInteractionEnabled = 0;
    }else{
        self.numLabel.text = [NSString stringWithFormat:@"%d",num];
        sender.alpha = 1;
        sender.userInteractionEnabled = 1;
    }
    self.getGoodsNumBlock(num);
    
}


- (void)addNum:(UIButton *)sender {
    
    int num = self.numLabel.text.intValue;
    num = num + 1;
    self.numLabel.text = [NSString stringWithFormat:@"%d",num];
    
    self.subBtn.userInteractionEnabled = 1;
    self.subBtn.alpha = 1;
    
    self.getGoodsNumBlock(num);
    
}

- (UILabel *)numTitleLable {
    
    if (!_numTitleLabel) {
        _numTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _numTitleLabel;
    
}

- (UIButton *)subBtn {
    
    if (!_subBtn) {
        _subBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 0, 22, 22)];
        _subBtn.top = self.numTitleLable.bottom + 17;
        [_subBtn setImage:IMAGE_NAME(@"减-可选") forState:UIControlStateNormal];
        _subBtn.alpha = 0.1;
        _subBtn.userInteractionEnabled = 0;
        [_subBtn addTarget:self action:@selector(subNum:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
    
}

- (UILabel *)numLabel {
    
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.textColor = [UIColor hexColor:@"#333333"];
        _numLabel.font = kFont(17);
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.text = @"1";
    }
    return _numLabel;
    
}

- (UIButton *)addBtn {
    
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(16+22+50, 0, 22, 22)];
        _addBtn.top = self.numTitleLable.bottom + 17;
        [_addBtn setImage:IMAGE_NAME(@"加-可选") forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addNum:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
    
}


@end
