//
//  DebitAndCreditAlertTableViewController.h
//  BillPay
//
//  Created by Aanchal Arora on 22/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebitAndCreditAlertTableViewController : UITableViewController<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UISwitch *debitAlertSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *creditAlertSwitch;
@property (weak, nonatomic) IBOutlet UILabel *minimumAmountLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *amountPicker;

@property (strong, nonatomic) NSMutableArray *amounts;

@end
