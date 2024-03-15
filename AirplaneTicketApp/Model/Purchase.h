//
//  Purchase.h
//  AirplaneTicketApp
//
//  Created by Eirian Ta on 2022-06-23.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import "Ticket.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Purchase : NSObject
@property (nonatomic) NSMutableArray *purchasedTickets;
@property (nonatomic) NSString *voucher; //only 1 voucher can be applied for a purchase
@property (nonatomic) NSString *comment;

@end

NS_ASSUME_NONNULL_END
