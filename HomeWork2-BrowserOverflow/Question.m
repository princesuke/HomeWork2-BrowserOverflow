//
//  Question.m
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/30/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import "Question.h"

@implementation Question

-initWithDictionary:(NSDictionary *)valueDetail
{
    NSString *title = [valueDetail valueForKey:@"title"];
    return self.title;
}

@end
