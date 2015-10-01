//
//  NotificationController.m
//  BillPay WatchKit Extension
//
//  Created by Aanchal Arora on 22/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController()

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    
    NSLog(@"%@",localNotification);
    // This method is called when a local notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}


- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a remote notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    
    NSDictionary* apsDict = [remoteNotification objectForKey:@"aps"];
    NSDictionary* alertDict = [apsDict objectForKey:@"alert"];
    NSString* titleString = [alertDict objectForKey:@"title"];
    NSMutableString *items = [[NSMutableString alloc]init];
    NSString *item = [[NSString alloc]init];
    [self.titleLabel setText:titleString];
    NSArray *body = [alertDict objectForKey:@"body"];
    
    for (NSDictionary *service in body) {
        item = [NSString stringWithFormat:@"%@ : %@\n",[service valueForKey:@"item"],[service valueForKey:@"amount"]];
        [items appendString:item];
    }
    [self.detailLabel setText:items];

    
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}

@end



