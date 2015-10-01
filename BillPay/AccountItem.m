//
//  AccountItem.m
//  BillPay
//
//  Created by Aanchal Arora on 05/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "AccountItem.h"

@implementation AccountItem

- (instancetype)initWithaccountType:(NSString *)accountType accountNumber:(NSString *)accountNumber branchName:(NSString *)branchName balance:(double)balance defaultAccount:(BOOL)defaultAccount
{
    self = [super init];
    if (self) {
        self.accountType = accountType;
        self.accountNumber = accountNumber;
        self.branchName = branchName;
        self.balance = balance;
        self.defaultAccount = defaultAccount;
    }
    return self;
}

- (instancetype)init
{
    
    return [self initWithaccountType:nil accountNumber:nil branchName:nil balance:0 defaultAccount:NO];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.accountType forKey:@"accountType"];
    [aCoder encodeObject:self.accountNumber forKey:@"accountNumber"];
    [aCoder encodeObject:self.branchName forKey:@"branchName"];
    [aCoder encodeDouble:self.balance forKey:@"balance"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.accountType = [aDecoder decodeObjectForKey:@"accountType"];
    self.accountNumber = [aDecoder decodeObjectForKey:@"accountNumber"];
    self.branchName = [aDecoder decodeObjectForKey:@"branchName"];
    self.balance = [aDecoder decodeDoubleForKey:@"balance"];
    return self;
}

@end
