//
//  AccountSummaryController.h
//  BillPay
//
//  Created by Aanchal Arora on 26/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface AccountSummaryController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *accountType;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *accountNumber;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *accountBranch;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *accountBalance;

@end
