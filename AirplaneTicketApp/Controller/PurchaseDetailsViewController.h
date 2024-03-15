//
//  PurchaseDetailsViewController.h
//  AirplaneTicketApp
//
//  Created by Eirian Ta on 2022-06-24.
//  Copyright © 2022 EirianTa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchaseDetailsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic) Purchase *myPurchase;
@property (nonatomic) Store *store;
@end

NS_ASSUME_NONNULL_END
