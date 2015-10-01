//
//  AccountSummaryViewController.h
//  BillPay
//
//  Created by Aanchal Arora on 13/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceItem.h"
#import "AccountItem.h"

@protocol AccountSummaryDelegate <NSObject>

@optional
- (BOOL)paidBill:(ServiceItem *)bill withAccount:(AccountItem *)account;
- (void)setDefaultAccount:(AccountItem *)account;

@end

@interface AccountSummaryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *accountItemsTableView;
@property (strong, nonatomic) ServiceItem *billToPay;
@property id<AccountSummaryDelegate> delegate;
@property NSMutableArray *accountItems;

- (NSMutableArray*)fetchAllAccounts;
- (void)setDefaultAccount:(AccountItem *)account;

@end
