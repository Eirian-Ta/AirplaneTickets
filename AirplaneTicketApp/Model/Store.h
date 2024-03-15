//
//  Store.h
//  RaptorsTickets
//
//  Created by Eirian Ta on 2022-06-19.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import "HistoryItem.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Store : NSObject
@property (nonatomic) NSMutableArray *listOfTickets;
@property (nonatomic) NSMutableArray *listOfValidVouchers;
- (void)loadTicketList;
-(void)loadValidVoucherList;
-(int)voucherVerification:(NSString*)voucherInputFromUser;
//- (double)buyTicket:(HistoryItem *)purchasedTicket;
@end

NS_ASSUME_NONNULL_END
