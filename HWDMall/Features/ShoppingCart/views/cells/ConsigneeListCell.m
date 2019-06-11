//
//  ConsigneeListCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConsigneeListCell.h"
#import "ConsigneeMesModel.h"

@interface ConsigneeListCell()
{
    AddressListModel * _consigneeModel;
}
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *commonLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ConsigneeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.commonLbl.layer.cornerRadius = 2;
    self.commonLbl.layer.masksToBounds = YES;
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor hexColor:@"#EEF1F3"];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(8.0);
    }];
    
}

- (void)cleanContent{
    self.name.text = @"";
    self.phoneNum.text = @"";
    self.commonLbl.hidden = YES;
    self.addressLbl.text = @"";
}

- (void)setContentWithConsigneeMesModel:(AddressListModel *)model{
    if (!model) {
        return;
    }
    self.name.text = model.consignee;
    self.phoneNum.text = [NSString PhoneWithSecret:model.mobile];
    self.addressLbl.text = NSStringFormat(@"%@%@%@%@",model.provinceName,model.cityName,model.districtName,model.address);
    _consigneeModel = model;
    if (model.isDefault) {
        self.commonLbl.hidden = NO;
    }else{
        self.commonLbl.hidden = YES;
    }
}
- (IBAction)editAddress:(id)sender {
    _editBlock ? self.editBlock(_consigneeModel) :nil;
}
- (IBAction)deleteBtnAction:(id)sender {
    if (self.deleteBlock) {
        self.deleteBlock(_consigneeModel);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
