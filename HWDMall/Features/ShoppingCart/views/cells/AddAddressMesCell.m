//
//  AddAddressMesCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "AddAddressMesCell.h"
#import "OderCellModel.h"
#import "ConsigneeMesModel.h"
#import "NSString+Common.h"
#import "UIView+Frame.h"
#import "BRAddressPickerView.h"

@interface AddAddressMesCell()<UITextViewDelegate>
{
    OderCellModel * _orderModel;
    ConsigneeMesModel * _commitModel;
    
}
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic,assign) NSInteger lineNum;
@end

@implementation AddAddressMesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentTextView.delegate = self;
    self.deleteBtn.hidden = YES;
}

- (void)clearCellData
{
    self.titleLbl.text = @"";
    self.contentTextView.text = @"";
}

- (void)refreshContent:(OderCellModel *)creatModel commitModel:(ConsigneeMesModel *)commitmodel{
    [self clearCellData];
    if (!creatModel) {
        return;
    }
    _orderModel = creatModel;
    _commitModel = commitmodel;
    
    self.titleLbl.text = creatModel.title;
    self.contentTextView.text = creatModel.contentMes;
    if ([creatModel.key isEqualToString:key_PhoneNum]) {
        self.contentTextView.keyboardType = UIKeyboardTypeNumberPad;
    }
    [_commitModel setValue:creatModel.contentMes forKey:creatModel.key];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.contentTextView addGestureRecognizer:tap];
    
    // 计算高度
    CGFloat singleLine = [[@"一行数据" deleteBlank]getItemSizeWithFont:[UIFont systemFontOfSize:15] Width:self.contentTextView.width - [[self.contentTextView textContainer] lineFragmentPadding] * 2];
    CGFloat height =  [[creatModel.contentMes deleteBlank]getItemSizeWithFont:[UIFont systemFontOfSize:15] Width:self.contentTextView.width- [[self.contentTextView textContainer] lineFragmentPadding] * 2];
    NSInteger i = height/singleLine;
    if (i == 1) {
        self.lineNum = i;
        _orderModel.ordercellHeight = 49;
    }
    if (self.lineNum != i) {
        self.lineNum = i;
        _orderModel.ordercellHeight = height + singleLine;
        _changeBlock ? self.changeBlock() : nil;
    }else{
        if (height == singleLine) {
            _orderModel.ordercellHeight = height + singleLine;
            //            _changeBlock ? self.changeBlock() : nil;
        }
    }
}
- (IBAction)deleteContent:(id)sender {
    self.contentTextView.text = @"";
    _orderModel.ordercellHeight = 49;
    _changeBlock ? self.changeBlock() : nil;
    self.deleteBtn.hidden = YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.deleteBtn.hidden = NO;
    [self addNotification];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.deleteBtn.hidden = YES;
    [self clearNotification];
}


- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    if ([_orderModel.key isEqualToString:key_Address]) {
        // 收起键盘
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        __weak typeof(self) weakSelf = self;
        [BRAddressPickerView showAddressPickerWithDefaultSelected:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            RDLog(@"%@,%@,%@,%@,%@,%@",province.name,province.code,city.name,city.code,area.name,area.code);
            self->_commitModel.provinceName = province.name;
            self->_commitModel.provinceID = [province.code integerValue];
            self->_commitModel.cityName = city.name;
            self->_commitModel.cityID =  [city.code integerValue];
            self->_commitModel.districtName = area.name;
            self->_commitModel.districtID = [area.code integerValue];
            if (weakSelf.updateAddressblock) {
                weakSelf.updateAddressblock(NSStringFormat(@"%@%@%@",province.name,city.name,area.name));
            }
        }];
    }else{
        RDLog(@"textview 响应");
        [self.contentTextView becomeFirstResponder];
//       [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textFiledEditChanged:(NSNotification *)obj
{
    UITextView *textView = (UITextView *)obj.object;
    NSString *toBeString = textView.text;
    if (toBeString.length) {
        self.deleteBtn.hidden = NO;
    }else{
        self.deleteBtn.hidden = YES;
    }
    _orderModel.contentMes = textView.text;
    [_commitModel setValue:textView.text forKey:_orderModel.key];
    CGFloat singleLine = [[@"一行数据" deleteBlank]getItemSizeWithFont:[UIFont systemFontOfSize:15] Width:textView.width - [[textView textContainer] lineFragmentPadding] * 2];
    CGFloat height =  [[toBeString deleteBlank]getItemSizeWithFont:[UIFont systemFontOfSize:15] Width:textView.width- [[textView textContainer] lineFragmentPadding] * 2];
    NSInteger i = height/singleLine;
    if (i == 1) {
        self.lineNum = i;
        _orderModel.ordercellHeight = 49;
    }
    if (self.lineNum != i) {
        self.lineNum = i;
        _orderModel.ordercellHeight = height + singleLine;
        _changeBlock ? self.changeBlock() : nil;
        RDLog(@"%@,%f,%ld,%ld,%f",[toBeString deleteBlank],height,(long)i,(long)self.lineNum,textView.width);
    }else{
        if (height == singleLine) {
            _orderModel.ordercellHeight = height + singleLine;
        }
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([_orderModel.key isEqualToString:key_PhoneNum]){
        //如果是删除减少字数，都返回允许修改
        if ([text isEqualToString:@""]){
            return YES;
        }
        if (range.location>= 11){
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

-(void)addNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextViewTextDidChangeNotification"
                                              object:nil];
}

-(void)clearNotification{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextViewTextDidChangeNotification"
                                                 object:nil];
}

@end
