//
//  AccountSummaryController.m
//  BillPay
//
//  Created by Aanchal Arora on 26/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "AccountSummaryController.h"
#import "MainRowType.h"
#import "AccountItem.h"
#import "ItemRowType.h"
#import "ServiceItem.h"

@interface AccountSummaryController ()

@property AccountItem *account;

@end

@implementation AccountSummaryController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSUserDefaults *accountDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.ibm.test1"];
    
    self.account = [NSKeyedUnarchiver unarchiveObjectWithData:[accountDefaults objectForKey:@"defaultAccount"]];
    [WKInterfaceController openParentApplication:@{@"request" : @"accountInfo", @"accountNumber" : self.account.accountNumber} reply:^(NSDictionary *replyInfo, NSError *error) {
        if (error == nil) {
            [self.accountBalance setText:[NSString stringWithFormat:@"%@",replyInfo[@"balance"]]];
        }
    }];
    [self.accountType setText:self.account.accountType];
    [self.accountNumber setText:self.account.accountNumber];
    [self.accountBranch setText:self.account.branchName];
    //[self.accountBalance setText:[NSString stringWithFormat:@"%.2f", self.account.balance]];
    
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


@end



