//
//  GlanceInterfaceController.m
//  BillPay
//
//  Created by Aanchal Arora on 04/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "GlanceInterfaceController.h"
#import "AccountItem.h"

@interface GlanceInterfaceController ()

@property AccountItem *account;

@end

@implementation GlanceInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSUserDefaults *accountDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.ibm.test1"];
    self.account = [NSKeyedUnarchiver unarchiveObjectWithData:[accountDefaults objectForKey:@"defaultAccount"]];
    [WKInterfaceController openParentApplication:@{@"request" : @"accountInfo", @"accountNumber" : self.account.accountNumber} reply:^(NSDictionary *replyInfo, NSError *error) {
        if (error == nil) {
            [self.infoLabel setText:[NSString stringWithFormat:@"%@",replyInfo[@"balance"]]];
        }
    }];
    [self.accountTypeLabel setText:self.account.accountType];
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



