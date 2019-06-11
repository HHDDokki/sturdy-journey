//
//  OrderListMesCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/30.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderListMesCell.h"

@interface OrderListMesCell ()
@property (weak, nonatomic) IBOutlet UILabel *titileLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@property (weak, nonatomic) IBOutlet UIButton *fuzhiBtn;


@end

@implementation OrderListMesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)copyAction:(id)sender {
    if (self.contentLbl.text) {
        RDLog(@"copy");
        [kWindow makeToast:@"已复制"];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.contentLbl.text;
    }
}

- (void)updateCellMessWithTitle:(NSString *)title Content:(NSString *)content ButtonHidden:(BOOL)buttonhidden{
//    if (buttonhidden) {
//        self.fuzhiBtn.hidden = NO;
//    }else{
        self.fuzhiBtn.hidden = YES;
//    }
    
    self.titileLbl.text = title;
    self.contentLbl.text = content;
}

@end
