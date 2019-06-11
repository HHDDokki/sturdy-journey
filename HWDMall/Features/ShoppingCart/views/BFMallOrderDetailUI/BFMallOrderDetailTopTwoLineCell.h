//
//  BFMallOrderDetailTopTwoLineCell.h
//  HWDMall
//
//  Created by HandC1 on 2019/5/30.
//  Copyright © 2019 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFMallOrderDetailTopTwoLineCell : UITableViewCell

@property (nonatomic,copy) TimeDownBlock timedownBlock;
@property (nonatomic, strong) UILabel *timeDownLbl;
@property(nonatomic,strong) CADisplayLink *displayLink;
@property(nonatomic,strong) NSDate *startDate;
@property(nonatomic,assign) NSTimeInterval timeInterval;



- (void)udpateCellMesWithHeadImage:(NSString *)imageName
                            Status:(NSString *)status
                          Suttitle:(NSString *)subtitle
                 TimeDownLblHidden:(BOOL)timedownhidden
                          TimeDown:(NSInteger)timedown;
@end

NS_ASSUME_NONNULL_END
