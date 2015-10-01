//
//  PaymentConfirmController.h
//  BillPay
//
//  Created by Aanchal Arora on 26/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface PaymentConfirmController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *confirmLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *yes;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *no;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *amountLabel;


@end
