//
//  BillItemTableViewCell.h
//  BillPay
//
//  Created by Aanchal Arora on 13/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *companyImage;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *billNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *billAmountLabel;

@end
