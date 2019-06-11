//
//  BFMallShowBigimageController.m
//  BFMan
//
//  Created by HandC1 on 2019/5/24.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallShowBigimageController.h"
#import "BFMallCustomScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BFMallShowBigimageController ()<UIScrollViewDelegate,CustomScrollViewDelegate> {
    UIPageControl *pageControl;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger selectImageIndex;
@end

@implementation BFMallShowBigimageController

- (instancetype)initWithArray:(NSArray *)array
                selectedIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray arrayWithArray:array];
        self.selectImageIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UIView *backview = [[UIView alloc] init];
    backview.frame = CGRectMake(-10, -10, SCREEN_W+20, SCREEN_H+20);
    [self.view addSubview:backview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
    [backview addGestureRecognizer:tap];
    
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = CGRectMake(0, (SCREEN_H-SCREEN_W)/2, SCREEN_W,SCREEN_W);
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.userInteractionEnabled = YES;
    scroll.bounces = NO;
    [self.view addSubview:scroll];
    
    [scroll setContentOffset:
     CGPointMake(scroll.width*self.selectImageIndex, 0)];
    [scroll setContentSize:
     CGSizeMake(scroll.width*self.dataArray.count,scroll.height)];
    [scroll scrollRectToVisible:
     CGRectMake(scroll.width*self.selectImageIndex,
                0,scroll.width,scroll.height) animated:NO];
    
    if (self.dataArray.count > 0) {
        BFMallCustomScrollView* zoomScrollView = (BFMallCustomScrollView*)[self.view viewWithTag:1121156];
        zoomScrollView.mNumImage = self.selectImageIndex;
        if (!zoomScrollView) {
            for (int i = 0; i < self.dataArray.count; i++) {
                zoomScrollView = [[BFMallCustomScrollView alloc]init];
                CGRect frame = scroll.frame;
                frame.origin.x = frame.size.width * i;
                frame.origin.y = 0;
                zoomScrollView.frame = frame;
                zoomScrollView.photoDelegate = self;
                zoomScrollView.tag = 1121156;
                zoomScrollView.imageArray = self.dataArray;
                [zoomScrollView.imageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[i]]];
                [scroll addSubview:zoomScrollView];
            }
        }
    }
    
    pageControl = [[UIPageControl alloc]initWithFrame:
                   CGRectMake(0, scroll.bottom+10, self.view.width, 10)];
    pageControl.numberOfPages = self.dataArray.count;
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.currentPage = self.selectImageIndex;
    pageControl.enabled=YES;
    [self.view addSubview:pageControl];
}

- (void)closeAction{
    [self performSelector:@selector(closeBannerAction)];
}

- (void)closeBannerAction {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.frame = CGRectMake(0, (SCREEN_H-SCREEN_W)/2, SCREEN_W,SCREEN_W);
    CGFloat pageWidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    pageControl.currentPage=currentPage;
}

@end
