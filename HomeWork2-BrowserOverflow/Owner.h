//
//  Owner.h
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/30/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Owner : NSObject

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger reputation;

@property (strong, nonatomic) NSString *userType;
@property (strong,nonatomic) NSString *displayName;
@property (strong,nonatomic) NSString *emailHash;


-(Owner *)initWithDictionary:(NSDictionary *)valueDetail;

@end
