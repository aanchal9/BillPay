//
//  PayBillsController.h
//  BillPay
//
//  Created by Aanchal Arora on 26/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface PayBillsController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceButton *payNowButton;
@property (weak, nonatomic) IBOutlet WKInterfaceTable *payBillsTable;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *noBillsLabel;

@end
