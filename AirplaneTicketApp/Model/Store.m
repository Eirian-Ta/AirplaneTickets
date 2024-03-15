//
//  Store.m
//  RaptorsTickets
//
//  Created by Eirian Ta on 2022-06-19.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import "Voucher.h"
#import "Store.h"


@implementation Store
- (NSMutableArray*)listOfTickets{
    if(_listOfTickets== nil) {
        _listOfTickets = [[NSMutableArray alloc]init];
    }
    return _listOfTickets;
}
- (NSMutableArray*)listOfValidVouchers{
    if(_listOfValidVouchers== nil) {
        _listOfValidVouchers = [[NSMutableArray alloc]init];
    }
    return _listOfValidVouchers;
}

-(void)loadTicketList{
    [self.listOfTickets addObject:@"VIP"];
    [self.listOfTickets addObject:@"Business"];
    [self.listOfTickets addObject:@"Economy Adult"];
    [self.listOfTickets addObject:@"Economy Kid"];
    [self.listOfTickets addObject:@"Infant"];
}

-(void)loadValidVoucherList{
    [self.listOfValidVouchers addObject:[[Voucher alloc] initWithCode:@"SENECA" andPercentage:10]];
    [self.listOfValidVouchers addObject:[[Voucher alloc] initWithCode:@"EIRIAN" andPercentage:5]];
}

-(int)voucherVerification:(NSString*)voucherInputFromUser{
    NSLog(@"Verifying: %@", voucherInputFromUser);
    for (int i=0; i< self.listOfValidVouchers.count;i++){
        NSLog(@"%@", [[self.listOfValidVouchers objectAtIndex:i] voucherCode]);
        if ([[[self.listOfValidVouchers objectAtIndex:i] voucherCode] isEqualToString: voucherInputFromUser]) {
            return i;
        }
    }
    return -1;
}

@end
