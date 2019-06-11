//
//  OrderMoreGoodsCell.m
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderMoreGoodsCell.h"
#import "OrderGoodsCollectionCell.h" //商品照片

static NSString * const collctionCellID = @"COLLECITONCELLID";

@interface  OrderMoreGoodsCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *goodsCollection;

@end

@implementation OrderMoreGoodsCell

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
    _goodsCollection.delegate = self;
    _goodsCollection.dataSource = self;
    _goodsCollection.showsHorizontalScrollIndicator = NO;
    _goodsCollection.collectionViewLayout = layout;
    [_goodsCollection registerNib:[UINib nibWithNibName:NSStringFromClass([OrderGoodsCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:collctionCellID];
}

#pragma mark -- collctiondelegate and datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.picArr.count) {
        return self.picArr.count;
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
    NSString * picStr = [self.picArr objectAtIndex:indexPath.row];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- setter
//- (void)setCellCount:(NSInteger)cellCount{
//    if (_cellCount != cellCount) {
//        _cellCount = cellCount;
//    }
//    [self.goodsCollection reloadData];
//}

- (void)setPicArr:(NSArray *)picArr{
    if (_picArr != picArr) {
        _picArr = picArr;
    }
    [self.goodsCollection reloadData];
}

- (void)tapAction{
    RDLog(@"点击");
    if (self.tapblock) {
        self.tapblock();
    }
}

@end
