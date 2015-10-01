//
//  AppDelegate.m
//  BillPay
//
//  Created by Aanchal Arora on 22/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "AppDelegate.h"
#import "ServiceItem.h"
#import "PayBillsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:125.0/255.0 blue:91.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    
    // Override point for customization after application launch.
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"%@",notification);
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
    if ([userInfo[@"request"] isEqualToString:@"getBillsToPay"]) {
        
        PayBillsViewController *billsController = [[PayBillsViewController alloc]init];
        NSMutableArray *billsArray = [billsController fetchBillsArray];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:billsArray];
        NSDictionary *dict = @{ @"bills" : data };
        reply(dict);
    }
    else if ([userInfo[@"request"] isEqualToString:@"payBills"]) {

        NSUserDefaults *myDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.ibm.test1"];
        NSData *data = [myDefaults valueForKey:@"defaultAccount"];
        AccountItem *account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        PayBillsViewController *billsController = [[PayBillsViewController alloc]init];
        if([billsController paidAllBillsOfAmount:userInfo[@"sum"] withAccount:account] == YES){
            reply(@{@"done" : @"yes"});
        }
        else {
            reply(@{@"done" : @"no"});
        }
    }
    else if ([userInfo[@"request"] isEqualToString:@"accountInfo"]) {
        
        AccountSummaryViewController *accountSummaryController = [[AccountSummaryViewController alloc]init];
        for( AccountItem *item in accountSummaryController.accountItems){
            if ([userInfo[@"accountNumber"] isEqualToString:item.accountNumber]) {
                
                reply(@{ @"balance" : [NSNumber numberWithDouble:item.balance]});
            }
        }
        
    }
}
@end
