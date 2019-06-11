//
//  ShoppingcartHeader.h
//  HWDMall
//
//  Created by stewedr on 2018/11/5.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SectionSelectedBlock)(BOOL selectStatus);

@interface ShoppingcartHeader : UITableViewHeaderFooterView

@property (nonatomic,copy) SectionSelectedBlock selectedBlock;
@property (nonatomic,copy) SectionSelectedBlock selectShopName;


- (void)updateHeaderMesWithShopName:(NSString *)shopname
                   SeletectedStatus:(BOOL)seletedstatus;

@end

