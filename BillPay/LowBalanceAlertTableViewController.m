//
//  LowBalanceAlertTableViewController.m
//  BillPay
//
//  Created by Aanchal Arora on 21/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "LowBalanceAlertTableViewController.h"

@implementation LowBalanceAlertTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.amounts = [[NSMutableArray alloc]init];
    int idx = 0;
    for (int i = 20; i < 1000; i+=20) {
        self.amounts[idx++] = [NSString stringWithFormat:@"$ %d",i];
    }
    
    self.amountPicker.userInteractionEnabled = NO;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.amounts.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.amounts[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.minBalance.textColor = [UIColor blackColor];
    self.minBalance.text = self.amounts[row];
}
- (IBAction)switchToggled:(id)sender {
    
    if (self.alertSwitch.on == YES) {
        self.amountPicker.userInteractionEnabled = YES;
    }
    else {
        self.amountPicker.userInteractionEnabled = NO;
        self.minBalance.textColor = [UIColor lightGrayColor];
        self.minBalance.text = @"Choose";

    }
}


@end
