//
//  TransactionItem.h
//  BillPay
//
//  Created by Aanchal Arora on 13/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionItem : NSObject

@property NSString *transactionType;
@property NSString *transactionDate;
@property double transactionAmount;

- (instancetype)initWithtransactionType:(NSString *)transactionType transactionDate:(NSString *)transactionDate transactionAmount:(double)transactionAmount;

@end
