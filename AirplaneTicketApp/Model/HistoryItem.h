//
//  HistoryItem.h
//  RaptorsTickets
//
//  Created by Eirian Ta on 2022-06-19.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryItem : Ticket
@property (nonatomic) NSLocale *date;
- (NSString *)printDate;
@end

NS_ASSUME_NONNULL_END
