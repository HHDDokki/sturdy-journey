//
//  ConfirmOrderSectionView.h
//  HWDMall
//
//  Created by stewedr on 2018/10/18.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(void);

@interface ConfirmOrderSectionView : UITableViewHeaderFooterView
@property (nonatomic,copy) TapBlock tapBlock;

- (void)updateHeaderWithName:(NSString *)shopname;


@end
