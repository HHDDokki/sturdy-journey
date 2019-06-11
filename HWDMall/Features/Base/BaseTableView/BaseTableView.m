//
//  BaseModel.h
//  Alliance
//
//  Created by sk on 2018/7/18.
//  Copyright © 2018年 duyiwang. All rights reserved.
//

#import "BaseTableView.h"
#import <objc/runtime.h>

@interface BaseTableView ()
@property (nonatomic, strong) UILabel *labelNoMoreNumber;


@end

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
        
    }
    return self;
}

- (void)setup {
    self.estimatedSectionFooterHeight = 0.0;
    self.estimatedSectionHeaderHeight = 0.0;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor colorWithHexString:kLightGreyColor];//[UIColor colorWithHex:kBgColor];
    self.showsVerticalScrollIndicator = NO;
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)removeFromSuperview {
    if ([self hasAddObserver]) {
        @try {
            [self removeObserver:self forKeyPath:@"numberViewSourceNum"];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
    }
    [super removeFromSuperview];
}

#pragma mark - Setter
- (void)setFooterTitle:(NSString *)footerTitle {
    _footerTitle = footerTitle;
    self.labelNoMoreNumber.text = footerTitle;
}

-(void)setShowNoNumberView:(BOOL)showNoNumberView
{
    _showNoNumberView=showNoNumberView;
    if (_showNoNumberView) {
        [self addContentObserver];
    }
}
-(void)addContentObserver
{
    if (![self hasAddObserver]) {
        [self addObserver:self forKeyPath:@"numberViewSourceNum" options:NSKeyValueObservingOptionNew context:(__bridge void*)self];
        objc_setAssociatedObject(self, @"hasAddObserver", [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(BOOL)hasAddObserver
{
    NSNumber *hasAdd=objc_getAssociatedObject(self, @"hasAddObserver");
    if (hasAdd&&hasAdd.boolValue) {
        return YES;
    }
    return NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ((__bridge id)context == self) {
        if ([@"numberViewSourceNum" isEqualToString:keyPath]) {
            [self resetNoNumberView];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object
                               change:change context:context];
    }
}

- (void)resetNoNumberView {
    self.labelNoMoreNumber.hidden = !self.numberViewSourceNum;
}


#pragma mark -  Lazy Load
- (UILabel *)labelNoMoreNumber {
    if (!_labelNoMoreNumber) {
        _labelNoMoreNumber = [[UILabel alloc] init];
        _labelNoMoreNumber.numberOfLines = 1;
        _labelNoMoreNumber.textAlignment=NSTextAlignmentCenter;
        _labelNoMoreNumber.font = kFont(12);
        _labelNoMoreNumber.backgroundColor=[UIColor clearColor];
//        _labelNoMoreNumber.textColor= kRGBA(153, 153, 153, 1);
        _labelNoMoreNumber.hidden=YES;
        _labelNoMoreNumber.frame=CGRectMake(0, 0, kScreenWidth, viewX(30));
         self.tableFooterView = _labelNoMoreNumber;
        
      }
    return _labelNoMoreNumber;
}
@end
