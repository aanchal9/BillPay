//
//  GlanceInterfaceController.h
//  BillPay
//
//  Created by Aanchal Arora on 04/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface GlanceInterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *accountTypeLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *infoLabel;

@end
