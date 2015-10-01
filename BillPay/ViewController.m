//
//  ViewController.m
//  BillPay
//
//  Created by Aanchal Arora on 22/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.passcodeTextField.text = @"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    
    if ([self.passcodeTextField.text isEqualToString:@""]) {
        UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"Login Failed" message:@"Please enter your 5 digit passcode" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [loginAlert addAction:Ok];
        [self presentViewController:loginAlert animated:YES completion:nil];
    }
    else if ([self.passcodeTextField.text isEqualToString:@"54321"]) {
        
        [self performSegueWithIdentifier:@"LoginToHomeSegue" sender:self ];
        
    }
    else {
        UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"Wrong Passcode" message:@"Please enter correct passcode" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [loginAlert addAction:Ok];
        [self presentViewController:loginAlert animated:YES completion:nil];
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if ([string intValue] || range.length == 1)
    {
            if (textField.text.length >= 5 && range.length == 0)
                return NO;
            else
                return YES;
    }
    return NO;
    
}
- (IBAction)forgotPasscode:(id)sender {
    
    UIAlertController *forgotPasscodeAlert = [UIAlertController alertControllerWithTitle:@"Forgot Passcode" message:@"A password reset email has been sent to your registered email-id." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [forgotPasscodeAlert addAction:Ok];
    [self presentViewController:forgotPasscodeAlert animated:YES completion:nil];
    
}

@end