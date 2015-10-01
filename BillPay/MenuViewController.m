//
//  MenuViewController.m
//  BillPay
//
//  Created by Aanchal Arora on 18/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSDictionary *menuItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.menuItems = [[NSDictionary alloc]initWithObjectsAndKeys:@"AccountSummaryViewController", @"My Accounts", @"TransactionHistoryTableViewController", @"Transaction History", @"PayBillsViewController", @"Bill Payment", @"SettingsTableViewController", @"Settings", @"Logout", @"Logout", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.menuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuItemCell" forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.menuItems allKeys][indexPath.row]];

    if ([cell.textLabel.text isEqualToString:@"Logout"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.menuItems allKeys][indexPath.row] isEqualToString:@"Logout"]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else{
    UIViewController *nextController = [self.storyboard instantiateViewControllerWithIdentifier:[self.menuItems allValues][indexPath.row]];
    [self.navigationController pushViewController:nextController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
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
