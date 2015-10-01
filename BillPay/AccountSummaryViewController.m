//
//  AccountSummaryViewController.m
//  BillPay
//
//  Created by Aanchal Arora on 13/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "AccountSummaryViewController.h"
#import "AccountItem.h"
#import "AccountTableViewCell.h"
#import "SettingsTableViewController.h"
#import "PayBillsViewController.h"

@interface AccountSummaryViewController ()<UIAlertViewDelegate>

@end

@implementation AccountSummaryViewController

- (id)init {
    self = [super init];
    if (self) {
        
        self.accountItems = [NSMutableArray array];
    
        NSURL *url = [NSURL URLWithString:@"http://billpay.eu-gb.mybluemix.net/accounts"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
        request.HTTPMethod = @"GET";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
        NSURLResponse *response;
        NSError *error;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSMutableArray *accountsArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    
        for (NSDictionary *item in accountsArray) {
    
            AccountItem *account = [[AccountItem alloc]initWithaccountType:[item valueForKey:@"accountType"] accountNumber:[item valueForKey:@"accountNumber"] branchName:[item valueForKey:@"branch"] balance:((NSNumber *)[item valueForKey:@"balance"]).doubleValue defaultAccount:((NSString *)[item valueForKey:@"defaultAccount"]).boolValue];
            [self.accountItems addObject:account];
            
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchAllAccounts];
    // Do any additional setup after loading the view.
    
    for (AccountItem *item in self.accountItems) {
        if (item.defaultAccount == YES) {
            NSData *defaultAccount = [NSKeyedArchiver archivedDataWithRootObject:item];
            NSUserDefaults *myDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.ibm.test1"];
            
            [myDefaults setObject:defaultAccount forKey:@"defaultAccount"];
            
        }
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.accountItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountTableViewCell"];

    
    cell.accountTypeLabel.text = ((AccountItem *)self.accountItems[indexPath.row]).accountType;
    cell.accountNumberLabel.text = ((AccountItem *)self.accountItems[indexPath.row]).accountNumber;
    cell.branchNameLabel.text = ((AccountItem *)self.accountItems[indexPath.row]).branchName;
    cell.accountBalanceLabel.text = [NSString stringWithFormat:@"%.2f", ((AccountItem *)self.accountItems[indexPath.row]).balance];
    if (((AccountItem *)self.accountItems[indexPath.row]).defaultAccount == YES) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    long selfIndex = ([self.navigationController viewControllers].count)-1;
    
    if ([[[self.navigationController viewControllers] objectAtIndex:(selfIndex-1)] isKindOfClass:[PayBillsViewController class]]){
        
        UIAlertController *paymentAlert = [UIAlertController alertControllerWithTitle:@"Payment Confirmation" message:[NSString stringWithFormat:@"Are you sure you want to pay %.2f for %@ from %@?", self.billToPay.billAmount, self.billToPay.serviceName, ((AccountItem *)self.accountItems[indexPath.row]).accountType] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesAction = [UIAlertAction
                             actionWithTitle:@"Yes"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 if ([self.delegate paidBill:self.billToPay withAccount:self.accountItems[indexPath.row]] == YES) {
                                     UIAlertController *confirmAlert = [UIAlertController alertControllerWithTitle:@"Payment Done" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                                {
                                                                    
                                                                    [self.navigationController popViewControllerAnimated:YES];
                                                                }];
                                     [confirmAlert addAction:okAction];
                                     [self presentViewController:confirmAlert animated:YES completion:nil];
                                 }
                                 else {
                                     UIAlertController *confirmAlert = [UIAlertController alertControllerWithTitle:@"Payment Not Done. Please Try Again." message:nil preferredStyle:UIAlertControllerStyleAlert];
                                     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                                {
                                                                    
                                                                    [self.navigationController popViewControllerAnimated:YES];
                                                                }];
                                     [confirmAlert addAction:okAction];
                                     [self presentViewController:confirmAlert animated:YES completion:nil];
                                 }
                                 
                                 
                             }];
        [paymentAlert addAction:yesAction];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
        [paymentAlert addAction:noAction];
        [self presentViewController:paymentAlert animated:YES completion:nil];
    }
    else if ([[[self.navigationController viewControllers] objectAtIndex:(selfIndex-1)] isKindOfClass:[SettingsTableViewController class]]) {
        
            UIAlertController *defaultAccountAlert = [UIAlertController alertControllerWithTitle:@"Default Account" message:@"Do you want to set this account as the Default Account?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yesAction = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                        for (NSIndexPath *index in [tableView indexPathsForVisibleRows]) {
                                            
                                            [tableView cellForRowAtIndexPath:index].accessoryType = UITableViewCellAccessoryNone;
                                            ((AccountItem *)self.accountItems[index.row]).defaultAccount = NO;
                                        };
                                        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
                                        
                                        ((AccountItem *)self.accountItems[indexPath.row]).defaultAccount = YES;
                                        
                                        [self setDefaultAccount:((AccountItem *)self.accountItems[indexPath.row])];
                                        NSData *defaultAccount = [NSKeyedArchiver archivedDataWithRootObject:self.accountItems[indexPath.row]];
                                        
                                        NSUserDefaults *myDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.ibm.test1"];
                                        [myDefaults setObject:defaultAccount forKey:@"defaultAccount"];

                                        
                                    }];
        [defaultAccountAlert addAction:yesAction];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
        [defaultAccountAlert addAction:noAction];
            [self presentViewController:defaultAccountAlert animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (NSMutableArray*)fetchAllAccounts
{
    
    self.accountItems = [NSMutableArray array];
    
    NSURL *url = [NSURL URLWithString:@"http://billpay.eu-gb.mybluemix.net/accounts"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error != nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No accounts" message:@"PLease try again!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return nil;
    }
    else {
        NSMutableArray *accountsArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    
        for (NSDictionary *item in accountsArray) {
        
        AccountItem *account = [[AccountItem alloc]initWithaccountType:[item valueForKey:@"accountType"] accountNumber:[item valueForKey:@"accountNumber"] branchName:[item valueForKey:@"branch"] balance:((NSNumber *)[item valueForKey:@"balance"]).doubleValue defaultAccount:((NSString *)[item valueForKey:@"defaultAccount"]).boolValue];
        [self.accountItems addObject:account];
        
        }
    
        return self.accountItems;
    }
}

-(void)setDefaultAccount:(AccountItem *)account {
    
    NSURL *url = [NSURL URLWithString:[NSString  stringWithFormat:@"http://billpay.eu-gb.mybluemix.net/defaultAccount/%@",account.accountNumber]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == nil) {
        NSMutableDictionary *accountStatus = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        if((bool)[accountStatus valueForKey:@"ok"] == true)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Default Account set" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Default Account could not be set. Please Try Again!" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    else {
        NSLog(@"%@",error.description);
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
