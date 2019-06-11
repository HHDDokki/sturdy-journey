//
//  OrderDetailTopTwoLineCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/29.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface OrderDetailTopTwoLineCell : UITableViewCell

@property (nonatomic,copy) TimeDownBlock timedownBlock;
@property (weak, nonatomic) IBOutlet UILabel *timeDownLbl;
@property(nonatomic,assign) NSTimeInterval timeInterval;
@property(nonatomic,strong) CADisplayLink *displayLink;
@property(nonatomic,strong) NSDate *startDate;

- (void)udpateCellMesWithHeadImage:(NSString *)imageName
                            Status:(NSString *)status
                          Suttitle:(NSString *)subtitle
                 TimeDownLblHidden:(BOOL)timedownhidden
                          TimeDown:(NSInteger)timedown;

@end

NS_ASSUME_NONNULL_END
