//
//  Ticket.h
//  RaptorsTickets
//
//  Created by Eirian Ta on 2022-06-19.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Ticket : NSObject
@property (nonatomic) NSString *ticketType;
//@property (nonatomic) double price;
@property (nonatomic) int qty;
-(id)initWithTicketType:(NSString *)aType andQty:(int)quantity;
//-(id)initWithTicketType:(NSString *)aType andPrice:(double)aPrice andQty:(int)quantity;
-(NSString *)toString;
-(void)restock:(int)numOfTickets;
@end

NS_ASSUME_NONNULL_END
