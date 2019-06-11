//
//  WuliuListViewController.m
//  HWDMall
//
//  Created by stewedr on 2018/12/19.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "WuliuListViewController.h"
#import "WuliuListCell.h" // 物流cell
#import "WuliuListModel.h"
//#import "BargainLogisticsController.h" // 物流

static NSString * const listCellID = @"WULIUCELLID";

@interface WuliuListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * wuliuTable;
@property (nonatomic,strong) NSMutableArray *listMuarr;
@end

@implementation WuliuListViewController

#pragma mark -- lazyload

- (NSMutableArray *)listMuarr{
    if (!_listMuarr) {
        _listMuarr = [[NSMutableArray alloc]init];
    }
    return _listMuarr;
}

- (UITableView *)wuliuTable{
    if (!_wuliuTable) {
        _wuliuTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _wuliuTable.delegate = self;
        _wuliuTable.dataSource = self;
        _wuliuTable.backgroundColor = UIColorFromHex(0xF7F7F7);
        _wuliuTable.separatorStyle = UITableViewCellSelectionStyleNone;
        _wuliuTable.tableFooterView = [UIView new];
        [_wuliuTable registerNib:[UINib nibWithNibName:NSStringFromClass([WuliuListCell class]) bundle:nil] forCellReuseIdentifier:listCellID];
    }
    return _wuliuTable;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"物流详情"]];
    [self set_leftButton];
    [self loadData];
    [self setUI];
}

#pragma mark -- setui
- (void)setUI{
    [self.view addSubview:self.wuliuTable];
    [self.wuliuTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kSafeAreaBottomHeight);
    }];
}

#pragma mark -- loaddata
- (void)loadData{
    NSDictionary * param = @{
                                @"sonOrderId":[NSNumber numberWithInteger:self.sonID]
                                        };
    __weak typeof(self) weakSelf = self;
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",kApiPrefix,kApi_listNewLogistics) parameters:param success:^(id  _Nonnull responseObject) {
        WuliuListModel * model = [WuliuListModel mj_objectWithKeyValues:responseObject];
        if ([model.code isEqualToString:@"0"]) {
            [weakSelf.listMuarr addObjectsFromArray:model.result];
            [weakSelf.wuliuTable reloadData];
        }else{
            [weakSelf.view makeToast:model.msg];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -- tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listMuarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 183.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        header.backgroundColor = UIColorFromHex(0xF7F7F7);
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WuliuListCell * wuliuCell =[tableView dequeueReusableCellWithIdentifier:listCellID];
    if (!wuliuCell) {
        wuliuCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([wuliuCell class]) owner:self options:nil]lastObject];
    }
    WuliuListResultModel * resultmodel = [self.listMuarr objectAtIndex:indexPath.section];
    NSString * statusStr;
    switch (resultmodel.state) {
        case WuliuType_Wuguiji:
            statusStr = @"已发货";
            break;
            
        case WuliuType_Yilanshou:
            statusStr = @"已揽收";
            break;
            
        case WuliuType_Zaituzhong:
            statusStr = @"在途中";
            break;
            
        case WuliuType_Yiqianshou:
            statusStr = @"已签收";
            break;
            
        case WuliuType_Wentijian:
            statusStr = @"问题件";
            break;
            
        default:
            break;
    }
    
    wuliuCell.tapblock = ^{
//        BargainLogisticsController * wuliuVC = [[BargainLogisticsController alloc]init];
//        wuliuVC.logisticCode = resultmodel.shippingCode;
//        wuliuVC.logisticCode = resultmodel.shippingName;
//        [self.navigationController pushViewController:wuliuVC animated:YES];
    };
    
    NSMutableArray * picMuarr = [[NSMutableArray alloc]init];
    for (WuliuListGoodsModel *goodsmodel in resultmodel.orderGoodsList) {
        [picMuarr addObject:goodsmodel.goodsThumb];
    }
    
    [wuliuCell updateCellWith:statusStr WuliuSign:NSStringFormat(@"%@:%@",resultmodel.shippingName,resultmodel.shippingCode) WuliuMes:resultmodel.logisticsContent PicArr:picMuarr GoodsCount:NSStringFormat(@"共%ld件商品",(long)resultmodel.goodsNum)];
    return wuliuCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    WuliuListResultModel * resultmodel = [self.listMuarr objectAtIndex:indexPath.section];
//    BargainLogisticsController * wuliuVC = [[BargainLogisticsController alloc]init];
//    wuliuVC.logisticCode = resultmodel.shippingCode;
//    wuliuVC.shippingName = resultmodel.shippingName;
//    [self.navigationController pushViewController:wuliuVC animated:YES];
}

- (UIButton *)set_leftButton{
    UIButton * leftBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [leftBtn setImage:GetImage(@"btn_nav_back") forState:UIControlStateNormal];
    return leftBtn;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
