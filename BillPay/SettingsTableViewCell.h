//
//  SettingsTableViewCell.h
//  BillPay
//
//  Created by Aanchal Arora on 14/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsTableViewCell;

@protocol SettingsDelegate <NSObject>

- (void)update:(SettingsTableViewCell *)cell;

@end

@interface SettingsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
@property id<SettingsDelegate> delegate;

- (IBAction)switchToggled:(id)sender;


@end
