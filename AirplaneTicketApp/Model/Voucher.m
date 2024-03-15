//
//  Voucher.m
//  AirplaneTicketApp
//
//  Created by Eirian Ta on 2022-06-23.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import "Voucher.h"

@implementation Voucher
-(id)initWithCode:(NSString *)vCode andPercentage:(int)percentOff
{
    self = [super init];
    if (self) {
        _voucherCode=vCode;
        _percentOff= percentOff;
    }
    return self;
}

-(NSString *)toString{
    return [NSString stringWithFormat:@"%@ Voucher applied for %ld%% discount", self.voucherCode,(long)self.percentOff];
}
@end
