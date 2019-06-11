//
//  CancelReasonView.m
//  HWDMall
//
//  Created by stewedr on 2018/12/6.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "CancelReasonView.h"
#import "CancelReasonCell.h"
#import "CancelReasonModel.h"

static NSString * const reasonCellID = @"RESONCELLID";

@interface CancelReasonView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *titleLbl; // 标题
@property (nonatomic,strong) UITableView * paywayTable; //
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) UIButton *cancelBtn; // 删除button
@property (nonatomic,strong) NSMutableArray *reasonMuarr; // 原因
@property (nonatomic,copy) NSString *reasonStr; // 取消原因

@end

@implementation CancelReasonView

#pragma mark -- lazyload

- (NSString *)reasonStr{
    if (!_reasonStr) {
        _reasonStr = [[NSString alloc]init];
    }
    return _reasonStr;
}

- (NSMutableArray *)reasonMuarr{
    if (!_reasonMuarr) {
        _reasonMuarr = [[NSMutableArray alloc]init];
    }
    return _reasonMuarr;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]init];
        _titleLbl.text = @"请选择取消订单的原因";
        _titleLbl.font = [UIFont boldSystemFontOfSize:17];
        _titleLbl.textColor = UIColorFromHex(0x333333);
    }
    return _titleLbl;
}

- (UITableView *)paywayTable{
    if (!_paywayTable) {
        _paywayTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _paywayTable.delegate = self;
        _paywayTable.dataSource = self;
        _paywayTable.tableFooterView = [UIView new];
        [_paywayTable registerNib:[UINib nibWithNibName:NSStringFromClass([CancelReasonCell class]) bundle:nil] forCellReuseIdentifier:reasonCellID];
    }
    return _paywayTable;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage:GetImage(@"arrow_right_black_14") forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchDown];
        
    }
    return _cancelBtn;
}


- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_confirmBtn setGradientBackgroundWithColors:@[[UIColor colorWithRed:238/255.0 green:139/255.0 blue:11/255.0 alpha:1.0],[UIColor colorWithRed:237/255.0 green:77/255.0 blue:77/255.0 alpha:1.0]] locations: @[@(0), @(1.0f)]startPoint:CGPointMake(0.5, 1) endPoint:CGPointMake(0.5, 0)];
        _confirmBtn.alpha = 0.6;
        _confirmBtn.userInteractionEnabled = NO;
        _confirmBtn.layer.cornerRadius = 24;
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchDown];
    }
    return _confirmBtn;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromHexWithAlpha(0x000000, 0.5);
        [self setUI];
        [self loadReason];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHexWithAlpha(0x000000, 0.5);
        [self setUI];
        [self loadReason];
    }
    return self;
}

#pragma mark -- setUI
- (void)setUI{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.confirmBtn];
    [self.contentView addSubview:self.paywayTable];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(439);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(18);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(14);
        make.top.equalTo(self.contentView.mas_top).offset(18);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    
    [self.paywayTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(15);
        make.bottom.equalTo(self.confirmBtn.mas_top);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.height.equalTo(49);
    }];
}


#pragma mark -- tabledelegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reasonMuarr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CancelReasonCell * cell = [tableView dequeueReusableCellWithIdentifier:reasonCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CancelReasonCell class]) owner:self options:nil]lastObject];
    }
    CancelReasonListModel * model = [self.reasonMuarr objectAtIndex:indexPath.row];
    [cell updateCellMesWithTitle:model.value SelectedStatus:model.isSelectedStatus];
    __weak typeof(self) weakSelf = self;
    cell.btnBlock = ^{
        weakSelf.confirmBtn.alpha = 1;
        weakSelf.confirmBtn.userInteractionEnabled = YES;
        weakSelf.reasonStr = model.value;
        for (CancelReasonListModel * resonmodel in weakSelf.reasonMuarr) {
            if ([resonmodel isEqual:model]) {
                resonmodel.isSelectedStatus = YES;
            }else{
                resonmodel.isSelectedStatus = NO;
            }
        }
        [weakSelf.paywayTable reloadData];
    };
    return cell;
}

#pragma mark -- BtnAction
- (void)deleteBtnAction{
    [self removeFromSuperview];
}

- (void)confirmBtnAction{
    if (self.cancelBlock) {
        self.cancelBlock(self.reasonStr);
    }
    [self removeFromSuperview];
}


#pragma mark -- loadData
- (void)loadReason{
    [[WebServiceTool shareHelper]getWithURLString:NSStringFormat(@"%@%@",kApiPrefix,kApi_listCancelOrderReason) parameters:@[] success:^(id  _Nonnull responseObject) {
        
        CancelReasonModel * reasonmodel = [CancelReasonModel mj_objectWithKeyValues:responseObject];
        __weak typeof(self) weakSelf = self;
        if ([reasonmodel.code isEqualToString:@"0"]) {
            [weakSelf.reasonMuarr addObjectsFromArray:reasonmodel.result];
            [weakSelf.paywayTable reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


@end
