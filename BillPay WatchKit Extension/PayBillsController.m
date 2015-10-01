//
//  PayBillsController.m
//  BillPay
//
//  Created by Aanchal Arora on 26/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "PayBillsController.h"
#import "PayBillsRowType.h"
#import "ServiceItem.h"
#import "InterfaceController.h"

@interface PayBillsController ()

@property NSArray *services;

@end

@implementation PayBillsController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self.payNowButton setHidden:YES];
    [self.noBillsLabel setHidden:YES];
    [WKInterfaceController openParentApplication:@{@"request" : @"getBillsToPay"} reply:^(NSDictionary *replyInfo, NSError *error) {
        if (error == nil) {
            
            
            self.services = [NSKeyedUnarchiver unarchiveObjectWithData:replyInfo[@"bills"]];
            
            if (self.services.count > 0) {
            
                [self.payBillsTable setNumberOfRows:self.services.count withRowType:@"PayBillsRowType"];
            
                for (int i=0; i<self.services.count; i++) {
                        PayBillsRowType *row = [self.payBillsTable rowControllerAtIndex:i];
                        [row.label1 setText:((ServiceItem *)self.services[i]).serviceName];
                        [row.label2 setText:[NSString stringWithFormat:@"%.2f",((ServiceItem *)self.services[i]).billAmount]];
                        [row.companyImage setImage:((ServiceItem *)self.services[i]).serviceImage];
                    }
                [self.payNowButton setHidden:NO];
            }
            else {
                [self.noBillsLabel setHidden:NO];
                [self.payNowButton setHidden:YES];
            }

        }
        else {
            [self.noBillsLabel setHidden:NO];
            NSLog(@"%@", error);
        }
    }];

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
- (IBAction)payBills {
    
    [self pushControllerWithName:@"PayAllBillsInterfaceController" context:self.services];
}


@end



