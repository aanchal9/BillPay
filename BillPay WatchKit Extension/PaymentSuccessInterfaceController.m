//
//  PaymentSuccessInterfaceController.m
//  BillPay
//
//  Created by Aanchal Arora on 27/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "PaymentSuccessInterfaceController.h"
#import "PayBillsController.h"
#import "InterfaceController.h"
#import <UIKit/UIKit.h>

@interface PaymentSuccessInterfaceController ()

@end

@implementation PaymentSuccessInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    if ([context[2] isEqualToString:@"pay selected bill"]) {
        InterfaceController *obj = context[1];
        [obj.services removeObject:context[0]];
    }
    else
    {
        InterfaceController *obj = context[1];
        [obj.services removeAllObjects];
    }
    
//    // Configure interface objects here.
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



