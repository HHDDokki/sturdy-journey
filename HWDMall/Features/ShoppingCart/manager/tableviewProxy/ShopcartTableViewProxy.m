//
//  ShopcartTableViewProxy.m
//  HWDMall
//
//  Created by stewedr on 2018/11/8.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ShopcartTableViewProxy.h"

/* ----------- 购物车相关 -----------*/
#import "ShoppingcartHeader.h"
#import "ShoppingcartUnusebleHeader.h"
#import "ShoppingcarGoodsCell.h"
#import "ShoppingCartCustomModel.h"
#import "ShoppingCartModel.h"

//#import "BFMallConfirmOrderVipRightsCell.h"
#import "BFMallIOrderVipChoiceCell.h"

#import "BFMallShoppingcartHeaderView.h"


static NSString * const shoppingcartCellID = @"SHOPPINGCARTCELLID";
static NSString * const shoppingcartVipCellID = @"SHOPPINGCARTVIPCELLID";
static NSString * const shoppingcartHeaderID = @"SHOPPINGCARTHEADERID";
static NSString * const shoppingcartUnuseHeaderID = @"SHOPPINGCARTUNUSERHEAD";

@implementation ShopcartTableViewProxy


#pragma mark -- tableviewDelegate and Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == self.dataArray.count) {
        return 1;
    }
    ShoppingCartCustomModel * custommodel = [self.dataArray objectAtIndex:section];
    return custommodel.shopGoodMuarr.count;;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArray.count == 0) {
        return 0;
    }
    return self.dataArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.dataArray.count) {
        return 144;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == self.dataArray.count) {
        return 0.01;
    }
    ShoppingCartCustomModel * custommodel = [self.dataArray objectAtIndex:section];
    if (!custommodel.isUsable) {
        return 40;
    }
    
//    else if (section != 0) {
//        return 0.001;
//    }
    else return 0.001;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section == self.dataArray.count - 1) {
//        return CGFLOAT_MIN;
//    }
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
    footer.backgroundColor = [UIColor hexColor:@"#EEF1F3"];
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == self.dataArray.count) {
        return [UIView new];
    }
    ShoppingCartCustomModel * custommodel = [self.dataArray objectAtIndex:section];
//    if (custommodel.isUsable && section == 0) {
//
//        BFMallShoppingcartHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:shoppingcartHeaderID];
//        if (!header) {
//            header = [[BFMallShoppingcartHeaderView alloc] initWithReuseIdentifier:shoppingcartHeaderID];
//        }
//        header.backgroundColor = [UIColor blackColor];
//        __weak typeof(self) weakSelf = self;
//        header.selectedBlock = ^(BOOL selectStatus) {
//            if (weakSelf.selectAllBlock) {
//                weakSelf.selectAllBlock(selectStatus);
//            }
//        };
//        header.deleteBlock = ^{
//
//        };
//
//        return header;
//    }
//    if (custommodel.isUsable) {
//        ShoppingcartHeader * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:shoppingcartHeaderID];
//        if (!header) {
//            header = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ShoppingcartHeader class]) owner:self options:nil]lastObject];
//        }
//        [header updateHeaderMesWithShopName:custommodel.shopName SeletectedStatus:custommodel.isSelectedStatus];
//        __weak typeof(self) weakSelf = self;
//        header.selectedBlock = ^(BOOL selectStatus) {
//            if (weakSelf.shopcartProxyBrandSelectBlock) {
//                weakSelf.shopcartProxyBrandSelectBlock(selectStatus, section);
//            }
//        };
//        header.selectShopName = ^(BOOL selectStatus) {
//            if (weakSelf.selectShopBlock) {
//                weakSelf.selectShopBlock(section);
//            }
//        };
//        return header;
//    }else{
    if (!custommodel.isUsable) {
        ShoppingcartUnusebleHeader * unuserHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:shoppingcartUnuseHeaderID];
        if (!unuserHeader) {
            unuserHeader = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ShoppingcartUnusebleHeader class]) owner:self options:nil]lastObject];
        }
        __weak typeof(self) weakSelf = self;
        unuserHeader.deleteBlock = ^{
            if (weakSelf.deleteUnuseBlock) {
                weakSelf.deleteUnuseBlock();
            }
        };
        return unuserHeader;
    }
    return [[UIView alloc] init];
    
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == self.dataArray.count) {
        
        BFMallIOrderVipChoiceCell * shoppingcartCell = [tableView dequeueReusableCellWithIdentifier:shoppingcartVipCellID];
        [shoppingcartCell changeState:self.resultModel.isVipUser];

        if (self.resultModel.isVipUser) {
            [shoppingcartCell updateSavedPrice:self.resultModel.savePrice];
        }else {
            [shoppingcartCell updateVipPrice:self.resultModel.buyVipPrice TotalSavedPrice:self.resultModel.savePrice];
        }
        
        WK(weakSelf);
        shoppingcartCell.vipChoiceBlock = ^(BOOL btnState) {
            if (weakSelf.selectVipBlock) {
                weakSelf.selectVipBlock(btnState);
            }
        };
        return shoppingcartCell;
        
    }

    ShoppingcarGoodsCell * shoppingcartCell = [tableView dequeueReusableCellWithIdentifier:shoppingcartCellID];
    if (!shoppingcartCell) {
        shoppingcartCell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([shoppingcartCellID class]) owner:self options:nil]lastObject];
    }
    
    if (self.dataArray.count == 0) {
        return [[UITableViewCell alloc] init];
    }
    ShoppingCartCustomModel * model = [self.dataArray objectAtIndex:indexPath.section];
    
    if (model.shopGoodMuarr.count == 1) {
        shoppingcartCell.roundCornerType = KKRoundCornerCellTypeSingleRow;
    } else if (indexPath.row == 0) {
        shoppingcartCell.roundCornerType = KKRoundCornerCellTypeTop;
    } else if (indexPath.row == model.shopGoodMuarr.count - 1) {
        shoppingcartCell.roundCornerType = KKRoundCornerCellTypeBottom;
    } else {
        shoppingcartCell.roundCornerType = KKRoundCornerCellTypeDefault;
    }
    ShoppingcartGoodsModel * goodsmodel = [model.shopGoodMuarr objectAtIndex:indexPath.row];
    shoppingcartCell.cartid = goodsmodel.cartId;
    [shoppingcartCell updateCellMesWithHeadUrl:goodsmodel.goodsThumb GoodsName:goodsmodel.goodsName GoodsGuige:goodsmodel.specKeyName GoodsPrice:NSStringFormat(@"%.2f",goodsmodel.goodsPrice) GoodsCount:goodsmodel.goodsNum GoodsUnuse:!model.isUsable GoosSeletedStatus:goodsmodel.selected normalSinglePrice:NSStringFormat(@"%.2f",goodsmodel.normalSinglePrice) VipPrice:NSStringFormat(@"会员价：¥%.2f", goodsmodel.vipSinglePrice)];
    shoppingcartCell.shopgoodsStatus = goodsmodel.status;
    __weak typeof(self) weakSelf = self;
    shoppingcartCell.selectBlock = ^(BOOL cellStatus) {
        if (weakSelf.shopcartProxyProductSelectBlock) {
            weakSelf.shopcartProxyProductSelectBlock(cellStatus, indexPath);
        }
    };
    shoppingcartCell.changcountblockBlock = ^(NSInteger count) {
        if (weakSelf.shopcartProxyChangeCountBlock) {
            weakSelf.shopcartProxyChangeCountBlock(count, indexPath);
        }
    };
    return shoppingcartCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count) {
        
        if (indexPath.section == self.dataArray.count) {
            return;
        }
        ShoppingCartCustomModel * model = [self.dataArray objectAtIndex:indexPath.section];
        ShoppingcartGoodsModel * goodsmodel = [model.shopGoodMuarr objectAtIndex:indexPath.row];
        if (goodsmodel.status == ShopingCartGoodsStatus_shangjia || goodsmodel == ShopingCartGoodsStatus_wuhuo) {
            if (self.selectedBlock) {
                self.selectedBlock(indexPath);
            }
        }
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RDLog(@"删除");
        if (self.shopcartProxyDeleteBlock) {
            self.shopcartProxyDeleteBlock(indexPath);
        }
    }
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RDLog(@"编辑%ld",(long)indexPath.row);
}


- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    RDLog(@"结束编辑%ld",(long)indexPath.row);
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


@end
