//
//  Answer.h
//  HomeWork2-BrowserOverflow
//
//  Created by WORAWIT NAWARITLOHA on 2/6/14.
//  Copyright (c) 2014 Jirat K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Owner.h"

@interface Answer : NSObject

@property (nonatomic, assign) NSInteger answerId;
@property (nonatomic, assign) BOOL accepted;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) Owner *ownerDetail;

-(Answer *)initWithDictionary:(NSDictionary *)valueDetail;

@end