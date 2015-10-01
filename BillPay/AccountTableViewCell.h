//
//  AccountTableViewCell.h
//  BillPay
//
//  Created by Aanchal Arora on 13/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *accountTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *branchNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountBalanceLabel;

@end
