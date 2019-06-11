//
//  BFMallCustomScrollView.h
//  BFMan
//
//  Created by HandC1 on 2019/5/24.
//  Copyright © 2019 HYK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomScrollViewDelegate;

@interface BFMallCustomScrollView : UIScrollView <UIScrollViewDelegate> {
    
    UIImageView *imageView;
    NSInteger   mNumImage;
    NSMutableArray *imageArray;
    BOOL _isZoomed;
    
    id<CustomScrollViewDelegate> photoDelegate;
}

@property (nonatomic,readonly)  UIImageView *imageView;
@property (nonatomic,assign)    NSInteger mNumImage;
@property (nonatomic,retain)    NSMutableArray *imageArray;

@property (nonatomic, strong) id<CustomScrollViewDelegate>photoDelegate;

@end

@protocol CustomScrollViewDelegate <NSObject>

@optional
- (void)clickBannerAction:(NSString *)index;
- (void)closeBannerAction;

@end

NS_ASSUME_NONNULL_END
