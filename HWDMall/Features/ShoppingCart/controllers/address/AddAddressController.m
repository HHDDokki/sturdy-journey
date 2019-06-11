//
//  AddAddressController.m
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "AddAddressController.h"
#import "AddAddressBottomCell.h"
#import "AddAddressMesCell.h"
#import "OderCellModel.h"
#import "AddAddressView.h"
#import "ConsigneeMesModel.h"
#import "HHDAlertView.h"

static NSString * const addaddresscellID = @"ADDADDRESSCELLID";
static NSString * const addaddressBottomCellID = @"ADDADDRESSBOTTOMCELLIE";

@interface AddAddressController ()<UITableViewDataSource,UITableViewDelegate>
{
    ConsigneeMesModel * _commitModel;
}

@property (nonatomic,strong) UITableView *mesTable;
@property (nonatomic,strong) NSMutableArray *mesMuarr;
@property (nonatomic,strong) AddAddressView *saveBtn;
@end

@implementation AddAddressController
#pragma mark -- lazyload
- (AddAddressView *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([AddAddressView class]) owner:self options:nil]lastObject];
        _saveBtn.btnTitle = @"保存";
        __weak typeof(self) weakSelf = self;
        _saveBtn.addBlock = ^{
            [weakSelf saveAction];
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
    [self set_Title:[[NSMutableAttributedString  alloc] initWithString:@"添加收货地址"]];
    // Do any additional setup after loading the view.
    _commitModel = [[ConsigneeMesModel alloc]init];
    [self setUI];
    [self set_leftButton];
    [self setData];
    self.hideSlideRecognizer = NO;
}

#pragma mark -- setData
- (void)setData{
    OderCellModel * nameModel = [[OderCellModel alloc]init];
    nameModel.title = @"联系人:";
    nameModel.key = key_Name;
    nameModel.contentMes = @"";
    nameModel.ordercellHeight = 50.f;
    
    OderCellModel * phoneModel = [[OderCellModel alloc]init];
    phoneModel.title = @"手机号码:";
    phoneModel.key = key_PhoneNum;
    phoneModel.contentMes = @"";
    phoneModel.ordercellHeight = 50.f;
    
    OderCellModel * addModel = [[OderCellModel alloc]init];
    addModel.title = @"选择地区:";
    addModel.key = key_Address;
    addModel.contentMes = @"";
    addModel.ordercellHeight = 50.f;
    
    OderCellModel * detailAddModel = [[OderCellModel alloc]init];
    detailAddModel.title = @"详细地址:";
    detailAddModel.key = key_DetailAddress;
    detailAddModel.contentMes = @"";
    detailAddModel.ordercellHeight = 50.f;
    
    OderCellModel * setAddModel = [[OderCellModel alloc]init];
    setAddModel.title = @"设为默认地址:";
    setAddModel.key = @"isDefault";
    setAddModel.isDefault = NO;
    setAddModel.contentMes = @"";
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
    [self.mesTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.saveBtn.mas_top).offset(-5);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.height.equalTo(110);
    }];
}

- (UIButton *)set_leftButton{
    UIButton * leftBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [leftBtn setImage:GetImage(@"btn_nav_back") forState:UIControlStateNormal];
    return leftBtn;
}

- (void)left_button_event:(UIButton *)sender{
    BOOL isEdit = [_commitModel.consignee deleteBlank].length || [_commitModel.mobile deleteBlank].length || [_commitModel.provinceName deleteBlank].length || [_commitModel.cityName deleteBlank].length || [_commitModel.address deleteBlank].length;
    if (isEdit) {
        HHDAlertView *alerView = [[HHDAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        alerView.mesStr = @"现在退出将不会保存已添写的信息，是否确定退出？";
        __weak typeof(self) weakSelf = self;
        alerView.confirmBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        [kWindow addSubview:alerView];
    }else{
     [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- tableviewDelegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mesMuarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    OderCellModel * model = [self.mesMuarr objectAtIndex:indexPath.row];
    return 51;
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
            [mesCell refreshContent: model commitModel:_commitModel];
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
            return mesCell;
        }
}

#pragma mark -- buttonAction
- (void)saveAction{
    RDLog(@"%@",_commitModel);
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:_commitModel.consignee forKey:key_Name];
    [params setValue:_commitModel.mobile forKey:key_PhoneNum];
    [params setValue:[NSNumber numberWithInteger:_commitModel.provinceID] forKey:@"province"];
     [params setValue:_commitModel.districtName forKey:@"districtName"];
    [params setValue:[NSNumber numberWithInteger:_commitModel.cityID] forKey:@"city"];
    [params setValue:[NSNumber numberWithInteger:_commitModel.districtID] forKey:@"district"];
    [params setValue:_commitModel.provinceName forKey:@"provinceName"];
    [params setValue:_commitModel.cityName forKey:@"cityName"];
    [params setValue:_commitModel.address forKey:key_DetailAddress];
    if (_commitModel.isDefault) {
      [params setValue:@1 forKey:@"isDefault"];
    }else{
        [params setValue:@0 forKey:@"isDefault"];
    }
    
    if ([_commitModel checkAddressMes]) {
        __weak typeof(self) weakSelf = self;
        [[WebServiceTool shareHelper]postWithURLString:NSStringFormat(@"%@%@",kApiPrefix,kApi_addAddress) parameters:params success:^(id  _Nonnull responseObject) {
            if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
                [weakSelf.view makeToast:[responseObject objectForKey:@"msg"]];
                if (weakSelf.addBlock) {
                    weakSelf.addBlock(nil);
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf.view makeToast:[responseObject objectForKey:@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }else{
        [self.view makeToast:_commitModel.errorMes];
    }
}

@end
