//
//  BFMallOrderShopListCell.m
//  HWDMall
//
//  Created by HandC1 on 2019/6/1.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallOrderShopListCell.h"
#import "BFMallConfirmOrderGoodsCell.h"
#import "OrderListModel.h"

@interface BFMallOrderShopListCell () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation BFMallOrderShopListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.muArr = [NSMutableArray array];
        [self setUI];
        
    }
    return self;
    
}

- (void)setUI {
    
    [self.contentView addSubview:self.mesTable];
    [self.mesTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
    }];
    
}

#pragma mark -- lazyload
- (UITableView *)mesTable{
    if (!_mesTable) {
        _mesTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mesTable.scrollEnabled = NO;
        _mesTable.delegate = self;
        _mesTable.dataSource = self;
        _mesTable.backgroundColor = [UIColor whiteColor];
        _mesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mesTable registerClass:[BFMallConfirmOrderGoodsCell class] forCellReuseIdentifier:@"goodsCell"];

    }
    return _mesTable;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.muArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OrderlistShopModel * shopmodel = self.muArr[section];
    return shopmodel.goods.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 114;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 8.0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView * footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
    footer.backgroundColor = UIColorFromHex(0xEEF1F3);
    return footer;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderlistShopModel * shopmodel = self.muArr[indexPath.section];
    OrderlistGoodsModel * goodmodel = [shopmodel.goods objectAtIndex:indexPath.row];
    BFMallConfirmOrderGoodsCell * goodscell = [tableView dequeueReusableCellWithIdentifier:@"goodsCell"];
    [goodscell updateGoodsMesWithHeadImage:goodmodel.goodsThumb
                                 Goodsname:goodmodel.goodsName
                                Goodsprice:goodmodel.finalPrice
                                GoodsGuige:goodmodel.specKeyName
                                  GoodsNum:goodmodel.goodsNum
                              TuikanStatus:goodmodel.status];
    return goodscell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tapblock) {
        self.tapblock();
    }
    
}

@end
