//
//  Question.m
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/30/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import "Question.h"
#import "Owner.h"

@implementation Question


-(Question *)initWithDictionary:(NSDictionary *)valueDetail
{
    self = [super init];
    if (self) {
        NSString *title = [valueDetail valueForKey:@"title"];
        self.title = title;
        self.ownerDetail = [[Owner alloc] initWithDictionary:[valueDetail valueForKey:@"owner"]];
    }
    return self;
}


@end
