//
//  ShoppingCarCell.m
//  HWDMall
//
//  Created by stewedr on 2018/11/5.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "ShoppingcarGoodsCell.h"

static NSString * const shoppinggoodscellID = @"SHOPPINGCARTCELLID";

@interface ShoppingCarCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * contentTable;

@end

@implementation ShoppingCarCell
#pragma mark -- layzload
- (UITableView *)contentTable{
    if (!_contentTable) {
        _contentTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTable.delegate = self;
        _contentTable.dataSource = self;
        _contentTable.backgroundColor = [UIColor whiteColor];
        _contentTable.tableFooterView = [UIView new];
        _contentTable.scrollEnabled = NO;
        _contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_contentTable registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingcarGoodsCell class]) bundle:nil] forCellReuseIdentifier: shoppinggoodscellID];
    }
    return _contentTable;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
    
}

- (void)setupViews {
    [self.contentView addSubview:self.contentTable];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.contentTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(self.contentView);
    }];
}

#pragma mark -- tableviewdelegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header = [UIView new];
    header.backgroundColor = [UIColor clearColor];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer = [UIView new];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 151;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 7.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingcarGoodsCell * goodscell = [tableView dequeueReusableCellWithIdentifier:shoppinggoodscellID];
    if (!goodscell) {
        goodscell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ShoppingcarGoodsCell class])
                                                  owner:self
                                                options:nil]lastObject];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            goodscell.roundCornerType = KKRoundCornerCellTypeTop;
        }else{
            goodscell.roundCornerType = KKRoundCornerCellTypeBottom;
        }
    }else{
        goodscell.roundCornerType = KKRoundCornerCellTypeSingleRow;
    }
    return goodscell;

}


@end
