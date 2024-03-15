//
//  ViewController.m
//  AirplaneTicketApp
//
//  Created by Eirian Ta on 2022-06-23.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import "Store.h"
#import "Purchase.h"
#import "PurchaseDetailsViewController.h"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ticketQtyInput;
@property (weak, nonatomic) IBOutlet UIPickerView *ticketTypePickerView;
@property (weak, nonatomic) IBOutlet UITextView *purchaseDetailsDisplay;
@property (weak, nonatomic) IBOutlet UITextField *voucherInput;
@property (weak, nonatomic) IBOutlet UITextField *commentInput;
@property (weak, nonatomic) IBOutlet UILabel *extraDisplay;

@property(nonatomic)BOOL addNewTicket;
@property (nonatomic) int selectedRow;
@property (nonatomic) Store *myStore;
@property (nonatomic) Purchase *aPurchase;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.ticketQtyInput.placeholder=@"Number of Ticket";
    self.extraDisplay.text=@"";
    self.voucherInput.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.purchaseDetailsDisplay.userInteractionEnabled = NO;

    self.addNewTicket=YES;
    self.selectedRow=0;

    self.myStore = [[Store alloc]init];
    [self.myStore loadTicketList];
    self.aPurchase=[Purchase alloc];
    self.purchaseDetailsDisplay.scrollEnabled=YES;
    
    

//    self.typeTicketDisplay.text=[[self.myStore.listOfTickets objectAtIndex:self.selectedRow] ticketType];

}
//
//- (void)viewWillAppear:(BOOL)animated{
//    self.ticketQtyInput.text=@"";
//    self.voucherInput.text=@"";
//    self.commentInput.text=@"";
//    self.purchaseDetailsDisplay.text=@"";
//    self.extraDisplay.text=@"";
//
//}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.myStore.listOfTickets.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.myStore.listOfTickets objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //NSLog(@"row %d in component %d was selected",(int)row,(int)component);
    self.selectedRow=(int)row;
//    self.typeTicketDisplay.text=[[self.myStore.listOfTickets objectAtIndex:self.selectedRow] ticketType];
}

//Prevent users from entering too long input for textfields
- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string{
    if (range.length + range.location > textField.text.length) {
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <=120;
}

- (IBAction)applyVoucher {
    self.extraDisplay.text=@"";
    if (![self.voucherInput.text  isEqual: @""]) {
            NSLog(@"Applying voucher...");
        [self.myStore loadValidVoucherList];
        int verifiedIndex = [self.myStore voucherVerification:self.voucherInput.text];
        if (verifiedIndex == -1) {
            self.extraDisplay.text=@"Invalid voucher!";
        }
        else {
            self.aPurchase.voucher = self.voucherInput.text;
            self.extraDisplay.text = [[self.myStore.listOfValidVouchers objectAtIndex:verifiedIndex] toString];
        }
    }
}


- (IBAction)addTicket {
    // Assume users do not choose 1 type multiple times. Otherwise, must compare the type chosen with the types in list and update the qty if 1 type is chosen multiple times
    Ticket *ticket = [[Ticket alloc]initWithTicketType:[self.myStore.listOfTickets objectAtIndex:self.selectedRow] andQty:(int)[self.ticketQtyInput.text integerValue]];
    [self.aPurchase.purchasedTickets addObject:ticket];
    [self.purchaseDetailsDisplay insertText:[NSString stringWithFormat:@"\n%@",ticket.toString]];
}

- (void)startNewPurchase{
    NSLog(@"Start new purchase");
    self.aPurchase=nil;
    self.aPurchase=[Purchase alloc];
    self.ticketQtyInput.text=@"";
    self.voucherInput.text=@"";
    self.commentInput.text=@"";
    self.purchaseDetailsDisplay.text=@"";
    self.extraDisplay.text=@"";
}

- (void)editExistingPurchase{
    NSLog(@"Edit Existing purchase");
    self.ticketQtyInput.text=@"";
    self.voucherInput.text=@"";
    self.commentInput.text=@"";
    self.purchaseDetailsDisplay.text=@"";
    self.extraDisplay.text=@"";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.aPurchase.comment = self.commentInput.text;

    PurchaseDetailsViewController *des = (PurchaseDetailsViewController*) [segue destinationViewController];
    des.myPurchase = self.aPurchase;
    des.store = self.myStore;
}


@end
