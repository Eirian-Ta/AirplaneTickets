//
//  Purchase.m
//  AirplaneTicketApp
//
//  Created by Eirian Ta on 2022-06-23.
//  Copyright © 2022 EirianTa. All rights reserved.
//


#import "Purchase.h"

@implementation Purchase
-(NSMutableArray*)purchasedTickets{
    if(_purchasedTickets== nil) {
        _purchasedTickets = [[NSMutableArray alloc]init];
    }
    return _purchasedTickets;
}
@end
