//
//  AddAddressMesCell.h
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OderCellModel;
@class ConsigneeMesModel; // 显示信息

typedef void(^UpdateAddressBlock)(NSString * address);

@interface AddAddressMesCell : UITableViewCell

@property (nonatomic,copy) HeightChangeBlock changeBlock;
@property (nonatomic,copy) UpdateAddressBlock updateAddressblock;


- (void)refreshContent:(OderCellModel *)creatModel commitModel:(ConsigneeMesModel *)commitmodel;

@end

