//
//  ConfirmOrderBottomMesView.m
//  HWDMall
//
//  Created by stewedr on 2018/10/26.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "ConfirmOrderBottomMesView.h"

@interface ConfirmOrderBottomMesView()
@property (weak, nonatomic) IBOutlet UILabel *goodsnameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@end

@implementation ConfirmOrderBottomMesView

- (void)updataMesWithGoodsName:(NSString *)goodname GroupTime:(NSString *)grouptime{
    self.goodsnameLbl.text = goodname;
    self.timeLbl.text = grouptime;
}

@end
