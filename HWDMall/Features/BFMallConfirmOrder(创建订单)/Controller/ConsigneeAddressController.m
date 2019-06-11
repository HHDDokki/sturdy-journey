//
//  ConsigneeAddressController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConsigneeAddressController.h"
#import "AddAddressView.h"
#import "AddAddressController.h"
#import "ConsigneeListCell.h"
#import "EditAddressController.h"
#import "HHDAlertView.h"

#define noDataMes @"您还没有收货地址，马上添加一个吧～"

static NSString * const addressCellID = @"ADDRESSCELLID";

@interface ConsigneeAddressController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *addressTable; // 地址列表
@property (nonatomic,strong) NSMutableArray *addressMuarr; // 地址数据
@property (nonatomic,strong) AddAddressView * addAddressView;
@property (nonatomic,strong) UIButton * closeBtn; // 全部关闭

@end

@implementation ConsigneeAddressController

#pragma mark -- lazyload
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(0, 0, 22, 44);
        [_closeBtn setImage:IMAGE_NAME(@"关闭") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(clossAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (NSMutableArray *)addressMuarr{
    if (!_addressMuarr) {
        _addressMuarr = [[NSMutableArray alloc]init];
    }
    return _addressMuarr;
}

- (AddAddressView *)addAddressView{
    if (!_addAddressView) {
        _addAddressView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([AddAddressView class])
                                                        owner:self
                                                      options:nil]lastObject];
        __weak typeof(self) weakSelf = self;
        [_addAddressView.ManualBtn setImage:IMAGE_NAME(@"添加新的收货地址-加号按钮上") forState:UIControlStateNormal];
        _addAddressView.addBlock = ^{
            [weakSelf addAddressAction];
        };
    }
    return _addAddressView;
}

- (UITableView *)addressTable{
    if (!_addressTable) {
//        LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:@"detail_pic_noaddress_normal"
//                                                                 titleStr:noDataMes
//                                                                detailStr:@""
//                                                              btnTitleStr:@""
//                                                            btnClickBlock:^{}];
        //元素竖直方向的间距
//        emptyView.subViewMargin = 5.f;
//        emptyView.contentViewY = 130;
//        emptyView.imageSize = CGSizeMake(75, 75);
//        //标题颜色
//        emptyView.titleLabTextColor = UIColorFromHex(0x999999);
//        //描述字体
//        emptyView.titleLabFont = kFont(13);
        //按钮背景色
        _addressTable = [[UITableView alloc]initWithFrame:CGRectZero];
        _addressTable.delegate = self;
        _addressTable.dataSource = self;
        _addressTable.tableFooterView = [UIView new];
        _addressTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _addressTable.ly_emptyView = emptyView;
        _addressTable.backgroundColor = [UIColor whiteColor];
        [_addressTable registerNib:[UINib nibWithNibName:NSStringFromClass([ConsigneeListCell class]) bundle:nil] forCellReuseIdentifier:addressCellID];
    }
    return _addressTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"我的地址"]];
    [self set_leftButton];
    [self setNav];
    [self setUI];
    [self setData];
}

- (void)setData{
    [self.view makeToastActivity];
    [self.addressMuarr removeAllObjects];
    __weak typeof(self) weakSelf = self;
    [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_findMyAddressList) parameters:@{} success:^(id  _Nonnull responseObject) {
        [weakSelf.view hideToastActivity];
        ConsigneeMesModel * addressmodel = [ConsigneeMesModel mj_objectWithKeyValues:responseObject];
        if ([addressmodel.code isEqualToString:@"0"]) {
            [weakSelf.addressMuarr addObjectsFromArray:addressmodel.result];
            [weakSelf.addressTable reloadData];
        }else{
            [weakSelf.view makeToast:addressmodel.msg];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -- setView

- (void)setNav{
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    self.navigationItem.rightBarButtonItems = @[rightitem];
}

- (void)setUI{
    [self.view addSubview:self.addressTable];
//    [self.view addSubview:self.addAddressView];
    [self.addressTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
//    [self.addAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
//        make.height.equalTo(55);
//    }];
}
- (UIButton *)set_leftButton{
    UIButton * leftBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [leftBtn setImage:GetImage(@"btn_nav_back") forState:UIControlStateNormal];
    return leftBtn;
}

- (void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- tableviewDelegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 8.0)];
//    footer.backgroundColor = [UIColor hexColor:@"#EEF1F3"];
    
    return self.addAddressView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressMuarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsigneeListCell * addressCell = [tableView dequeueReusableCellWithIdentifier:addressCellID];
    if (!addressCell) {
        addressCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ConsigneeListCell class])
                                                    owner:self
                                                  options:nil]lastObject];
    }
    AddressListModel * model = [self.addressMuarr objectAtIndex:indexPath.row];
    [addressCell setContentWithConsigneeMesModel:model];
    __weak typeof(self) weakSelf = self;
    addressCell.editBlock = ^(AddressListModel * _Nonnull model) {
        EditAddressController * editAddVC = [[EditAddressController alloc]init];
        editAddVC.mesModel = model;
        editAddVC.editBlock = ^(AddressListModel *model) {
            [weakSelf setData];
        };
        [weakSelf.navigationController pushViewController:editAddVC animated:YES];
        
    };
    addressCell.deleteBlock = ^(AddressListModel * _Nonnull model) {
        
        HHDAlertView *hhdalertView = [[HHDAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        hhdalertView.confirmTitle = @"确定";
        hhdalertView.cancelTitle = @"取消";
        hhdalertView.mesStr = @"确定删除该地址?";
        [kWindow addSubview:hhdalertView];
        hhdalertView.cancelBlock = ^{
            
        };
        hhdalertView.confirmBlock = ^{
            [weakSelf.view makeToastActivity];
            [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",@"http://47.93.216.16:7081",kApi_deleteAddress) parameters:@{@"addressId":[NSNumber numberWithInteger:model.addressId]} success:^(id  _Nonnull responseObject) {
                [weakSelf.view hideToastActivity];
                if ([[responseObject objectForKey:@"code"]isEqualToString:@"0"]) {
                    [weakSelf setData];
                }else{
                    [weakSelf.view makeToast:[responseObject objectForKey:@"msg"]];
                }
                
            } failure:^(NSError * _Nonnull error) {
                [weakSelf.view hideToastActivity];
            }];
        };
        
    };
    return addressCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     AddressListModel * model = [self.addressMuarr objectAtIndex:indexPath.row];
    if (self.selectedBlock) {
        [self.navigationController popViewControllerAnimated:YES];
        self.selectedBlock(model);
    }
}


#pragma mark -- buttonAction
- (void)addAddressAction{
    RDLog(@"push");
    AddAddressController * add = [[AddAddressController alloc]init];
    __weak typeof(self) weakSelf = self;
    add.addBlock = ^(ConsigneeMesModel * _Nonnull model) {
        [weakSelf setData];
    };
    [self.navigationController pushViewController:add animated:YES];
}

- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
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
