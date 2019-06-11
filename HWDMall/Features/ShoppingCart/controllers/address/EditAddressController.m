//
//  EditAddressController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/24.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "EditAddressController.h"
#import "AddAddressBottomCell.h"
#import "AddAddressMesCell.h"
#import "OderCellModel.h"
#import "AddAddressView.h"
#import "ConsigneeMesModel.h"
#import "ConsigneeMesModel.h"
static NSString * const addaddresscellID = @"ADDADDRESSCELLID";
static NSString * const addaddressBottomCellID = @"ADDADDRESSBOTTOMCELLIE";

@interface EditAddressController ()<UITableViewDataSource,UITableViewDelegate>
{
    ConsigneeMesModel * _commitModel;
}
@property (nonatomic,strong) UITableView *mesTable;
@property (nonatomic,strong) NSMutableArray *mesMuarr;
@property (nonatomic,strong) AddAddressView *saveBtn;
@property (nonatomic,strong) UIButton *deleteAddBtn; // 删除地址
@property (nonatomic,strong) UIButton * closeBtn; // 全部关闭

@end

@implementation EditAddressController

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

- (UIButton *)deleteAddBtn{
    if (!_deleteAddBtn) {
        _deleteAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteAddBtn setTitle:@"删除地址" forState:UIControlStateNormal];
        [_deleteAddBtn setBackgroundColor:[UIColor whiteColor]];
        [_deleteAddBtn setTitleColor:UIColorFromHex(0xED5E3B) forState:UIControlStateNormal];
        _deleteAddBtn.titleLabel.font = kFont(15);
        [_deleteAddBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _deleteAddBtn;
}

- (AddAddressView *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([AddAddressView class]) owner:self options:nil]lastObject];
        _saveBtn.btnTitle = @"保存";
        __weak typeof(self) weakSelf = self;
        _saveBtn.addBlock = ^{
            [weakSelf saveMes];
        };
    }
    return _saveBtn;
}

- (UITableView *)mesTable{
    if (!_mesTable) {
        _mesTable = [[UITableView alloc]initWithFrame:CGRectZero];
        _mesTable.delegate = self;
        _mesTable.dataSource = self;
        _mesTable.tableFooterView = [UIView new];
        _mesTable.backgroundColor = [UIColor whiteColor];
        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([AddAddressMesCell class]) bundle:nil] forCellReuseIdentifier:addaddresscellID];
        [_mesTable registerNib:[UINib nibWithNibName:NSStringFromClass([AddAddressBottomCell class]) bundle:nil] forCellReuseIdentifier:addaddressBottomCellID];
    }
    return _mesTable;
}
- (NSMutableArray *)mesMuarr{
    if (!_mesMuarr) {
        _mesMuarr = [[NSMutableArray alloc]init];
    }
    return _mesMuarr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"编辑收货地址"]];
    _commitModel = [[ConsigneeMesModel alloc]init];
    [self setUI];
    [self setNav];
    [self set_leftButton];
    [self setData];
}

- (UIButton *)set_leftButton{
    UIButton * leftBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [leftBtn setImage:GetImage(@"btn_nav_back") forState:UIControlStateNormal];
    return leftBtn;
}

- (void)setNav{
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    self.navigationItem.rightBarButtonItems = @[rightitem];
}

#pragma mark -- setData
- (void)setData{
    OderCellModel * nameModel = [[OderCellModel alloc]init];
    nameModel.title = @"联系人:";
    nameModel.key = key_Name;
    nameModel.contentMes = self.mesModel.consignee;
    nameModel.ordercellHeight = 50.f;
    
    OderCellModel * phoneModel = [[OderCellModel alloc]init];
    phoneModel.title = @"手机号码:";
    phoneModel.key = key_PhoneNum;
    phoneModel.contentMes = self.mesModel.mobile;
    phoneModel.ordercellHeight = 50.f;
    
    OderCellModel * addModel = [[OderCellModel alloc]init];
    addModel.title = @"选择地区:";
    addModel.key = key_Address;
    addModel.contentMes = NSStringFormat(@"%@%@%@",self.mesModel.provinceName,self.mesModel.cityName, self.mesModel.districtName);
    addModel.ordercellHeight = 50.f;
    
    OderCellModel * detailAddModel = [[OderCellModel alloc]init];
    detailAddModel.title = @"详细地址:";
    detailAddModel.key = key_DetailAddress;
    detailAddModel.contentMes = self.mesModel.address;
    detailAddModel.ordercellHeight = 50.f;
    
    OderCellModel * setAddModel = [[OderCellModel alloc]init];
    setAddModel.title = @"设为默认地址:";
    setAddModel.key = @"isDefault";
    setAddModel.isDefault = NO;
    setAddModel.contentMes = @"";
    setAddModel.isDefault = self.mesModel.isDefault;
    setAddModel.ordercellHeight = 50.f;
    [self.mesMuarr addObject:nameModel];
    [self.mesMuarr addObject:phoneModel];
    [self.mesMuarr addObject:addModel];
    [self.mesMuarr addObject:detailAddModel];
    [self.mesMuarr addObject:setAddModel];
}

#pragma mark -- setUI
- (void)setUI{
    [self.view addSubview:self.mesTable];
    [self.view addSubview:self.saveBtn];
//    [self.view addSubview:self.deleteAddBtn];
    [self.mesTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.saveBtn.mas_top).offset(-5);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-64);
        make.height.equalTo(49);
    }];
     
//    [self.deleteAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(100);
//        make.top.equalTo(self.saveBtn.mas_bottom).offset(20);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
//        make.centerX.equalTo(self.view.mas_centerX);
//    }];
}

- (void)left_button_event:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- tableviewDelegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mesMuarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OderCellModel * model = [self.mesMuarr objectAtIndex:indexPath.row];
    return model.ordercellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OderCellModel * model = [self.mesMuarr objectAtIndex:indexPath.row];
    if (indexPath.row == 4) {
        AddAddressBottomCell * bottomcell = [tableView dequeueReusableCellWithIdentifier:addaddressBottomCellID];
        if (!bottomcell) {
            bottomcell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([AddAddressBottomCell class])
                                                       owner:self
                                                     options:nil]lastObject];
        }
        [bottomcell commitModel:_commitModel Contentmodel:model];
        return bottomcell;
    }else{
        AddAddressMesCell * mesCell = [tableView dequeueReusableCellWithIdentifier:addaddresscellID];
        if (!mesCell) {
            mesCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([AddAddressMesCell class])
                                                    owner:self
                                                  options:nil]lastObject];
        }
        __weak typeof(self) weakSelf = self;
        mesCell.changeBlock = ^{
            [weakSelf.mesTable beginUpdates]; // 刷新cell 高度
            [weakSelf.mesTable endUpdates];
        };
        mesCell.updateAddressblock = ^(NSString *address) {
            model.contentMes = address;
            NSIndexPath *indexPathArr=[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            [weakSelf.mesTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathArr,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        [mesCell refreshContent:model commitModel:_commitModel];
        return mesCell;
    }
}

#pragma mark -- buttonAction
- (void)saveMes{
    RDLog(@"%@",_commitModel.address);
    if (![_commitModel.cityName deleteBlank].length) {
        _commitModel.cityName = self.mesModel.cityName;
    }
    
    if (!_commitModel.cityID) {
        _commitModel.cityID = self.mesModel.city;
    }
    
    if (![_commitModel.provinceName deleteBlank].length) {
        _commitModel.provinceName = self.mesModel.provinceName;
    }
    
    if (!_commitModel.provinceID) {
        _commitModel.provinceID = self.mesModel.province;
    }
    
    if (!_commitModel.districtName.length) {
        _commitModel.districtName = self.mesModel.districtName;
    }
    
    if (!_commitModel.districtID) {
        _commitModel.districtID = self.mesModel.district;
    }
    if ([_commitModel checkAddressMes]) {
    
        NSDictionary *params = @{
                                 
                                    @"addressId":[NSNumber numberWithInteger:self.mesModel.addressId],
                                     @"consignee":_commitModel.consignee,
                                     @"mobile":_commitModel.mobile,
                                     @"province":[NSNumber numberWithInteger:_commitModel.provinceID],
                                     @"city":[NSNumber numberWithInteger:_commitModel.cityID],
                                     @"district":[NSNumber numberWithInt:(int)_commitModel.districtID],
                                     @"provinceName":_commitModel.provinceName,
                                     @"cityName":_commitModel.cityName,
                                     @"districtName":_commitModel.districtName,
                                     @"address":_commitModel.address,
                                     @"isDefault":[NSNumber numberWithInt:(int)_commitModel.isDefault],
                                    
                                 };
        __weak typeof(self) weakSelf = self;
        [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",kApiPrefix,kApi_updateAddress) parameters:params success:^(id  _Nonnull responseObject) {
            if ([[responseObject objectForKey:@"code"]isEqualToString:@"0"]) {
                self->_editBlock ? weakSelf.editBlock(self.mesModel) : nil;
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf.view makeToast: [responseObject objectForKey:@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
        }];
        
    }else{
        [kWindow makeToast:_commitModel.errorMes];
    }
}

- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)deleteAction:(UIButton *)sender{
    if (sender == self.deleteAddBtn ) {
        RDLog(@"删除地址");
    }
}

@end
