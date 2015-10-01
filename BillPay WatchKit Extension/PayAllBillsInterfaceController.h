//
//  PayAllBillsInterfaceController.h
//  BillPay
//
//  Created by Aanchal Arora on 04/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface PayAllBillsInterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *cumulativeAmountLabel;
@property (strong,nonatomic) NSNumber *cumulative;
@end
