//
//  InterfaceController.m
//  BillPay WatchKit Extension
//
//  Created by Aanchal Arora on 22/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "InterfaceController.h"
#import "ServiceItem.h"
#import "MainRowType.h"
#import "AccountItem.h"
#import "GlanceInterfaceController.h"

@interface InterfaceController()

@property NSArray *rowLabels;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    
    self.rowLabels = [[NSArray alloc]initWithObjects:@"My Account", @"Bill Payment", nil];
    [self.mainTable setNumberOfRows:self.rowLabels.count withRowType:@"MainRowType"];
    for (int i=0; i<self.rowLabels.count; i++) {
        MainRowType *row = [self.mainTable rowControllerAtIndex:i];
        [row.rowLabel setText:self.rowLabels[i]];
    }
    
//    ServiceItem *item1 = [[ServiceItem alloc]initWithserviceName:@"Electricity" companyImage:@"msedcl.png" billAmount:220 billNumber:@"XXXX-XXXX-XXXX-6467"];
//    ServiceItem *item2 = [[ServiceItem alloc]initWithserviceName:@"Water" companyImage:@"Indiawater.png" billAmount:100 billNumber:@"XXXX-XXXX-XXXX-7799"];
//    ServiceItem *item3 = [[ServiceItem alloc]initWithserviceName:@"Internet" companyImage:@"airtel.png" billAmount:650 billNumber:@"XXXX-XXXX-XXXX-7643"];
//    ServiceItem *item4 = [[ServiceItem alloc]initWithserviceName:@"Credit card" companyImage:@"American_Express.png" billAmount:1500 billNumber:@"XXXX-XXXX-XXXX-8389"];
//    
//    
//    self.services = [NSMutableArray arrayWithObjects:item1, item2, item3, item4, nil];
//    
    
    
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

//- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)localNotification
//{
//
//    if([identifier isEqualToString:@"payBillsAction"])
//    {
//        NSLog(@"Pay bills");
//        //[self pushControllerWithName:@"PayBillsController" context:self.services];
//    }
//    else
//    {
//        exit(0);
//    }
//}

- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification
{

    if([identifier isEqualToString:@"payNowAction"])
    {
//        [self pushControllerWithName:@"PayAllBillsInterfaceController" context:remoteNotification];
        [self pushControllerWithName:@"PayBillsController" context:nil];
    }

    
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    if ([self.rowLabels[rowIndex] isEqualToString:@"My Account"]) {
        [self pushControllerWithName:@"AccountSummaryController" context:nil];
    }
    else if([self.rowLabels[rowIndex] isEqualToString:@"Bill Payment"]){
        [self pushControllerWithName:@"PayBillsController" context:nil];
    }
}

@end



