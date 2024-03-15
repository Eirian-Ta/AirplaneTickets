//
//  Voucher.h
//  AirplaneTicketApp
//
//  Created by Eirian Ta on 2022-06-23.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Voucher : NSObject
@property (nonatomic) NSString *voucherCode;
@property (nonatomic) NSInteger percentOff;
// Valid time
// Type of sales...
-(id)initWithCode:(NSString *)vCode andPercentage:(int)percentOff;
-(NSString *)toString;
@end

NS_ASSUME_NONNULL_END
