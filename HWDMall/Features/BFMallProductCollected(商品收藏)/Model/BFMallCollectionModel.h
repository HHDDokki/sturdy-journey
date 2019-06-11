//
//  BFMallCollectionModel.h
//  HWDMall
//
//  Created by HandC1 on 2019/6/5.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol BFMallCollectionDetailModel
@end

@interface BFMallCollectionModel : JSONModel

@property (nonatomic, strong) NSMutableArray<BFMallCollectionDetailModel>*result;


@end

@interface BFMallCollectionDetailModel : JSONModel

@property (nonatomic, strong) NSString *articleContent;
@property (nonatomic, assign) NSInteger articleId;
@property (nonatomic, strong) NSString *articleTitle;
@property (nonatomic, strong) NSString *catNames;
@property (nonatomic, strong) NSString *commentList;
@property (nonatomic, strong) NSString *commentNum;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *tagIds;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic) BOOL isSelectedStatus;

@end

NS_ASSUME_NONNULL_END
