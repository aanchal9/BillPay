//
//  TransactionItem.m
//  BillPay
//
//  Created by Aanchal Arora on 13/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "TransactionItem.h"

@implementation TransactionItem

- (instancetype)initWithtransactionType:(NSString *)transactionType transactionDate:(NSString *)transactionDate transactionAmount:(double)transactionAmount
{
    self = [super init];
    if (self) {
        self.transactionType = transactionType;
        self.transactionDate = transactionDate;
        self.transactionAmount = transactionAmount;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithtransactionType:nil transactionDate:nil transactionAmount:0];
}


@end
