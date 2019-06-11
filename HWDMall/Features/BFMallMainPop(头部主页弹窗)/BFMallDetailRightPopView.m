//
//  BFMallDetailRightPopView.m
//  BFMan
//
//  Created by HandC1 on 2019/5/22.
//  Copyright © 2019 HYK. All rights reserved.
//

#import "BFMallDetailRightPopView.h"
#import "BFMallVipRightsDescView.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MemberModel.h"

NSString * const  MenuWillAppearNotification = @" MenuWillAppearNotification";
NSString * const  MenuDidAppearNotification = @" MenuDidAppearNotification";
NSString * const  MenuWillDisappearNotification = @" MenuWillDisappearNotification";
NSString * const  MenuDidDisappearNotification = @" MenuDidDisappearNotification";

#define kArrowSize      6.0f   //!< 箭头尺寸
#define kCornerRadius   6.0f    //!< 圆角
#define kTintColor  [UIColor colorWithRed:0.267 green:0.303 blue:0.335 alpha:1]  //!< 主题颜色
#define kSelectedColor [UIColor whiteColor]
#define kTitleFont  [UIFont systemFontOfSize:16.0]

#define kSeparatorInsetLeft     10*SCALE_750
#define kSeparatorInsetRight    10*SCALE_750
#define kSeparatorHeight        0.5
#define kSeparatorColor [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]
#define kMenuViewInsetTop       0
#define kMenuViewInsetBottom    0

const CGFloat kMenuItemMarginY = 12.f;

/// 背景色
static UIColor  *gTintColor;
/// 箭头尺寸
static CGFloat  gArrowSize = kArrowSize;
/// 圆角
CGFloat         gCornerRadius = kCornerRadius;
/// 字体
static UIFont   *gTitleFont;
/// 背景色效果
static  MenuBackgrounColorEffect   gBackgroundColorEffect =  MenuBackgrounColorEffectSolid;
/// 是否显示阴影
static BOOL     gHasShadow = NO;
/// 菜单原始的垂直边距值
//static CGFloat  gMenuItemMarginY = kMenuItemMarginY;

typedef enum {
    
    MenuViewArrowDirectionNone,
    MenuViewArrowDirectionUp,
    MenuViewArrowDirectionDown,
    MenuViewArrowDirectionLeft,
    MenuViewArrowDirectionRight,
    
}  MenuViewArrowDirection;


#pragma mark -  MenuOverlay
@implementation  MenuOverlay

#pragma mark System Methods
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    for (MenuView *subView in self.subviews) {
        CGPoint p = [subView convertPoint:point fromView:self];
        if (!CGRectContainsPoint(subView.bounds, p) && [subView isKindOfClass:[MenuView class]]) {
            [subView performSelector:@selector(dismissMenu:) withObject:@(YES)];
        }
    }
    return view;
}

@end

@interface BFMallDetailRightPopView ()

+ (instancetype)sharedMenu;

/// 视图当前是否显示
@property(nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) MemberModel *model;
/// 重置属性
+ (void)reset;

@end


#pragma mark -  MenuView

@interface MenuView ()

@property (nonatomic, strong) MemberModel *model;

@end

@implementation MenuView {
    MenuViewArrowDirection _arrowDirection;
    CGFloat _arrowPosition;
    UIView *_contentView;
    MenuSelectedItem _selectedItem;
}

#pragma mark System Methods
- (id)init {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
        self.alpha = 0;
        
        if ([BFMallDetailRightPopView hasShadow]) {
            self.layer.opacity = 0.8;
            self.layer.shadowOpacity = 0.5;
            self.layer.shadowColor = [BFMallDetailRightPopView tintColor].CGColor;
            self.layer.shadowOffset = CGSizeMake(2, 2);
            self.layer.shadowRadius = 2;
        }
    }
    return self;
}

- (void)setupFrameInView:(UIView *)view fromRect:(CGRect)fromRect {
    
    const CGSize contentSize = _contentView.frame.size;
    
    const CGFloat outerWidth = view.bounds.size.width;
    const CGFloat outerHeight = view.bounds.size.height;
    
    const CGFloat rectX0 = fromRect.origin.x;
    const CGFloat rectX1 = fromRect.origin.x + fromRect.size.width;
    const CGFloat rectXM = fromRect.origin.x + fromRect.size.width * 0.5f;
    const CGFloat rectY0 = fromRect.origin.y;
    const CGFloat rectY1 = fromRect.origin.y + fromRect.size.height;
    const CGFloat rectYM = fromRect.origin.y + fromRect.size.height * 0.5f;;
    
    const CGFloat widthPlusArrow = contentSize.width + [BFMallDetailRightPopView arrowSize];
    const CGFloat heightPlusArrow = contentSize.height + [BFMallDetailRightPopView arrowSize];
    const CGFloat widthHalf = contentSize.width * 0.5f;
    const CGFloat heightHalf = contentSize.height * 0.5f;
    
    const CGFloat kMargin = 12.f;
    
    if (heightPlusArrow < (outerHeight - rectY1)) {
        
        _arrowDirection =  MenuViewArrowDirectionUp;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY1 + 5
        };
        
        if (point.x < kMargin)
            point.x = kMargin;
        
        if ((point.x + contentSize.width + kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - kMargin;
        
        if (point.x < 0) {
            point.x = 0;
        }
        _arrowPosition = rectXM - point.x;
        _contentView.frame = (CGRect){0, [BFMallDetailRightPopView arrowSize], contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width,
            contentSize.height + [BFMallDetailRightPopView arrowSize]
        };
        
    } else if (heightPlusArrow < rectY0) {
        
        _arrowDirection =  MenuViewArrowDirectionDown;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY0 - heightPlusArrow
        };
        
        if (point.x < kMargin)
            point.x = kMargin;
        
        if ((point.x + contentSize.width + kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - kMargin;
        
        _arrowPosition = rectXM - point.x;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width,
            contentSize.height + [BFMallDetailRightPopView arrowSize]
        };
        
    } else if (widthPlusArrow < (outerWidth - rectX1)) {
        
        _arrowDirection =  MenuViewArrowDirectionLeft;
        CGPoint point = (CGPoint){
            rectX1,
            rectYM - heightHalf
        };
        
        if (point.y < kMargin)
            point.y = kMargin;
        
        if ((point.y + contentSize.height + kMargin) > outerHeight)
            point.y = outerHeight - contentSize.height - kMargin;
        
        _arrowPosition = rectYM - point.y;
        _contentView.frame = (CGRect){[BFMallDetailRightPopView arrowSize], 0, contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width + [BFMallDetailRightPopView arrowSize],
            contentSize.height
        };
        
    } else if (widthPlusArrow < rectX0) {
        
        _arrowDirection =  MenuViewArrowDirectionRight;
        CGPoint point = (CGPoint){
            rectX0 - widthPlusArrow,
            rectYM - heightHalf
        };
        
        if (point.y < kMargin)
            point.y = kMargin;
        
        if ((point.y + contentSize.height + 5) > outerHeight)
            point.y = outerHeight - contentSize.height - kMargin;
        
        _arrowPosition = rectYM - point.y;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width  + [BFMallDetailRightPopView arrowSize],
            contentSize.height
        };
        
    } else {
        
        _arrowDirection =  MenuViewArrowDirectionNone;
        
        self.frame = (CGRect) {
            
            (outerWidth - contentSize.width)   * 0.5f,
            (outerHeight - contentSize.height) * 0.5f,
            contentSize,
        };
    }
}

- (void)showMenuInView:(UIView *)view fromRect:(CGRect)rect selected:(MenuSelectedItem)selectedItem{
    
    _selectedItem = selectedItem;
    _contentView = [self mkContentView];
    [self addSubview:_contentView];
    [self setupFrameInView:view fromRect:rect];
    
    self.overlay = [[MenuOverlay alloc] initWithFrame:view.bounds];
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, self.mj_y+kArrowSize, self.width, SCREEN_H-kArrowSize)];
    shadowView.alpha = 0.5f;
    shadowView.backgroundColor = [UIColor blackColor];
    
//    UITapGestureRecognizer *gestureRecognizer;
//    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
//    [shadowView addGestureRecognizer:gestureRecognizer];
//    shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
//    shadowView.layer.shadowOffset = CGSizeMake(0, 0);
//    shadowView.layer.shadowOpacity = 0.6f;
//    shadowView.layer.shadowRadius = 3.0;
//    shadowView.layer.cornerRadius = gCornerRadius;
//    shadowView.clipsToBounds = NO;
    [self.overlay addSubview:shadowView];
    [self.overlay addSubview:self];
    [view addSubview:self.overlay];
    
//    _contentView.hidden = YES;
    const CGRect toFrame = self.frame;
    const CGRect StoFrame = shadowView.frame;
    self.frame = (CGRect){self.arrowPoint, 1, 1};
    shadowView.frame = self.frame;
    
    [[NSNotificationCenter defaultCenter] postNotificationName: MenuWillAppearNotification object:nil];
    
    [UIView animateWithDuration:0.2 animations:^(void) {
        
        self.alpha = 1.0f;
        self.frame = toFrame;
        shadowView.frame = StoFrame;
        
    } completion:^(BOOL completed) {
        self->_contentView.hidden = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName: MenuDidAppearNotification object:nil];
    }];
}

- (void)singleTap:(UITapGestureRecognizer *)recognizer {

//    [self dismissMenu:YES];
}

- (UIView *)mkContentView {
    
    
    CGFloat contentHeight = 0.f;
    if ([GVUserDefaults standardUserDefaults].isVip) {
        contentHeight = 257;
    }else {
        contentHeight = 369;
    }
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, contentHeight)];
    contentView.autoresizingMask = UIViewAutoresizingNone;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.opaque = NO;
//    contentView.layer.cornerRadius = gCornerRadius;
//    [contentView setClipsToBounds:YES];
    
    [contentView addSubview:self.goShoppingCartBtn];
    [contentView addSubview:self.goOrderDetailBtn];
    [contentView addSubview:self.goCollectionBtn];
    [contentView addSubview:self.goAddressBtn];
    
    CGFloat width = SCREEN_W/4.0;
    [self.goShoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mj_x);
        make.width.equalTo(width);
        make.height.equalTo(107);
        make.top.equalTo(0);
    }];
    self.goShoppingCartBtn = [self setBtn:self.goShoppingCartBtn];
    [self.goShoppingCartBtn addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.goOrderDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mj_x + width);
        make.width.equalTo(width);
        make.height.equalTo(107);
        make.top.equalTo(0);
    }];
    self.goOrderDetailBtn = [self setBtn:self.goOrderDetailBtn];
    [self.goOrderDetailBtn addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.goCollectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mj_x + width*2);
        make.width.equalTo(width);
        make.height.equalTo(107);
        make.top.equalTo(0);
    }];
    self.goCollectionBtn = [self setBtn:self.goCollectionBtn];
    [self.goCollectionBtn addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.goAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mj_x + width*3);
        make.width.equalTo(width);
        make.height.equalTo(107);
        make.top.equalTo(0);
    }];
    self.goAddressBtn = [self setBtn:self.goAddressBtn];
    [self.goAddressBtn addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 107, SCREEN_W, PX(1))];
    lineView.backgroundColor = [UIColor hexColor:@"#EEF1F3"];
    [contentView addSubview:lineView];
    
    /* --------------------------------------------------------- */
    
    [contentView addSubview:self.usrIcon];
    [contentView addSubview:self.usrNameLab];
    [contentView addSubview:self.usrDescLab];
    
    self.usrIcon.frame = CGRectMake(15, lineView.bottom + 20, 60, 60);

    [UIBezierPath bezierCutCircleForView:_usrIcon];
    [self.usrIcon sd_setImageWithURL:[NSURL URLWithString:[GVUserDefaults standardUserDefaults].headImg] placeholderImage:IMAGE_NAME(@"非会员默认头像")];

    [self.usrNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(lineView).offset(32);
        make.left.equalTo(self.usrIcon.mas_right).offset(9);
        make.width.equalTo(200);
        make.height.equalTo(17);
        
    }];
    
    [self.usrDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.usrNameLab.mas_bottom).offset(9);
        make.left.equalTo(self.usrIcon.mas_right).offset(9);
        make.width.equalTo(200);
        make.height.equalTo(13);
        
    }];
    
    if ([GVUserDefaults standardUserDefaults].isVip) {
        
        NSString *time = [NSString getYYYYMMDD:NSStringFormat(@"%ld",self.model.time)];
        self.usrDescLab.text = [NSString stringWithFormat:@"%@到期",time];
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.font = kBoldFont(17);
        descLabel.textColor = [UIColor hexColor:@"#C39B68"];
        [contentView addSubview:descLabel];
        
        NSString *a = NSStringFormat(@"截止到现在，会员已为您节省¥%.2f元", self.model.saveMoney);
        NSRange priceRange = [a rangeOfString:NSStringFormat(@"¥%.2f元", self.model.saveMoney)];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:a attributes:@{NSForegroundColorAttributeName:[UIColor hexColor:@"#C39B68"]}];
        [attributedString addAttribute:NSFontAttributeName value:kBoldFont(14) range:NSMakeRange(0, priceRange.location)];
        [attributedString addAttribute:NSFontAttributeName value:kBoldFont(17) range:NSMakeRange(priceRange.location, priceRange.length-1)];
        descLabel.attributedText = attributedString;
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(contentView.mas_bottom).offset(-25);
            make.left.equalTo(0);
            make.width.equalTo(contentView.mas_width);
            make.height.equalTo(18);
        }];
        
        UIView *shadowView = [[UIView alloc] init];
        shadowView.layer.shadowColor = [UIColor hexColor:@"#FF9600"].CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(0, 4);
        shadowView.layer.shadowOpacity = 0.6f;
        shadowView.layer.shadowRadius = 3.0;
        shadowView.layer.cornerRadius = 5.0;
        shadowView.clipsToBounds = NO;
        [contentView addSubview:shadowView];
        
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(80);
            make.height.equalTo(32);
            make.right.equalTo(contentView.mas_right).offset(-15);
            make.centerY.equalTo(self.usrIcon.mas_centerY);
        }];
        
        [shadowView addSubview:self.renewBtn];
        self.renewBtn.frame = CGRectMake(0, 0, 80, 32);
        [UIBezierPath bezierRoundView:self.renewBtn withRadii:CGSizeMake(16, 16)];
        self.renewBtn.backgroundColor = [UIColor hexColor:@"#FF7200"];
        
    }else {
        BFMallVipRightsDescView *vipRightsDescView = [[BFMallVipRightsDescView alloc] init];
        [contentView addSubview:vipRightsDescView];
        
        [vipRightsDescView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(self.usrIcon.mas_bottom).offset(20);
            make.width.equalTo(contentView.mas_width);
            make.height.equalTo(58);
        }];
        
        UIView *shadowView = [[UIView alloc] init];
        shadowView.layer.shadowColor = [UIColor hexColor:@"#FF9600"].CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(0, 4);
        shadowView.layer.shadowOpacity = 0.6f;
        shadowView.layer.shadowRadius = 3.0;
        shadowView.layer.cornerRadius = 5.0;
        shadowView.clipsToBounds = NO;
        [contentView addSubview:shadowView];
        
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(contentView.bottom).offset(-20);
            make.width.equalTo(229);
            make.height.equalTo(26.5);
            make.centerX.equalTo(contentView.mas_centerX);
        }];
        
        self.buyVipServiceBtn.frame = CGRectMake(0, 0, 229, 31);
        [UIBezierPath bezierRoundView:self.buyVipServiceBtn withRadii:CGSizeMake(20, 20)];
        self.buyVipServiceBtn.backgroundColor = [UIColor hexColor:@"#FF9600"];
        NSMutableDictionary *dic = _model.priceList[0];
        NSNumber *vipp = [dic valueForKey:@"vipPrice"];
        [self.buyVipServiceBtn setTitle:NSStringFormat(@"立即购买%.2f/年",[vipp floatValue]) forState:UIControlStateNormal];
        [shadowView addSubview:self.buyVipServiceBtn];
        
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.font = kBoldFont(17);
        descLabel.textColor = [UIColor hexColor:@"#C39B68"];
        descLabel.text = @"每位会员平均可省￥2521元";
        [contentView addSubview:descLabel];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.buyVipServiceBtn.mas_top);
            make.left.equalTo(0);
            make.width.equalTo(contentView.mas_width);
            make.height.equalTo(53);
        }];
    }
    
    [contentView addSubview:self.vipDescLab];
    
    return contentView;
    
}

- (void)dismissMenu:(BOOL)animated {
    if (self.superview) {
        [[NSNotificationCenter defaultCenter] postNotificationName: MenuWillDisappearNotification object:nil];
        
        __weak typeof(self) weakSelf = self;
        void (^removeView)(void) = ^(void) {
            if ([weakSelf.superview isKindOfClass:[ MenuOverlay class]])
                [weakSelf.superview removeFromSuperview];
            [weakSelf removeFromSuperview];
            
            [[NSNotificationCenter defaultCenter] postNotificationName: MenuDidDisappearNotification object:nil];
        };
        
        if (animated) {
            _contentView.hidden = YES;
            const CGRect toFrame = (CGRect){self.arrowPoint, 1, 1};
            [UIView animateWithDuration:0.2 animations:^(void) {
                self.alpha = 0;
                self.frame = toFrame;
            } completion:^(BOOL finished) {
                removeView();
            }];
        }
        else {
            removeView();
        }
    }
    [BFMallDetailRightPopView sharedMenu].isShow = NO;
}

- (void)performAction:(id)sender {
    [self dismissMenu:YES];
    BFMallModuleBtn *button = (BFMallModuleBtn *)sender;
//    [button performAction];
    if (_selectedItem) {
        _selectedItem(button.tag, button.pageType);
    }
}

- (void)drawRect:(CGRect)rect {
    [self drawBackground:self.bounds inContext:UIGraphicsGetCurrentContext()];
    // 绘制完成后,初始静态变量值
    // 防止下次调用控件时沿用上一次设置的属性
    [BFMallDetailRightPopView reset];
}

- (void)drawBackground:(CGRect)frame inContext:(CGContextRef) context {
    CGFloat R0 = 0.0, G0 = 0.0, B0 = 0.0;
    CGFloat R1 = 0.0, G1 = 0.0, B1 = 0.0;
    
    UIColor *tintColor = [BFMallDetailRightPopView tintColor];
    if (tintColor) {
        CGFloat a;
        [tintColor getRed:&R0 green:&G0 blue:&B0 alpha:&a];
        [tintColor getRed:&R1 green:&G1 blue:&B1 alpha:&a];
    }
    
    if ([BFMallDetailRightPopView backgrounColorEffect] ==  MenuBackgrounColorEffectGradient) {
        R1-=0.2;
        G1-=0.2;
        B1-=0.2;
    }
    
    CGFloat X0 = frame.origin.x;
    CGFloat X1 = frame.origin.x + frame.size.width;
    CGFloat Y0 = frame.origin.y;
    CGFloat Y1 = frame.origin.y + frame.size.height;
    
    // render arrow
    
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    
    // fix the issue with gap of arrow's base if on the edge
    const CGFloat kEmbedFix = 3.f;
    
    if (_arrowDirection ==  MenuViewArrowDirectionUp) {
        
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - [BFMallDetailRightPopView arrowSize];
        const CGFloat arrowX1 = arrowXM + [BFMallDetailRightPopView arrowSize];
        const CGFloat arrowY0 = Y0;
        const CGFloat arrowY1 = Y0 + [BFMallDetailRightPopView arrowSize] + kEmbedFix;
        
        [arrowPath moveToPoint:    (CGPoint){arrowXM, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY0}];
        
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:1] set];
        
        Y0 += [BFMallDetailRightPopView arrowSize];
        
    } else if (_arrowDirection ==  MenuViewArrowDirectionDown) {
        
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - [BFMallDetailRightPopView arrowSize];
        const CGFloat arrowX1 = arrowXM + [BFMallDetailRightPopView arrowSize];
        const CGFloat arrowY0 = Y1 - [BFMallDetailRightPopView arrowSize] - kEmbedFix;
        const CGFloat arrowY1 = Y1;
        
        [arrowPath moveToPoint:    (CGPoint){arrowXM, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY1}];
        
        [[UIColor colorWithRed:R1 green:G1 blue:B1 alpha:1] set];
        
        Y1 -= [BFMallDetailRightPopView arrowSize];
        
    } else if (_arrowDirection ==  MenuViewArrowDirectionLeft) {
        
        const CGFloat arrowYM = _arrowPosition;
        const CGFloat arrowX0 = X0;
        const CGFloat arrowX1 = X0 + [BFMallDetailRightPopView arrowSize] + kEmbedFix;
        const CGFloat arrowY0 = arrowYM - [BFMallDetailRightPopView arrowSize];;
        const CGFloat arrowY1 = arrowYM + [BFMallDetailRightPopView arrowSize];
        
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowYM}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowYM}];
        
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:1] set];
        
        X0 += [BFMallDetailRightPopView arrowSize];
        
    } else if (_arrowDirection ==  MenuViewArrowDirectionRight) {
        
        const CGFloat arrowYM = _arrowPosition;
        const CGFloat arrowX0 = X1;
        const CGFloat arrowX1 = X1 - [BFMallDetailRightPopView arrowSize] - kEmbedFix;
        const CGFloat arrowY0 = arrowYM - [BFMallDetailRightPopView arrowSize];;
        const CGFloat arrowY1 = arrowYM + [BFMallDetailRightPopView arrowSize];
        
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowYM}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowYM}];
        
        [[UIColor colorWithRed:R1 green:G1 blue:B1 alpha:1] set];
        
        X1 -= [BFMallDetailRightPopView arrowSize];
    }
    
    [arrowPath fill];
    
    // render body
    const CGRect bodyFrame = {X0, Y0, X1 - X0, Y1 - Y0};
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:bodyFrame
                                                          cornerRadius:[BFMallDetailRightPopView cornerRadius]];
    
    const CGFloat locations[] = {0, 1};
    const CGFloat components[] = {
        R0, G0, B0, 0.3,
        R1, G1, B1, 0.3,
    };
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace,
                                                                 components,
                                                                 locations,
                                                                 sizeof(locations)/sizeof(locations[0]));
    CGColorSpaceRelease(colorSpace);
    
    
    [borderPath addClip];
    
    CGPoint start, end;
    
    if (_arrowDirection ==  MenuViewArrowDirectionLeft ||
        _arrowDirection ==  MenuViewArrowDirectionRight) {
        
        start = (CGPoint){X0, Y0};
        end = (CGPoint){X1, Y0};
        
    } else {
        
        start = (CGPoint){X0, Y0};
        end = (CGPoint){X0, Y1};
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, 0);
    
    CGGradientRelease(gradient);
}

#pragma mark -  setter & getter

- (CGPoint)arrowPoint {
    CGPoint point;
    
    if (_arrowDirection ==  MenuViewArrowDirectionUp) {
        
        point = (CGPoint){ CGRectGetMinX(self.frame) + _arrowPosition, CGRectGetMinY(self.frame) };
        
    } else if (_arrowDirection ==  MenuViewArrowDirectionDown) {
        
        point = (CGPoint){ CGRectGetMinX(self.frame) + _arrowPosition, CGRectGetMaxY(self.frame) };
        
    } else if (_arrowDirection ==  MenuViewArrowDirectionLeft) {
        
        point = (CGPoint){ CGRectGetMinX(self.frame), CGRectGetMinY(self.frame) + _arrowPosition  };
        
    } else if (_arrowDirection ==  MenuViewArrowDirectionRight) {
        
        point = (CGPoint){ CGRectGetMaxX(self.frame), CGRectGetMinY(self.frame) + _arrowPosition  };
        
    } else {
        
        point = self.center;
    }
    
    return point;
}


- (UIImageView *)usrIcon {
    
    if (!_usrIcon) {
        _usrIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _usrIcon;
}

- (UILabel *)usrNameLab {
    
    if (!_usrNameLab) {
        _usrNameLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _usrNameLab.font = kBoldFont(17);
        _usrNameLab.textColor = [UIColor hexColor:@"#2D3640"];
        _usrNameLab.text = [GVUserDefaults standardUserDefaults].nickname;
    }
    return _usrNameLab;
    
}

- (UILabel *)usrDescLab {
    
    if (!_usrDescLab) {
        _usrDescLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _usrDescLab.font = kFont(12);
        _usrDescLab.textColor = [UIColor hexColor:@"#727272"];
        _usrDescLab.text = @"您还不是MAN选会员";
    }
    return _usrDescLab;
    
}

- (UILabel *)vipDescLab {
    
    if (!_vipDescLab) {
        
        _vipDescLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _vipDescLab.font = kFont(12);
        [_vipDescLab setTintColor:[UIColor hexColor:@"#727272"]];
    }
    return _vipDescLab;
    
}

- (BFMallModuleBtn *)goShoppingCartBtn {
    
    if (!_goShoppingCartBtn) {
        _goShoppingCartBtn = [[BFMallModuleBtn alloc] initWithFrame:CGRectZero];
        _goShoppingCartBtn.pageType = TYPE_SHOPPINGCART;
        [_goShoppingCartBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _goShoppingCartBtn.titleLabel.font = kFont(12);
        [_goShoppingCartBtn setTitle:@"购物车" forState:UIControlStateNormal];
        [_goShoppingCartBtn setImage:IMAGE_NAME(@"购物车") forState:UIControlStateNormal];

    }
    return _goShoppingCartBtn;
    
}

- (BFMallModuleBtn *)goCollectionBtn {
    
    if (!_goCollectionBtn) {
        _goCollectionBtn = [[BFMallModuleBtn alloc] initWithFrame:CGRectZero];
        _goCollectionBtn.pageType = TYPE_MYCOLLECTION;
        [_goCollectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _goCollectionBtn.titleLabel.font = kFont(12);
        [_goCollectionBtn setTitle:@"我的收藏" forState:UIControlStateNormal];
        [_goCollectionBtn setImage:IMAGE_NAME(@"收藏") forState:UIControlStateNormal];

    }
    return _goCollectionBtn;
    
}

- (BFMallModuleBtn *)goOrderDetailBtn {
    
    if (!_goOrderDetailBtn) {
        _goOrderDetailBtn = [[BFMallModuleBtn alloc] initWithFrame:CGRectZero];
        _goOrderDetailBtn.pageType = TYPE_MYORDER ;
        [_goOrderDetailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _goOrderDetailBtn.titleLabel.font = kFont(12);
        [_goOrderDetailBtn setTitle:@"我的订单" forState:UIControlStateNormal];
        [_goOrderDetailBtn setImage:IMAGE_NAME(@"订单") forState:UIControlStateNormal];

    }
    return _goOrderDetailBtn;
    
}

- (BFMallModuleBtn *)goAddressBtn {
    
    if (!_goAddressBtn) {
        
        _goAddressBtn = [[BFMallModuleBtn alloc] initWithFrame:CGRectZero];
        _goAddressBtn.pageType = TYPE_ADDRESS_MANAGER;
        [_goAddressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _goAddressBtn.titleLabel.font = kFont(12);
        [_goAddressBtn setTitle:@"地址管理" forState:UIControlStateNormal];
        [_goAddressBtn setImage:IMAGE_NAME(@"地址") forState:UIControlStateNormal];

    }
    return _goAddressBtn;
    
}

- (BFMallModuleBtn *)buyVipServiceBtn {
    
    if (!_buyVipServiceBtn) {
        
        _buyVipServiceBtn = [[BFMallModuleBtn alloc] initWithFrame:CGRectZero];
        _buyVipServiceBtn.pageType = TYPE_BUY_VIP;
        [_buyVipServiceBtn setTitleColor:[UIColor hexColor:@"#FFFFFF"] forState:UIControlStateNormal];
        _buyVipServiceBtn.titleLabel.font = kBoldFont(12);
        [_buyVipServiceBtn setTitle:@"立即购买199/年" forState:UIControlStateNormal];
        [_buyVipServiceBtn addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _buyVipServiceBtn;
    
}

- (BFMallModuleBtn *)renewBtn {
    
    if (!_renewBtn) {
        _renewBtn = [[BFMallModuleBtn alloc] initWithFrame:CGRectZero];
        _renewBtn.pageType = TYPE_BUY_VIP;
        [_renewBtn setTitle:@"续费" forState:UIControlStateNormal];
        [_renewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _renewBtn.titleLabel.font = kFont(12);
        [_renewBtn addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _renewBtn;
    
}

- (BFMallModuleBtn *)setBtn:(BFMallModuleBtn *)btn{
    
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height + 13), 0);

    return btn;
}

@end


#pragma mark -  BFMallDetailRightPopView
/// MenuView
static  BFMallDetailRightPopView                      *gMenu;

@implementation BFMallDetailRightPopView {
    MenuView *_menuView;
    BOOL         _observing;
}

#pragma mark System Methods
+ (instancetype)sharedMenu {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gMenu = [[BFMallDetailRightPopView alloc] init];
    });
    return gMenu;
}

- (id)init {
    NSAssert(!gMenu, @"singleton object");
    self = [super init];
    if (self) {
        self.isShow = NO;
    }
    return self;
}

- (void) dealloc {
    if (_observing) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

#pragma mark Public Methods
+ (void)showMenuInView:(UIView *)view fromRect:(CGRect)rect selected:(MenuSelectedItem)selectedItem {
    [[self sharedMenu] loadDataInView:view fromRect:rect selected:selectedItem];
}

+ (void)dismissMenu {
    [[self sharedMenu] dismissMenu];
}

+ (BOOL)isShow {
    return [[self sharedMenu] isShow];
}

+ (void)reset {
    gTintColor = nil;
    gTitleFont = nil;
    gArrowSize = kArrowSize;
    gCornerRadius = kCornerRadius;
    gBackgroundColorEffect =  MenuBackgrounColorEffectSolid;
    gHasShadow = NO;
}

- (void)loadDataInView:(UIView *)view fromRect:(CGRect)rect selected:(MenuSelectedItem)selectedItem {
    if ([GVUserDefaults standardUserDefaults].isVip) {
        NSString *url = NSStringFormat(@"%@%@", @"http://47.93.216.16:7081", API_VipRights);
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [[WebServiceTool shareHelper] postWithURLString:url parameters:parameters success:^(id  _Nonnull responseObject) {
            NSLog(@"%@-=-=-=",responseObject);
            self->_model = [MemberModel mj_objectWithKeyValues:responseObject[@"result"]];
            [self showMenuInView:view fromRect:rect Model:self->_model selected:selectedItem];
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@-=-=-=",error);
        }];
    }else {
        NSString *url = NSStringFormat(@"%@%@", @"http://47.93.216.16:7081", API_FindVipPriceList);
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [[WebServiceTool shareHelper] postWithURLString:url parameters:parameters success:^(id  _Nonnull responseObject) {
            NSLog(@"%@-=-=-=",responseObject);
            self->_model = [MemberModel mj_objectWithKeyValues:responseObject[@"result"]];
            [self showMenuInView:view fromRect:rect Model:self->_model selected:selectedItem];
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@-=-=-=",error);
        }];
    }
}

#pragma mark Private Methods
- (void)showMenuInView:(UIView *)view fromRect:(CGRect)rect Model:(MemberModel *)model selected:(MenuSelectedItem)selectedItem{
    NSParameterAssert(view);
    
    if (_menuView) {
        [_menuView dismissMenu:NO];
        _menuView = nil;
    }
    
    if (!_observing) {
        _observing = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationWillChange:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    }
    
    // 创建MenuView
    _menuView = [[MenuView alloc] init];
    _menuView.model = model;
    [_menuView showMenuInView:view fromRect:rect selected:selectedItem];
    self.isShow = YES;
}

- (void)dismissMenu {
    
    if (_menuView) {
        [_menuView dismissMenu:NO];
        _menuView = nil;
    }
    
    if (_observing) {
        _observing = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    
    self.isShow = NO;
}

#pragma mark Notification
- (void)orientationWillChange:(NSNotification *)notification {
    [self dismissMenu];
}

#pragma mark setter/getter
+ (UIColor *)tintColor {
    return gTintColor?gTintColor:kTintColor;
}

+ (void)setTintColor:(UIColor *)tintColor {
    if (tintColor != gTintColor) {
        gTintColor = tintColor;
    }
}

+ (CGFloat)cornerRadius {
    return gCornerRadius >0?gCornerRadius:kCornerRadius;
}

+ (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius > 0) {
        gCornerRadius = cornerRadius;
    }
}

+ (CGFloat)arrowSize {
    return gArrowSize > 0?gArrowSize:kArrowSize;
}

+ (void)setArrowSize:(CGFloat)arrowSize {
    if (arrowSize > 0) {
        gArrowSize = arrowSize;
    }
}

+ (UIFont *)titleFont {
    return gTitleFont?gTitleFont:kTitleFont;
}

+ (void)setTitleFont:(UIFont *)titleFont {
    if (titleFont != gTitleFont) {
        gTitleFont = titleFont;
    }
}

+ (MenuBackgrounColorEffect)backgrounColorEffect {
    return gBackgroundColorEffect;
}

+ (void)setBackgrounColorEffect:( MenuBackgrounColorEffect)effect {
    gBackgroundColorEffect = effect;
}

+ (BOOL)hasShadow {
    return gHasShadow;
}

+ (void)setHasShadow:(BOOL)flag {
    gHasShadow = flag;
}

@end
