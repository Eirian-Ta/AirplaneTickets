//
//  PurchaseDetailsViewController.m
//  AirplaneTicketApp
//
//  Created by Eirian Ta on 2022-06-24.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import "Store.h"
#import "Purchase.h"
#import "PurchaseDetailsViewController.h"
#import "ViewController.h"

@interface PurchaseDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *ticketsTableView;
@property (weak, nonatomic) IBOutlet UILabel *voucherDisplay;
@property (weak, nonatomic) IBOutlet UITextView *commentDisplay;

@property (nonatomic) NSString* selectedTypeFromPickerView;


@end


@implementation PurchaseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.commentDisplay.text = self.myPurchase.comment;
    self.voucherDisplay.text=self.myPurchase.voucher;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.myPurchase.purchasedTickets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [[UITableViewCell alloc]init]; // not optimal way
    // this is a more optimal way
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    
    //cell.textLabel.text=@"Hello";
    cell.textLabel.text=[[self.myPurchase.purchasedTickets objectAtIndex:indexPath.row]ticketType];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%d",[[self.myPurchase.purchasedTickets objectAtIndex:indexPath.row]qty]];
    return cell;
}

#pragma mark - Pickerview
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.store.listOfTickets.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.store.listOfTickets objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //NSLog(@"row %d in component %d was selected",(int)row,(int)component);
    self.selectedTypeFromPickerView = [self.store.listOfTickets objectAtIndex:row];
}

//- (BOOL)tableView: (UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    return YES;
//}

//- (void)tableView: (UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.myPurchase.purchasedTickets removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        //[tableView reloadData]; //only use when table needs reloading
//    }
//
//}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Action when user click "Edit Qty" Btn -- START
    UITableViewRowAction *editQtyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit Qty" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        // Alert Box -- START
        UIAlertController *editQtyAlertController = [UIAlertController alertControllerWithTitle:@"Edit Quantity" message:@"Change quantity of this ticket type:" preferredStyle:UIAlertControllerStyleAlert];
        [editQtyAlertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"Number of Ticket";
        }];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //NSLog(@"New Qty Input: %@", [[editQtyAlertController textFields][0] text]);
            // Set new Qty
            [[self.myPurchase.purchasedTickets objectAtIndex:indexPath.row]setQty:(int)[[[editQtyAlertController textFields][0]text] integerValue]];
            // Update row
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        [editQtyAlertController  addAction:confirmAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [editQtyAlertController  addAction:cancelAction];
        [self presentViewController:editQtyAlertController animated:YES completion:nil];
        // Alert Box -- END
    }];
    //Action when user click "Edit Qty" Btn -- END
    editQtyAction.backgroundColor = [UIColor blueColor];
    
    //Action when user click "Edit Type" Btn -- START
    UITableViewRowAction *editTypeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit Type" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        // Alert Box -- START
        UIAlertController *editTypeAlertController  = [UIAlertController alertControllerWithTitle:@"Edit Ticket Type" message:@"Choose the type of ticket\n\n\n\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
        
        //Make a frame for the picker & then create the picker
        CGRect pickerFrame = CGRectMake(0, 0, 270, 300);
        UIPickerView *regionsPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
        
        //set the pickers selection indicator to true so that the user will now which one that they are chosing
        //[regionsPicker setShowsSelectionIndicator:YES];
        
        //Add the picker to the alert controller
        [editTypeAlertController.view addSubview:regionsPicker];
        
        //set the pickers datasource and delegate
        regionsPicker.dataSource = self;
        regionsPicker.delegate = self;
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // Set new Type
            [[self.myPurchase.purchasedTickets objectAtIndex:indexPath.row]setTicketType:self.selectedTypeFromPickerView];
            // Update row
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        [editTypeAlertController addAction:confirmAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [editTypeAlertController addAction:cancelAction];
        [self presentViewController:editTypeAlertController animated:NO completion:nil];
        //

    }];
    editTypeAction.backgroundColor = [UIColor orangeColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
            [self.myPurchase.purchasedTickets removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction,editQtyAction, editTypeAction];
}


- (IBAction)donePressed {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thank you!" message:@"Enjoy Your Trip" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            //btn click event;
            ViewController* mainController = (ViewController*)self.presentingViewController;
            [self dismissViewControllerAnimated:YES completion:^{
                //NSLog(@"Clearing");
                [mainController startNewPurchase];
            }];
        }];
        [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)addMoreTicketPressed {
    ViewController* mainController = (ViewController*)self.presentingViewController;
    [self dismissViewControllerAnimated:YES completion:^{
        [mainController editExistingPurchase];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
