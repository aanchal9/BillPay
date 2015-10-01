//
//  ServiceItem.h
//  WatchNotifications
//
//  Created by Aanchal Arora on 22/04/15.
//  Copyright (c) 2015 Aanchal Arora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ServiceItem : NSObject<NSCoding>

@property NSString *serviceName;
@property UIImage *serviceImage;
@property double billAmount;
@property NSString *billNumber;

- (instancetype)initWithserviceName:(NSString *)serviceName serviceImage:(UIImage *)serviceImage billAmount:(double)billAmount billNumber:(NSString *)billNumber;

@end
