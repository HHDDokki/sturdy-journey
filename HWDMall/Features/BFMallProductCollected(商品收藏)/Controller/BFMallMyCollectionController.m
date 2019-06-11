//
//  BFMallMyCollectionController.m
//  HWDMall
//
//  Created by HandC1 on 2019/6/2.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "BFMallMyCollectionController.h"
#import "BFMallShoppingcartHeaderView.h"
#import "BFMallCollectionBottomView.h"
#import "BFMallCollectionCell.h"
#import "BFMallCollectionModel.h"
#import "WebMemberController.h"


@interface BFMallMyCollectionController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mesTable;
@property (nonatomic, strong) UIButton * editBtn; // 编辑
@property (nonatomic, strong) UIButton * closeBtn; //全部关闭
@property (nonatomic, strong) BFMallShoppingcartHeaderView *topView; //全选
@property (nonatomic, strong) BFMallCollectionBottomView *bottomView; //取消收藏
@property (nonatomic, strong) NSMutableArray *dataArr; //数据源
@property (nonatomic, strong) NSMutableArray *selectedGoodsMuarr; //选中的model
@property (nonatomic, assign) NSInteger currentPage; //当前页
@property (nonatomic, strong) BFMallCollectionModel *model;
//@property (nonatomic, strong) UIView *noneView;
@property (nonatomic) BOOL isEditState;

@end

@implementation BFMallMyCollectionController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"商品收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    self.isEditState = NO;
    self.currentPage = 1;
    self.dataArr = [NSMutableArray array];
    [self loadData];
    [self setNav];
    [self setUI];
    
}

- (void)setNav{
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    UIBarButtonItem * leftitem = [[UIBarButtonItem alloc]initWithCustomView:self.editBtn];
    self.navigationItem.rightBarButtonItems = @[rightitem,leftitem];
}

- (void)setUI {
    
    self.topView.frame = CGRectMake(0, 0, SCREEN_W, 0);
    self.bottomView.frame = CGRectMake(0, 0, SCREEN_W, 50);
    self.bottomView.hidden = YES;
    self.topView.hidden = YES;
    self.mesTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topView.bottom, SCREEN_W, SCREEN_H-kSafeAreaTopHeight+kSafeAreaBottomHeight)];
    LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:@"man-没有订单"
                                                             titleStr:@""
                                                            detailStr:@""
                                                          btnTitleStr:@""
                                                        btnClickBlock:^{}];
    //元素竖直方向的间距
    emptyView.subViewMargin = 12.f;
    emptyView.contentViewY = 130;
    emptyView.imageSize = CGSizeMake(SCREEN_W/3, 0.47*SCREEN_W/3);
    //标题颜色
    emptyView.titleLabTextColor = UIColorFromHex(0x999999);
    //描述字体
    emptyView.titleLabFont = kFont(13);
    self.mesTable.ly_emptyView = emptyView;
    self.mesTable.backgroundColor = [UIColor whiteColor] ;
    self.mesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mesTable.delegate = self;
    self.mesTable.dataSource = self;
    self.mesTable.tableHeaderView = self.topView;
    self.mesTable.tableFooterView = self.bottomView;
    [self.mesTable registerClass:[BFMallCollectionCell class] forCellReuseIdentifier:@"BFMallCollectionCell"];
    [self.view addSubview:self.mesTable];
    if ([self.mesTable respondsToSelector:@selector(setSeparatorInset:)]) {
          [self.mesTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.mesTable respondsToSelector:@selector(setLayoutMargins:)]) {
          [self.mesTable setLayoutMargins:UIEdgeInsetsZero];
    }

    WK(weakSelf);
    self.mesTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        weakSelf.currentPage += 1;
        [weakSelf loadData];

    }];
    self.mesTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.currentPage = 1;
        [weakSelf.dataArr removeAllObjects];
        [weakSelf loadData];
        
    }];
    
//    self.noneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, self.mesTable.height)];
//    self.noneView.backgroundColor = [UIColor hexColor:@"#999999"];
//    [self.mesTable addSubview:self.noneView];
//    UIImageView *noneImage = [[UIImageView alloc] initWithFrame:CGRectZero];
//    [self.noneView addSubview:noneImage];
//    [noneImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.mesTable.mas_centerY).offset(-15);
//        make.centerX.equalTo(self.mesTable.mas_centerX);
//        make.width.equalTo(180);
//        make.height.equalTo(80);
//    }];
//
//    [noneImage setImage:[UIImage imageNamed:@"man-没有订单"]];
//    UILabel *noneText = [[UILabel alloc] initWithFrame:CGRectMake(0, noneImage.bottom + 12, 0, 0)];
//    noneText.textColor = [UIColor hexColor:@"#999999"];
//    noneText.font = kFont(13);
//    noneText.text = @"暂无收藏";
//    [noneText sizeToFit];
//    noneText.centerX = noneImage.centerX;
//    [self.noneView addSubview:noneText];
//    self.noneView.hidden = YES;
    
}

- (void)loadData {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSString stringWithFormat:@"%ld",(long)self.currentPage] forKey:@"pageNum"];
    [param setObject:[NSString stringWithFormat:@"%d",2] forKey:@"type"];
    [param setObject:@"10" forKey:@"pageSize"];
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     @"http://47.93.216.16:7081", API_SHOPCOLLECT_LIST];
    [[WebServiceTool shareHelper] postWithURLString:url parameters:param success:^(id  _Nonnull responseObject) {
        
        self.model = [BFMallCollectionModel objectForModelObject:responseObject withError:nil];
        
        if (self.currentPage > 1) {
            
            if (self.model.result.count == 0) {
                [self.mesTable.mj_footer endRefreshing];
                self.currentPage -= 1;
                return;
            }
            [self.mesTable.mj_footer endRefreshing];
            [self.dataArr addObjectsFromArray:self.model.result];
            [self.mesTable reloadData];
            return;
        }else {
            [self.mesTable.mj_header endRefreshingWithCompletionBlock:nil];
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:self.model.result];
        }
        
        [self.mesTable reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.dataArr.count == 0) {
//        self.noneView.hidden = NO;
//    }else {
//        self.noneView.hidden = YES;
//    }
    return self.dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 114;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BFMallCollectionDetailModel *model = self.dataArr[indexPath.row];
    BFMallCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BFMallCollectionCell"];
    if (!cell) {
        cell = [[BFMallCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BFMallCollectionCell"];
    }
    [cell bindModel:self.dataArr[indexPath.row]];
    [cell stateChangeWithState:self.isEditState];
    WK(weakSelf);
    cell.selectedBlock = ^(BOOL btnStatus) {
        if([weakSelf.selectedGoodsMuarr containsObject:model]) {
            [weakSelf.selectedGoodsMuarr removeObject:model];
        }else {
            [weakSelf.selectedGoodsMuarr addObject:model];
        }
        if (weakSelf.selectedGoodsMuarr.count == self.dataArr.count) {
            self.topView.selectedBtn.selected = YES;
        }else {
            self.topView.selectedBtn.selected = NO;
        }
    };
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BFMallCollectionDetailModel *model = self.dataArr[indexPath.row];
    WebMemberController *vc = [[WebMemberController alloc] init];
    vc.webUrl = NSStringFormat(@"http://39.106.97.82:8107/articleDetail/%ld", (long)model.articleId);
    vc.type = BFMALL_COMMON;
    [self.navigationController pushViewController:vc animated:NO];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.model.result || self.model.result.count == 0) {
        return NO;
    }
    return YES;
}

//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

//侧滑出现的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

//执行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        BFMallCollectionDetailModel *detailModel = self.model.result[indexPath.row];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:[NSString stringWithFormat:@"%d",2] forKey:@"type"];
        [param setObject:[NSString stringWithFormat:@"%ld",(long)detailModel.articleId] forKey:@"collectId"];
        NSString *url = [NSString stringWithFormat:@"%@%@",
                         @"http://47.93.216.16:7081", API_REMOVE];
        
        [[WebServiceTool shareHelper] postWithURLString:url parameters:param success:^(id  _Nonnull responseObject) {
            
            
            NSMutableArray *tempProductList = [[NSMutableArray alloc] initWithArray:self.dataArr];
            [tempProductList removeObjectAtIndex:indexPath.row];
            self.dataArr = [tempProductList copy];
            BFMallCollectionDetailModel *model = self.dataArr[indexPath.row];
            if ([self.selectedGoodsMuarr containsObject:model]) {
                [self.selectedGoodsMuarr removeObject:model];
            }
            [self.mesTable beginUpdates];
            [self.mesTable deleteRowsAtIndexPaths:@[indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
            [self.mesTable endUpdates];
            [self.model.result removeObjectAtIndex:indexPath.row];
            //            [self.mainTable reloadData];
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
        
    }
    
}

- (void)removeCollectionWithGoodsCollectEntities:(NSMutableArray *)goodsCollectEntities {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:goodsCollectEntities forKey:@"goodsCollectEntities"];
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     @"http://47.93.216.16:7081", API_REMOVE];
    
    [[WebServiceTool shareHelper] postWithURLString:url parameters:param success:^(id  _Nonnull responseObject) {
        
        [self.dataArr removeObjectsInArray:self.selectedGoodsMuarr];
        [self.selectedGoodsMuarr removeAllObjects];
        [self.mesTable reloadData];
//        NSMutableArray *tempProductList = [[NSMutableArray alloc] initWithArray:self.dataArr];
//        [tempProductList removeObjectAtIndex:indexPath.row];
//        self.dataArr = [tempProductList copy];
//        ProductCollectDetailModel *model = self.dataArr[indexPath.row];
//        if ([self.selectedGoodsMuarr containsObject:model]) {
//            [self.selectedGoodsMuarr removeObject:model];
//        }
//        [self.mesTable beginUpdates];
//        [self.mesTable deleteRowsAtIndexPaths:@[indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
//        [self.mesTable endUpdates];
//        [self.model.result removeObjectAtIndex:indexPath.row];
        //            [self.mainTable reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}


- (void)clossAll {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)editBtnAction:(UIButton *)sender {
    
    sender.selected ^= 1;
    self.isEditState = sender.selected;
    self.topView.selectedBtn.selected = NO;
    if (!self.isEditState) {
        self.topView.height = 0;
        self.topView.hidden = YES;
        self.bottomView.deleteBtn.hidden = YES;
    }else {
        self.topView.height = 40;
        self.topView.hidden = NO;
        self.bottomView.deleteBtn.hidden = NO;
    }
    [self.mesTable reloadData];
}


#pragma mark -- setter & getter
//- (UITableView *)mesTable {
//
//    if (!_mesTable) {
//        _mesTable = [[UITableView alloc] initWithFrame:CGRectZero];
//        _mesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
////        LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:@"shopcartnomes"
////                                                                 titleStr:nomesTitle
////                                                                detailStr:@"都在买什么吧～～～"
////                                                              btnTitleStr:@""
////                                                            btnClickBlock:^{}];
////        //元素竖直方向的间距
////        emptyView.subViewMargin = 5.f;
////        emptyView.contentViewY = 200;
////        emptyView.imageSize = CGSizeMake(75, 75);
////        //标题颜色
////        emptyView.titleLabTextColor = UIColorFromHex(0x999999);
////        emptyView.detailLabTextColor = UIColorFromHex(0x999999);
////        //描述字体
////        emptyView.titleLabFont = kFont(13);
////        emptyView.detailLabFont = kFont(13);
////        _viewList.ly_emptyView = emptyView;
//
//        _mesTable.delegate = self;
//        _mesTable.dataSource = self;
//        _mesTable.tableFooterView = [UIView new];
//        _mesTable.backgroundColor = [UIColor blackColor];
//        [_mesTable registerClass:[BFMallCollectionCell class] forCellReuseIdentifier:@"BFMallCollectionCell"];
////        _mesTable.estimatedRowHeight = 0;
////        _mesTable.estimatedSectionHeaderHeight = 0;
////        _mesTable.estimatedSectionFooterHeight = 0;
//        //        if (@available(iOS 11.0, *)) {
//        //            _viewList.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//        //        }else {
//        //            self.automaticallyAdjustsScrollViewInsets = NO;
//        //        }
//        __weak typeof(self) weakSelf = self;
//        _mesTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////            weakSelf.pageNum = 1;
////            weakSelf.lastPageNum = 1;
////            [weakSelf.unusebleModel.shopGoodMuarr removeAllObjects];
////            [weakSelf.selectedGoodsMuarr removeAllObjects];
////            [weakSelf.muData removeAllObjects];
////            [weakSelf setDataWithQueue:nil shouldReload:NO];
////            [weakSelf getTotalMoney:@[]IsAllSelected:NO paramsDic:nil];
////            [weakSelf.viewList.mj_footer resetNoMoreData];
//        }];
//
//        _mesTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
////            weakSelf.pageNum++;
////            weakSelf.lastPageNum++;
////            [weakSelf setDataWithQueue:nil shouldReload:NO];
//        }];
//    }
//    return _mesTable;
//
//}

- (BFMallShoppingcartHeaderView *)topView {
    if (!_topView) {
        _topView = [[BFMallShoppingcartHeaderView alloc] initWithFrame:CGRectZero];
        _topView.isAllSelected = NO;
        __weak typeof(self) weakSelf = self;
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.selectedBlock = ^(BOOL btnStatus) {
            NSMutableArray * selectedMuarr = [[NSMutableArray alloc]init];
            if (btnStatus) { // 全部取消选中
                for (BFMallCollectionDetailModel *model in weakSelf.dataArr) {
                    model.isSelectedStatus = NO;
                }
                [weakSelf.selectedGoodsMuarr removeAllObjects];
                weakSelf.topView.selectedBtn.selected = NO;
                weakSelf.topView.deleteBtn.hidden = YES;
                [weakSelf.mesTable reloadData];
    
            }else{// 全部选中
                for (BFMallCollectionDetailModel *model in weakSelf.dataArr) {
                    model.isSelectedStatus = YES;
                }
                [weakSelf.selectedGoodsMuarr removeAllObjects];
                [weakSelf.selectedGoodsMuarr addObjectsFromArray:weakSelf.dataArr];
                weakSelf.topView.selectedBtn.selected = YES;
                weakSelf.topView.deleteBtn.hidden = NO;
                [weakSelf.mesTable reloadData];
            }
        };
    }
    return _topView;
    
}

- (BFMallCollectionBottomView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[BFMallCollectionBottomView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _bottomView.deleteBlock = ^{
            NSMutableArray *goodsCollectEntities = [NSMutableArray array];
            for (BFMallCollectionDetailModel *model in weakSelf.selectedGoodsMuarr) {
                NSDictionary *dic = @{@"collectId":[NSNumber numberWithInteger:model.articleId], @"status":@(1)};
                [goodsCollectEntities addObject:dic];
            }
            [weakSelf removeCollectionWithGoodsCollectEntities:goodsCollectEntities];
        };
    }
    return _bottomView;
    
}

- (UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame = CGRectMake(0, 0, 40, 44);
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_editBtn setImage:IMAGE_NAME(@"") forState:UIControlStateNormal];
        _editBtn.titleLabel.font = kFont(15);
        [_editBtn setTitleColor:UIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _editBtn;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(0, 0, 22, 44);
        [_closeBtn setImage:IMAGE_NAME(@"关闭") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(clossAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}


- (NSMutableArray *)selectedGoodsMuarr{
    if (!_selectedGoodsMuarr) {
        _selectedGoodsMuarr = [[NSMutableArray alloc]init];
    }
    return _selectedGoodsMuarr;
}

@end
