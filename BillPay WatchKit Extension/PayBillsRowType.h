//
//  PayBillsRowType.h
//  BillPay
//
//  Created by Aanchal Arora on 26/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface PayBillsRowType : NSObject

@property (weak, nonatomic) IBOutlet WKInterfaceImage *companyImage;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label1;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label2;


@end
