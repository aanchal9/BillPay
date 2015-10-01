//
//  MenuViewController.h
//  BillPay
//
//  Created by Aanchal Arora on 18/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTable;

@end
