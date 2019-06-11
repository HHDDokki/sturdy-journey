//
//  EditAddressController.h
//  HWDMall
//
//  Created by stewedr on 2018/10/24.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BaseViewController.h"

@class AddressListModel;
typedef void(^EditAddressControllerBlock)(AddressListModel * model);
@interface EditAddressController : BaseViewController
@property (nonatomic,strong) AddressListModel *mesModel;
@property (nonatomic,copy)  EditAddressControllerBlock editBlock;

@end

