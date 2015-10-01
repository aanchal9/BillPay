//
//  SettingsTableViewCell.m
//  BillPay
//
//  Created by Aanchal Arora on 14/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "SettingsTableViewCell.h"

@implementation SettingsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchToggled:(id)sender {
    
    if ([self.toggleSwitch isOn] ) {
        
        self.subtitleLabel.hidden = NO;
        [self.delegate update:self];
                
    }
    else{
        self.subtitleLabel.hidden = YES;
    }
}
@end
