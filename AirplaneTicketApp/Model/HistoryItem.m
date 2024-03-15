//
//  HistoryItem.m
//  RaptorsTickets
//
//  Created by Eirian Ta on 2022-06-19.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import "Ticket.h"
#import "HistoryItem.h"

@implementation HistoryItem
- (NSString *)printDate{
    return [[NSDate date] descriptionWithLocale:self.date];
}
@end
