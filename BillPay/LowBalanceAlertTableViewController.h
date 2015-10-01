//
//  LowBalanceAlertTableViewController.h
//  BillPay
//
//  Created by Aanchal Arora on 21/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LowBalanceAlertTableViewController : UITableViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *alertSwitch;

@property (weak, nonatomic) IBOutlet UILabel *minBalance;
@property (weak, nonatomic) IBOutlet UIPickerView *amountPicker;
@property (strong) NSMutableArray *amounts;

@end
