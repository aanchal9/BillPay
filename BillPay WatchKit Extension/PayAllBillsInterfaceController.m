//
//  PayAllBillsInterfaceController.m
//  BillPay
//
//  Created by Aanchal Arora on 04/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "PayAllBillsInterfaceController.h"
#import "ServiceItem.h"

@interface PayAllBillsInterfaceController ()

@property double sum;
@property NSArray *context;
@property BOOL flag;

@end

@implementation PayAllBillsInterfaceController


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    if ([context isKindOfClass:[NSDictionary class]]) {
        NSDictionary *remoteNotification = context;
        NSDictionary* apsDict = [remoteNotification objectForKey:@"aps"];
        NSDictionary* alertDict = [apsDict objectForKey:@"alert"];
        NSMutableString *items = [[NSMutableString alloc]init];
        NSString *item = [[NSString alloc]init];
        
        NSArray *body = [alertDict objectForKey:@"body"];
        
        for (NSDictionary *service in body) {
            item = [NSString stringWithFormat:@"%@ : %@\n",[service valueForKey:@"item"],[service valueForKey:@"amount"]];
            [items appendString:item];
            
            self.sum += [(NSNumber *)[service valueForKey:@"amount"] floatValue];
            
        }

        
    }
    
        for (ServiceItem *item in context)
        {
            self.sum += item.billAmount;
        }
        
   //}
    
    self.cumulative = [NSNumber numberWithFloat:self.sum];
    [self.cumulativeAmountLabel setText:[NSString stringWithFormat:@"Rs. %0.2f",[self.cumulative floatValue]]];
   
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

- (IBAction)yesButton {
    
    [WKInterfaceController openParentApplication:@{@"request" : @"payBills", @"sum" : self.cumulative} reply:^(NSDictionary *replyInfo, NSError *error) {
        if (error == nil) {
            if ([replyInfo[@"done"] isEqualToString:@"yes"]) {
                self.flag = YES;
                [self pushControllerWithName:@"PaymentSuccessInterfaceController" context:self.context];
            }
            else {
                
            }
        }
        else {
            NSLog(@"%@", error.description);
        }
    }];

    
}

- (IBAction)noButton {
    
    [self popController];
}
@end



