//
//  GoodsTypeBtnsView.m
//  HWDMall
//
//  Created by sk on 2018/11/6.
//  Copyright © 2018年 stewardR. All rights reserved.
//

#import "GoodsTypeBtnsView.h"
#import <QuartzCore/QuartzCore.h>

//#define CORNER_RADIUS 10.0f

//连个按钮左右之间的间隙
#define LT_BUTTON_PADDING 5.0f
//连个按钮上下之间的间隙
#define LT_BUTTON_PADDING_UP 5.0f
//字体大小
#define LT_FONT_SIZE 15.0f
//左右内变局
#define LT_HORIZONTAL_PADDING 10.0f
//上下内边距
#define LT_VERTICAL_PADDING 4.0f
//背景颜色
#define LT_BG_COLOR [UIColor whiteColor]
//字体颜色
#define LT_TEXTCOLOR [UIColor colorWithRed:150/255.0 green:155/255.0 blue:160/255.0 alpha:1.000] //字体颜色
#define LT_TEXT_SHADOW_COLOR [UIColor whiteColor]
#define LT_TEXT_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)
#define LT_BOARD_COLOR   [UIColor colorWithRed:1 green:1 blue:1 alpha:1.000].CGColor //边框颜色

#define LT_BORDER_WIDTH 1.0f
#define LT_BUTTON_HEIGHT 40 //高
@implementation GoodsTypeBtnsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.ltView];
    }
    return self;
}

- (void)getArrayDataSourse:(NSArray *)array
{
    self.arrDataSourse = [[NSArray alloc] initWithArray:array];
    self.heightSize = CGSizeZero;
    [self showBtn];
}

- (void)setLabelBackgroundColor:(UIColor *)color
{
    self.btnBgColor = color;
    [self showBtn];
}

- (void)showBtn
{
    for (UIButton *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    
    int tags=0;
    
    for (NSString *singleText in self.arrDataSourse) {
        
        
        CGRect textSize  = [self sizeWithFont:singleText];
        
        textSize.size.width += LT_HORIZONTAL_PADDING*2;
        textSize.size.height += LT_VERTICAL_PADDING*2;
        UIButton *ltBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (!gotPreviousFrame) {
            ltBtn.frame=CGRectMake(0, 0, textSize.size.width, textSize.size.height);
            totalHeight = textSize.size.height;
        } else {
            CGRect newRect = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + textSize.size.width + LT_BUTTON_PADDING > self.frame.size.width) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.size.height + LT_BUTTON_PADDING_UP);
                totalHeight += textSize.size.height + LT_BUTTON_PADDING_UP;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LT_BUTTON_PADDING, previousFrame.origin.y);
            }
            newRect.size = textSize.size;
            ltBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            ltBtn.frame=newRect;
        }
        previousFrame = ltBtn.frame;
        gotPreviousFrame = YES;
        
        
        
        [ltBtn.titleLabel setFont:[UIFont systemFontOfSize:LT_FONT_SIZE]];
        
        if (!self.btnBgColor) {
            [ltBtn setBackgroundColor:LT_BG_COLOR];
        } else {
            [ltBtn setBackgroundColor:self.btnBgColor];
        }
        
        [ltBtn setTitleColor:LT_TEXTCOLOR forState:UIControlStateNormal];
        [ltBtn setTitleColor:[UIColor colorWithRed:1.000 green:0.340 blue:0.293 alpha:1.000] forState:UIControlStateSelected];
        
        [ltBtn setTitle:singleText forState:UIControlStateNormal];
        [ltBtn.titleLabel setShadowColor:LT_TEXT_SHADOW_COLOR];
        [ltBtn.titleLabel setShadowOffset:LT_TEXT_SHADOW_OFFSET];
        [ltBtn.layer setMasksToBounds:YES];
        
        float cornerRadio = ltBtn.frame.size.height/2;
        
        [ltBtn.layer setCornerRadius:cornerRadio];
        [ltBtn.layer setBorderColor:LT_BOARD_COLOR];
        [ltBtn.layer setBorderWidth: LT_BORDER_WIDTH];
        ltBtn.titleLabel.font = [UIFont systemFontOfSize:LT_FONT_SIZE];
        
        [ltBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ltBtn];
        
        //        if (tags==0) {
        //            [self click:ltBtn];
        //        }
        
        ltBtn.tag=tags;
        
        tags+=1;
        
    }
    self.heightSize = CGSizeMake(self.frame.size.width, totalHeight + 1.0f);
    
}

#pragma mark - 传递点击事件
-(void)click:(UIButton *)tag{
    UIButton *tags=(UIButton *)[self viewWithTag:tag.tag];
    
    self.btn.selected=NO;
    tag.selected=YES;
    self.btn=tag;
    
    if (self.block) {
        self.block(tags.tag,self.tag);
    }
}
-(void)setChooseBlock:(chooseBlock)block{
    
    self.block=[block copy];
    
}
#pragma mark - 返回总的size 方便获取总的高度
- (CGSize)returnSize
{
    return self.heightSize;
}
-(CGRect)sizeWithFont:(NSString *)text{
    
    CGRect textSize = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, LT_BUTTON_HEIGHT) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:LT_FONT_SIZE],NSFontAttributeName, nil] context:nil];
    return textSize;
    
}

@end
