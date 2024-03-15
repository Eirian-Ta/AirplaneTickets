//
//  Ticket.m
//  RaptorsTickets
//
//  Created by Eirian Ta on 2022-06-19.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import "Ticket.h"


@implementation Ticket
-(id)initWithTicketType:(NSString *)aType andQty:(int)quantity
{
    self = [super init];
    if (self) {
        _ticketType=aType;
        _qty= quantity;
    }
    return self;
}

-(NSString *)toString{
    return [NSString stringWithFormat:@"%@ quantity is %d", self.ticketType,self.qty];
}
-(void)restock:(int)numOfTickets{
    self.qty+=numOfTickets;
}

@end
