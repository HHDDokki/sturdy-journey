//
//  AddAddressBottomCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "AddAddressBottomCell.h"
#import "KLSwitch.h"


@interface AddAddressBottomCell ()
{
    ConsigneeMesModel * _commitmodel;
    OderCellModel * _contentmodel;
}
@property (weak, nonatomic) IBOutlet KLSwitch *customSwitch;

@end

@implementation AddAddressBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.customSwitch addTarget:self action:@selector(swichAction) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)swichAction{
    RDLog(@"%d",self.customSwitch.isOn);
    _commitmodel.isDefault = self.customSwitch.isOn;
    [_commitmodel setValue:[NSNumber numberWithBool:self.customSwitch.isOn] forKey:_contentmodel.key];
}

- (void)commitModel:(ConsigneeMesModel *)commitmodel Contentmodel:(OderCellModel *)contentmodel{
    _commitmodel = commitmodel;
    _contentmodel = contentmodel;
    [_commitmodel setValue:[NSNumber numberWithBool:contentmodel.isDefault] forKey:contentmodel.key];
    if (contentmodel.isDefault) {
        [self.customSwitch setOn:YES animated:NO];
    }else{
        [self.customSwitch setOn:NO animated:NO];
    }
}

@end
