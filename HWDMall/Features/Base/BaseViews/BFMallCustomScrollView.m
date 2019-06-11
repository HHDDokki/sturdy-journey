//
//  BFMallCustomScrollView.m
//  BFMan
//
//  Created by HandC1 on 2019/5/24.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallCustomScrollView.h"

@interface BFMallCustomScrollView ()

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation BFMallCustomScrollView
@synthesize imageView;
@synthesize photoDelegate;
@synthesize mNumImage;
@synthesize imageArray;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_W);
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.userInteractionEnabled = YES;
        self.maximumZoomScale = 2.0;
        self.minimumZoomScale = 1.0;
        self.decelerationRate = .85;
        [self initImageView];
    }
    return self;
}

- (void)initImageView {
    imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 0, SCREEN_W*2. , SCREEN_W*2. );
    imageView.userInteractionEnabled = YES;
    
    [self addSubview:imageView];
    _isZoomed = NO;
    
    //单击事件   点击退出大图
    UITapGestureRecognizer* tapOne = [[UITapGestureRecognizer alloc]init];
    tapOne.numberOfTapsRequired = 1;    //点击次数
    tapOne.numberOfTouchesRequired = 1; //点击手指数
    [tapOne addTarget:self action:@selector(tapOneAct:)];
    [imageView addGestureRecognizer:tapOne];
    
    
    // Add gesture,double tap zoom imageView.
    UITapGestureRecognizer *doubleTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleDoubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [imageView addGestureRecognizer:doubleTapGesture];
    
    //当双击事件生效时,单击事件自动失效
    [tapOne requireGestureRecognizerToFail:doubleTapGesture];
    
    float minimumScale = self.frame.size.width / imageView.frame.size.width;
    [self setMinimumZoomScale:minimumScale];
    [self setZoomScale:minimumScale];
}

- (void)tapOneAct:(UITapGestureRecognizer*)tapOne {
    if (photoDelegate && [photoDelegate respondsToSelector:@selector(closeBannerAction)]) {
        [photoDelegate performSelector:@selector(closeBannerAction)];
    }
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {
    if( _isZoomed ) {
        _isZoomed = NO;
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }else {
        _isZoomed = YES;
        float newScale = self.maximumZoomScale;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
        [self zoomToRect:zoomRect animated:YES];
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
                       withView:(UIView *)view atScale:(CGFloat)scale {
    [scrollView setZoomScale:scale animated:NO];
    if( self.zoomScale == self.minimumZoomScale ) _isZoomed = NO;
    else _isZoomed = YES;
}

@end
