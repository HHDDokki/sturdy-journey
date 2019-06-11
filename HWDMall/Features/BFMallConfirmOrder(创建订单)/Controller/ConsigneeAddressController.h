//
//  ConsigneeAddressController.h
//  HWDMall
//
//  Created by stewedr on 2018/10/23.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "BaseViewController.h"
#import "ConsigneeMesModel.h"

typedef void(^SelectedAddressBlock)(AddressListModel *addressmodel);

@interface ConsigneeAddressController : BaseViewController
@property (nonatomic,copy) SelectedAddressBlock selectedBlock;

@end

