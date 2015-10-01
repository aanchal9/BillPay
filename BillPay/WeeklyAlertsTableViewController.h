//
//  WeeklyAlertsTableViewController.h
//  BillPay
//
//  Created by Aanchal Arora on 22/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeeklyAlertsTableViewController : UITableViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *alertSwitch;
@property (weak, nonatomic) IBOutlet UILabel *alertDayLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *dayPicker;


@end
