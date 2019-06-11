//
//  WuliuListCell.h
//  HWDMall
//
//  Created by stewedr on 2018/12/19.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(void);
@interface WuliuListCell : UITableViewCell
@property (nonatomic,copy) TapBlock tapblock;

- (void)updateCellWith:(NSString *)statusStr
             WuliuSign:(NSString *)wuliusignStr
              WuliuMes:(NSString *)wuliumes
                PicArr:(NSArray *)picArr
            GoodsCount:(NSString *)goodscountStr;
@end

