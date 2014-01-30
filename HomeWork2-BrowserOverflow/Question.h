//
//  Question.h
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/30/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Owner.h"
//@class Owner;

@interface Question : NSObject

@property (strong, nonatomic) NSString *title;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger answerCount;
@property (nonatomic, assign) NSInteger viewCount;

@property (strong, nonatomic) NSMutableArray *tags;

@property (strong, nonatomic) Owner * ownerDetail;

-(Question *)initWithDictionary:(NSDictionary *)valueDetail;

@end
