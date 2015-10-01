//
//  TransactionHistoryTableViewController.m
//  BillPay
//
//  Created by Aanchal Arora on 13/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "TransactionHistoryTableViewController.h"
#import "TransactionItem.h"
#import "TransactionItemTableViewCell.h"

@interface TransactionHistoryTableViewController ()

@property NSArray *transactions;

@end

@implementation TransactionHistoryTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    TransactionItem *item1 = [[TransactionItem alloc]initWithtransactionType:@"Account Transfer" transactionDate:@"29/01/2014" transactionAmount:3000.00];
    TransactionItem *item2 = [[TransactionItem alloc]initWithtransactionType:@"Bill Payment" transactionDate:@"03/05/2014" transactionAmount:1000.00];
    TransactionItem *item3 = [[TransactionItem alloc]initWithtransactionType:@"Debit" transactionDate:@"29/11/2014" transactionAmount:500.00];
    TransactionItem *item4 = [[TransactionItem alloc]initWithtransactionType:@"Credit" transactionDate:@"15/06/2015" transactionAmount:1500.00];

    self.transactions = [[NSArray alloc]initWithObjects:item1, item2, item3, item4, nil];
    
    [self.tableView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 500)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section
    return self.transactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionItemTableViewCell" forIndexPath:indexPath];
    
    cell.transactionTypeLabel.text = ((TransactionItem *)self.transactions[indexPath.row]).transactionType;
    cell.transactionDateLabel.text = ((TransactionItem *)self.transactions[indexPath.row]).transactionDate;
    cell.transactionAmountLabel.text = [NSString stringWithFormat:@"%.2f", ((TransactionItem *)self.transactions[indexPath.row]).transactionAmount];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
