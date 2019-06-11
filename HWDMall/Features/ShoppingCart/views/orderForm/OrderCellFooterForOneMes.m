//
//  OrderCellFooterForOneMes.m
//  HWDMall
//
//  Created by stewedr on 2018/10/27.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "OrderCellFooterForOneMes.h"

@interface OrderCellFooterForOneMes()
@property (weak, nonatomic) IBOutlet UILabel *onemesLbl;

@end

@implementation OrderCellFooterForOneMes

- (void)setMesStr:(NSString *)mesStr{
    if (_mesStr != mesStr) {
        _mesStr = mesStr;
    }
    self.onemesLbl.text = mesStr;
}
@end
