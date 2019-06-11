//
//  WuliuListCell.m
//  HWDMall
//
//  Created by stewedr on 2018/12/19.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "WuliuListCell.h"
#import "OrderGoodsCollectionCell.h" //商品照片

static NSString * const collctionCellID = @"COLLECITONCELLID";

@interface WuliuListCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *wuliuSingLbl;
@property (weak, nonatomic) IBOutlet UILabel *wuliuMesLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLbl;
@property (weak, nonatomic) IBOutlet UICollectionView *wuliuCollection;
@property (nonatomic,strong) NSArray *myPicArr;
@end

@implementation WuliuListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCollection];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap addTarget:self action:@selector(tapAction)];
    self.contentView.userInteractionEnabled = YES;
    [self.contentView addGestureRecognizer:tap];
}

#pragma mark -- setCollection
- (void)setCollection{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 20;
    self.wuliuCollection.delegate = self;
    self.wuliuCollection.dataSource = self;
    self.wuliuCollection.showsHorizontalScrollIndicator = NO;
    self.wuliuCollection.collectionViewLayout = layout;
    [self.wuliuCollection registerNib:[UINib nibWithNibName:NSStringFromClass([OrderGoodsCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:collctionCellID];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- collctiondelegate and datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.myPicArr.count) {
        return self.myPicArr.count;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OrderGoodsCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collctionCellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([OrderGoodsCollectionCell class])
                                             owner:self
                                           options:nil]lastObject];
    }
    NSString * picStr = [self.myPicArr objectAtIndex:indexPath.row];
    cell.imgeurlStr = picStr;
    return cell;
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70, 64);
}

#pragma mark -- setter

- (void)updateCellWith:(NSString *)statusStr WuliuSign:(NSString *)wuliusignStr WuliuMes:(NSString *)wuliumes PicArr:(NSArray *)picArr GoodsCount:(NSString *)goodscountStr{
    self.statusLbl.text = statusStr;
    self.wuliuSingLbl.text = wuliusignStr;
    self.wuliuMesLbl.text = wuliumes;
    self.myPicArr = picArr;
    self.goodsCountLbl.text = goodscountStr;
    [self.wuliuCollection reloadData];
}

- (void)tapAction{
    RDLog(@"点击");
    if (self.tapblock) {
        self.tapblock();
    }
}

@end
