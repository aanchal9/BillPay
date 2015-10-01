//
//  AccountItem.h
//  BillPay
//
//  Created by Aanchal Arora on 05/05/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountItem : NSObject<NSCoding>

@property NSString *accountType;
@property NSString *accountNumber;
@property NSString *branchName;
@property double balance;
@property (getter = isDefaultAccount)BOOL defaultAccount;

- (instancetype)initWithaccountType:(NSString *)accountType accountNumber:(NSString *)accountNumber branchName:(NSString *)branchName balance:(double)balance defaultAccount:(BOOL)defaultAccount;

@end
