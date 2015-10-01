//
//  PayBillsViewController.h
//  BillPay
//
//  Created by Aanchal Arora on 13/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceItem.h"
#import "AccountSummaryViewController.h"


@interface PayBillsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, AccountSummaryDelegate>

@property (weak, nonatomic) IBOutlet UITableView *billsTable;
@property  NSMutableArray *bills;

- (BOOL)paidBill:(ServiceItem *)bill withAccount:(AccountItem *)account;
- (BOOL)paidAllBillsOfAmount:(NSNumber *)amount withAccount:(AccountItem *)account;
-(NSMutableArray *)fetchBillsArray;

@end
