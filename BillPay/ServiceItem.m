//
//  ServiceItem.m
//  WatchNotifications
//
//  Created by Aanchal Arora on 22/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import "ServiceItem.h"

@implementation ServiceItem

- (instancetype)initWithserviceName:(NSString *)serviceName serviceImage:(UIImage *)serviceImage billAmount:(double)billAmount billNumber:(NSString *)billNumber
{
    self = [super init];
    if (self) {
        self.serviceName = serviceName;
        self.serviceImage = serviceImage;
        self.billAmount = billAmount;
        self.billNumber = billNumber;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithserviceName:nil serviceImage:nil billAmount:0 billNumber:nil];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.serviceName forKey:@"serviceName"];
    [aCoder encodeObject:self.serviceImage forKey:@"serviceImage"];
    [aCoder encodeObject:self.billNumber forKey:@"billNumber"];
    [aCoder encodeDouble:self.billAmount forKey:@"billAmount"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.serviceName = [aDecoder decodeObjectForKey:@"serviceName"];
    self.serviceImage = [aDecoder decodeObjectForKey:@"serviceImage"];
    self.billNumber = [aDecoder decodeObjectForKey:@"billNumber"];
    self.billAmount = [aDecoder decodeDoubleForKey:@"billAmount"];
    return self;
}

@end
