//
//  PayBillsViewController.m
//  BillPay
//
//  Created by Aanchal Arora on 13/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "PayBillsViewController.h"
#import "BillItemTableViewCell.h"
#import "AccountSummaryViewController.h"
#import "AppDelegate.h"

@interface PayBillsViewController ()

@end

@implementation PayBillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchBillsArray];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.bills.count == 0) {

        UIAlertController *alert =   [UIAlertController
                                      alertControllerWithTitle:@"No bills to pay"
                                      message:nil
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bills.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BillItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillItemTableViewCell"];
    cell.companyImage.image = ((ServiceItem *)self.bills[indexPath.row]).serviceImage;
    cell.serviceNameLabel.text = ((ServiceItem *)self.bills[indexPath.row]).serviceName;
    cell.billNumberLabel.text = ((ServiceItem *)self.bills[indexPath.row]).billNumber;
    cell.billAmountLabel.text = [NSString stringWithFormat:@"%.2f", ((ServiceItem *)self.bills[indexPath.row]).billAmount];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}


- (BOOL)paidBill:(ServiceItem *)bill withAccount:(AccountItem *)account
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://billpay.eu-gb.mybluemix.net/updateBill/%@/%@",bill.billNumber,account.accountNumber]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";

    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSLog(@"%@",error.description);
        return NO;
    }
    else {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        if ((bool)[responseDict valueForKey:@"ok"] == true) {
            [self.bills removeObject:bill];
            [self.billsTable reloadData];
            return YES;
        }
        else {
            return NO;
        }
    }
    
}

-(BOOL)paidAllBillsOfAmount:(NSNumber *)amount withAccount:(AccountItem *)account
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://billpay.eu-gb.mybluemix.net/updateAllBills/%f/%@",amount.floatValue,account.accountNumber]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSLog(@"%@",error.description);
        return NO;
    }
    else {
        NSString *balance = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        NSUserDefaults *myDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.ibm.test1"];
        AccountItem *item = [NSKeyedUnarchiver unarchiveObjectWithData:[myDefaults valueForKey:@"defaultAccount"]];
        item.balance = balance.doubleValue;
        return YES;
    }
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    Get the new view controller using [segue destinationViewController].
//    Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"pushAccounts"]) {
        AccountSummaryViewController *nextController = [segue destinationViewController];
        nextController.delegate = self;
        nextController.billToPay = self.bills[[self.billsTable indexPathForSelectedRow].row];
        
    }
}


- (NSMutableArray*)fetchBillsArray
{
    
    self.bills = [NSMutableArray array];
    
    NSURL *url = [NSURL URLWithString:@"http://billpay.eu-gb.mybluemix.net/bill"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    NSMutableArray *billsArray = [responseDict valueForKey:@"bills"];
    NSMutableArray *imageArray = [responseDict valueForKey:@"images"];
    for (int i=0; i < billsArray.count; i++) {
       
        NSData *imageData = [[NSData alloc]initWithBase64EncodedString:[imageArray[i] valueForKey:@"data"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image = [UIImage imageWithData:imageData];
        
        ServiceItem *bill = [[ServiceItem alloc]initWithserviceName:[billsArray[i] valueForKey:@"name"] serviceImage:image billAmount:((NSNumber *)[billsArray[i] valueForKey:@"amount"]).doubleValue billNumber:[billsArray[i] valueForKey:@"billno"]];
        [self.bills addObject:bill];
    }
    
    return self.bills;
}

- (UIImage *)fetchImages {
    NSURL *url = [NSURL URLWithString:@"http://billpay.eu-gb.mybluemix.net/images"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == nil) {
        NSDictionary *images = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@", images);
        NSData *imageData = [[NSData alloc]initWithBase64EncodedString:[((NSDictionary *)[images valueForKey:@"msedcl.png"]) valueForKey:@"data"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image = [UIImage imageWithData:imageData];
        return image;
    }
    else {
        NSLog(@"%@",error.description);
        return nil;
    }
}

@end
