//
//  GoodsTypeView.m
//  HWDMall
//
//  Created by sk on 2018/11/5.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import "GoodsTypeView.h"

#import "GoodsTypeBtnsView.h"
#import "ORSKUDataFilter.h"
#import "GoodsTypeBtnsCell.h"
//地址
#import "BRAddressPickerView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GoodsTypeView()<UICollectionViewDataSource, UICollectionViewDelegate,ORSKUDataFilterDataSource>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *conformBtn;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *goodsimgV;
@property (nonatomic, strong) UILabel *currentPLab;
@property (nonatomic, strong) UILabel *vipPLab;
@property (nonatomic, strong) UILabel *specsDescLab;

@property (nonatomic,assign)CGFloat listH;//列表高度

//sku
@property (nonatomic, strong) ORSKUDataFilter *filter;

@property (nonatomic, strong) NSMutableArray <NSIndexPath *>*selectedIndexPaths;
@property (strong, nonatomic) UICollectionView *collectionView;

//增加商品数量 地址
@property(nonatomic,assign)NSInteger goodsNum;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *area;
@property(nonatomic,copy)NSString *areaCode;

//默认地址
@property(nonatomic,strong)NSMutableDictionary *userAddressDic;

//sku id
@property (nonatomic, assign) int skuId;
@property(nonatomic,assign)NSInteger stock;
//价格
@property (nonatomic, copy) NSString *minP;
@property (nonatomic, copy) NSString *maxP;
//图片
@property (nonatomic, copy) NSString *imgStr;
@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, assign) CGFloat currentPrice;
@property (nonatomic, assign) NSInteger currentSection;
@property (nonatomic, strong) NSMutableDictionary *descStrDic;

@end
@implementation GoodsTypeView


- (instancetype) initWithHeight:(CGFloat)height SkuSource:(NSMutableArray *)skuSource SkuList:(NSMutableArray *)skuList MaxPrice:(NSString *)maxPrice MinPrice:(NSString *)minPrice imgStr:(NSString *)imgStr Type:(NSInteger)type CurrentPrice:(CGFloat)currentPrice{
    
    self = [super init];
    if (self) {
        self.currentSection = 0;
        self.descStrDic = [NSMutableDictionary dictionary];
        self.maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.maskView.alpha = 0.f;
        [self addSubview:self.maskView];
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H - height, SCREEN_W, height)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
        UITapGestureRecognizer *tap_bg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAnimating)];
        [self.maskView addGestureRecognizer:tap_bg];
        
        self.frame = [UIScreen mainScreen].bounds;
        self.minP = minPrice;
        self.maxP = maxPrice;
        self.imgStr = imgStr;
        //        self.dataSource = skuSource;
        self.type = type;
        self.currentPrice = currentPrice;
        
        self.userType = [GVUserDefaults standardUserDefaults].userType;
        if (skuSource.count == 1 && [skuSource[0][@"value"] count] == 1) {
            [self dataSource];
            self.skuId = [skuList[0][@"idd"] intValue];
        }else{
            self.dataSource = skuSource;
        }
        
        for (int i = 0; i < skuList.count; i++) {
            if ([skuList[i][@"stock"] intValue] == 0 ) {
                
            }else{
                [self.skuData addObject:skuList[i]];
            }
        }
        [self createMainView];
        [self initContrains];
    }
    return self;
}

- (void)createMainView {
    
    [self.contentView addSubview:self.closeBtn];
//    [self.contentView addSubview:self.goodsimgV];
    [self.contentView addSubview:self.currentPLab];
    [self.contentView addSubview:self.vipPLab];
    [self.contentView addSubview:self.specsDescLab];
    [self.contentView addSubview:self.collectionView];

    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(144);
        make.height.equalTo(40);
        
    }];
    shadowView.layer.shadowColor = [UIColor hexColor:@"#3A6698"].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0, 4);
    shadowView.layer.shadowOpacity = 0.4f;
    shadowView.layer.shadowRadius = 3.0;
    shadowView.layer.cornerRadius = 5.0;
    shadowView.clipsToBounds = NO;
    
    self.conformBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 144, 40)];
    self.conformBtn.backgroundColor = [UIColor hexColor:@"#2D3640"];
    [UIBezierPath bezierRoundView:self.conformBtn withRadii:CGSizeMake(20, 20)];
    [self.conformBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.conformBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.conformBtn addTarget:self action:@selector(goFuKuan:) forControlEvents:UIControlEventTouchUpInside];
    [shadowView addSubview:self.conformBtn];
    
    [self addGoodsImg];
    [self initSku];
    
}

#pragma -mark 加载商品图像和价格
-(void)addGoodsImg{
    
    [self.goodsimgV sd_setImageWithURL:[NSURL URLWithString:self.imgStr] placeholderImage:[UIImage imageNamed:@"taken_image_details_product"]];
    self.goodsNum = 1;
    self.goodsimgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    [self.goodsimgV addGestureRecognizer:tapGR];
    
}

- (void)showBigImage:(UITapGestureRecognizer*)sender {
    
    if (self.bigImgBlock) {
        self.bigImgBlock();
    }
    
}

#pragma -mark 添加多按钮view
-(void)addGoodsTypeBtnsView{
    
    
}

-(void)addGoodsTypeBtnsViewSec{
    
    
}

- (void)initContrains{
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        
    }];
    
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:borderView];
    borderView.layer.borderColor = [UIColor hexColor:@"#E9E9E9"].CGColor;
    borderView.layer.borderWidth = 1;
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.width.height.equalTo(86);
        make.left.equalTo(14);
    }];
    
    [borderView addSubview:self.goodsimgV];
    [_goodsimgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(2);
        make.left.mas_equalTo(2);
        make.height.width.mas_equalTo(83);
    }];
    
    [_currentPLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(27);
        make.left.equalTo(borderView.mas_right).offset(10);
        make.width.equalTo(180);
        make.height.equalTo(11);
        
    }];
    
    UIImageView *vipImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [vipImg setImage:IMAGE_NAME(@"man")];
    [self.contentView addSubview:vipImg];
    [vipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(borderView.mas_right).offset(10);
        make.top.equalTo(self.currentPLab.mas_bottom).offset(7);
        make.width.equalTo(37);
        make.height.equalTo(17);
    }];

    [_vipPLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.currentPLab.mas_bottom).offset(8);
        make.left.equalTo(vipImg.mas_right).offset(4);
        make.width.equalTo(200);
        make.height.equalTo(14);
    }];
    
    [_specsDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vipImg.mas_bottom).offset(28);
        make.left.equalTo(borderView.mas_right).offset(10);
        make.width.equalTo(200);
        make.height.equalTo(11);
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor hexColor:@"#EBEBEB"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(borderView.mas_bottom).offset(14);
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.height.equalTo(1);
        
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(14);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    
}


-(void)initSku{
    
    _selectedIndexPaths = [NSMutableArray array];
    _filter = [[ORSKUDataFilter alloc] initWithDataSource:self];
    [self.collectionView reloadData];
    
}

#pragma mark -- collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataSource.count  + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == _dataSource.count) {
        return 1;
    }else{
        return [_dataSource[section][@"value"] count];
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == _dataSource.count ) {
        
        static NSString *item_identify = @"GoodsTypeSpecBottomCell";
        self.bottomCell = [collectionView dequeueReusableCellWithReuseIdentifier:item_identify forIndexPath:indexPath];
        
        for (UIView *subview in self.bottomCell.contentView.subviews) {
            if (subview) {
                [subview removeFromSuperview];
            }
        }
        self.bottomCell.mj_x = 0;
        self.bottomCell.width = SCREEN_W;
        [self.bottomCell bindType:self.type withAddress:self.address];

        WK(weakSelf)
        self.bottomCell.getGoodsNumBlock = ^(int goodsNum) {
            weakSelf.goodsNum = goodsNum;
        };
        
        return self.bottomCell;
        
    }else{
        
        GoodsTypeBtnsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PropertyCell" forIndexPath:indexPath];
        NSArray *data = _dataSource[indexPath.section][@"value"];
        //    cell.propertyL.text = data[indexPath.row];
        cell.propertyL.text = data[indexPath.row];
        if ([_filter.availableIndexPathsSet containsObject:indexPath]) {
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"EBEBEB"];
            cell.propertyL.textColor = [UIColor colorWithHexString:@"2D3640"];
            cell.propertyL.layer.borderColor = [UIColor colorWithHexString:@"EBEBEB"].CGColor;
        }else {
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"F1F1F0"];
            cell.propertyL.textColor = [UIColor colorWithHexString:@"C5C8CC"];
            cell.propertyL.layer.borderColor = [UIColor colorWithHexString:@"F1F1F0"].CGColor;
        }
        
        if ([_filter.selectedIndexPaths containsObject:indexPath]) {
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"F7E9DE"];
            cell.propertyL.textColor = [UIColor colorWithHexString:@"FF7200"];
            cell.propertyL.layer.borderColor = [UIColor colorWithHexString:@"FF7200"].CGColor;
            cell.propertyL.layer.borderWidth = 10;
        }
        
        cell.propertyL.layer.cornerRadius = 5;
        //        cell.propertyL.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        cell.propertyL.layer.borderWidth = 1;
        
        return cell;
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 头
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerIdf" forIndexPath:indexPath];
        if (indexPath.section != _dataSource.count) {
            [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 100, 20)];
            [view addSubview:lab];
            lab.backgroundColor = UIColor.whiteColor;
            lab.text = _dataSource[indexPath.section][@"name"];
            lab.font = [UIFont systemFontOfSize:14];
            lab.textColor = [UIColor colorWithHexString:@"333333"];
        }else{
            view.frame = CGRectMake(0, 0, kScreenWidth, 0);
        }
        
        //        view.headernameL.text = _dataSource[indexPath.section][@"name"];
        
        return view;
        
    }else {
        
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerIdf" forIndexPath:indexPath];
        
        return view;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == _dataSource.count) {
        
    }else{
        
        [_filter didSelectedPropertyWithIndexPath:indexPath];
        [collectionView reloadData];
        NSIndexPath *defaultIndexPath = [NSIndexPath indexPathForRow:0 inSection:_dataSource.count];
        GoodsTypeBtnsCell *cell = (GoodsTypeBtnsCell *)[collectionView cellForItemAtIndexPath:defaultIndexPath];
        NSString *kay = NSStringFormat(@"%ld",(long)indexPath.section);
        NSString *value = _dataSource[indexPath.section][@"value"][indexPath.row];
        if (_currentSection == indexPath.section) {
            if (![_filter.selectedIndexPaths containsObject:indexPath]) {
                if ([self.descStrDic.allKeys containsObject:kay]) {
                    [self.descStrDic removeObjectForKey:kay];
                }
                self.specsDescLab.text = @"已选 ：";
            }else {
                if (self.descStrDic.allKeys.count != 0) {
                    [self.descStrDic setObject:value forKey:kay];
                    self.specsDescLab.text = NSStringFormat(@"已选 ：%@",value);
                    for (NSString *subKay in self.descStrDic.allKeys) {
                        if ([subKay isEqualToString:kay]) {
                            break;
                        }
                        self.specsDescLab.text = NSStringFormat(@"%@ %@",self.specsDescLab.text, self.descStrDic[subKay]);
                    }
                }else {
                    [self.descStrDic setObject:value forKey:kay];
                    self.specsDescLab.text = NSStringFormat(@"已选 ：%@",value);
                }
                
            }
        }else {
            NSString *k1 = NSStringFormat(@"%ld",(long)0);
            if (![_filter.selectedIndexPaths containsObject:indexPath]) {
                if ([self.descStrDic.allKeys containsObject:kay]) {
                    [self.descStrDic removeObjectForKey:kay];
                };
                if (self.descStrDic.allKeys.count != 0 && self.descStrDic[k1] != nil) {
                    self.specsDescLab.text = NSStringFormat(@"已选 ：%@",self.descStrDic[k1]);
                    for (int i = 1; i < self.descStrDic.allKeys.count; i++) {
                        NSString *subk = NSStringFormat(@"%ld",(long)i);
                        self.specsDescLab.text = NSStringFormat(@"%@ %@",self.specsDescLab.text, self.descStrDic[subk]);
                    }
                }
            }else {
                if (self.descStrDic.allKeys.count != 0 && self.descStrDic[k1] != nil) {
                    [self.descStrDic setObject:value forKey:kay];
                    self.specsDescLab.text = NSStringFormat(@"已选 ：%@",self.descStrDic[k1]);
                    for (int i = 1; i < self.descStrDic.allKeys.count; i++) {
                        NSString *subk = NSStringFormat(@"%ld",(long)i);
                        self.specsDescLab.text = NSStringFormat(@"%@ %@",self.specsDescLab.text, self.descStrDic[subk]);
                    }
                }else {
                    [self.descStrDic setObject:value forKey:kay];
                    self.specsDescLab.text = NSStringFormat(@"已选 ：%@", value);

                }
            }
            
        }
        [self action_complete:cell];
    }
    
}

- (void)action_complete:(GoodsTypeBtnsCell *)cell{
    
    NSDictionary *dic = _filter.currentResult;
    if (dic == nil) {
        NSLog(@"请选择完整 属性");
        return;
    }
    self.skuId = [dic[@"idd"] intValue];
    [self.goodsimgV sd_setImageWithURL:[NSURL URLWithString:dic[@"originalImg"]] placeholderImage:[UIImage imageNamed:@"taken_image_details_product"]];
    self.currentPLab.text = NSStringFormat(@"商品价 : ￥%.2f",[dic[@"singlePrice"] floatValue]);
    self.vipPLab.text = NSStringFormat(@"会员价: ￥%.2f",[dic[@"maxPrice"] floatValue]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _dataSource.count) {
        return CGSizeMake(kScreenWidth - 32, (115 + 49));
    }else{
        NSArray *data = _dataSource[indexPath.section][@"value"];
        //    cell.propertyL.text = data[indexPath.row];
        NSString *text = data[indexPath.row];
        CGFloat w = [self sizeWithFont:text].size.width + 16;
        if (w < 66) {
            w = 66;
        }
        return CGSizeMake(w, 31);
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == _dataSource.count) {
        return CGSizeMake(kScreenWidth, 1);
    }else{
        return CGSizeMake(kScreenWidth, 20);
    }
    
}

-(CGRect)sizeWithFont:(NSString *)text{
    
    CGRect textSize = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 40) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.0],NSFontAttributeName, nil] context:nil];
    return textSize;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 15, 10, 10);
    
}

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
}

#pragma mark -- ORSKUDataFilterDataSource

- (NSInteger)numberOfSectionsForPropertiesInFilter:(ORSKUDataFilter *)filter {
    return _dataSource.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter propertiesInSection:(NSInteger)section {
    return _dataSource[section][@"idd"];
}

- (NSInteger)numberOfConditionsInFilter:(ORSKUDataFilter *)filter {
    return _skuData.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter conditionForRow:(NSInteger)row {
    NSString *condition = _skuData[row][@"contition"];
    return [condition componentsSeparatedByString:@","];
}

- (id)filter:(ORSKUDataFilter *)filter resultOfConditionForRow:(NSInteger)row {
    NSDictionary *dic = _skuData[row];
    return dic;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
        layout.minimumInteritemSpacing = 10;// 垂直方向的间距
        //         layout.minimumLineSpacing = 500; // 水平方向的间距
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[GoodsTypeBtnsCell class] forCellWithReuseIdentifier:@"PropertyCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerIdf"];
        [_collectionView registerClass:[GoodsTypeSpecBottomCell class] forCellWithReuseIdentifier:@"GoodsTypeSpecBottomCell"];
        
    }
    
    return _collectionView;
}

#pragma mark - click

//去付款
-(void)goFuKuan:(UIButton *)fuKuanBtn{
    
    if (self.skuId == 0) {
        [kWindow makeToast:@"请选择商品规格"];
        return;
    }
    if (self.goodsNum == 0) {
        [kWindow makeToast:@"商品数量不能为0"];
        return;
    }
    [self hiddenAnimating];
    if (self.fuKuanBlock) {
        self.fuKuanBlock(self.goodsNum,self.address,self.skuId);
    }
}

-(void)closeView{
    
    [self hiddenAnimating];
    
}

#pragma mark - buttonResponse
- (void)showAnimating{
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.maskView.alpha = 1.f;
    } completion:nil];
    
}

- (void)hiddenAnimating{
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.frame.size.height);
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
    
}

#pragma mark - lazy load
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]init];
        [_closeBtn setImage:[UIImage imageNamed:@"关闭"] forState:0];
        [_closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _closeBtn;
}

- (UILabel *)currentPLab{
    if (!_currentPLab) {
        _currentPLab = [[UILabel alloc]init];
        _currentPLab.text = NSStringFormat(@"商品价 : %@", self.maxP);
        _currentPLab.textColor = [UIColor colorWithHexString:@"#2D3640"];
        _currentPLab.font = kBoldFont(12);
        
    }
    return _currentPLab;
}
- (UILabel *)vipPLab{
    if (!_vipPLab) {
        _vipPLab = [[UILabel alloc]init];
        _vipPLab.text = NSStringFormat(@"会员价: %@", self.minP);
        _vipPLab.font = kBoldFont(14);
        _vipPLab.textColor = [UIColor hexColor:@"#FF7200"];
        
    }
    return _vipPLab;
}
- (UIImageView *)goodsimgV{
    
    if (!_goodsimgV) {
        _goodsimgV = [[UIImageView alloc]init];
        _goodsimgV.image = [UIImage imageNamed:@"WechatIMG123.jpeg"];
    }
    return _goodsimgV;
    
}
- (UILabel *)specsDescLab {
    if (!_specsDescLab) {
        _specsDescLab = [[UILabel alloc] init];
        _specsDescLab.textColor = [UIColor hexColor:@"#2D3640"];
        _specsDescLab.font = kFont(10);
        
    }
    return _specsDescLab;
}
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}
- (NSMutableArray *)skuData{
    if (!_skuData) {
        _skuData = [NSMutableArray array];
    }
    return _skuData;
}

@end
