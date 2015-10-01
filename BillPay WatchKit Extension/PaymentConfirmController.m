//
//  PaymentConfirmController.m
//  BillPay
//
//  Created by Aanchal Arora on 26/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "PaymentConfirmController.h"
#import "PayBillsController.h"
#import "ServiceItem.h"

@interface PaymentConfirmController ()

@property NSArray *context;
@property BOOL flag;

@end

@implementation PaymentConfirmController

- (void)awakeWithContext:(id)context {
    
    [super awakeWithContext:context];
    
    if (context!=nil) {
        self.context = context;
        [self.confirmLabel setText:[NSString stringWithFormat:@"%@", ((ServiceItem *)context[0]).serviceName]];
        [self.amountLabel setText:[NSString stringWithFormat:@"%.2f", ((ServiceItem *)context[0]).billAmount]];
    
    }
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if (self.flag == YES) {
        [self popToRootController];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)noButton {
    
    [self popController];
}

- (IBAction)yesButton {
    
    self.flag = YES;
    [self presentControllerWithName:@"PaymentSuccessInterfaceController" context:self.context];
    
}

@end



