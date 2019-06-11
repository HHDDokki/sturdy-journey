//
//  AddAddressController.h
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class ConsigneeMesModel;
typedef void(^AddAddressControllerBlock)(ConsigneeMesModel * model);
@interface AddAddressController : BaseViewController
@property (nonatomic,copy) AddAddressControllerBlock addBlock;

@end

NS_ASSUME_NONNULL_END
