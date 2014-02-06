//
//  Answer.m
//  HomeWork2-BrowserOverflow
//
//  Created by WORAWIT NAWARITLOHA on 2/6/14.
//  Copyright (c) 2014 Jirat K. All rights reserved.
//

#import "Answer.h"

@implementation Answer

-(Answer *)initWithDictionary:(NSDictionary *)valueDetail
{
    self = [super init];
    if (self) {
        _answerId = [[valueDetail valueForKey:@"answer_id"] integerValue];
        _body = [valueDetail valueForKey:@"body"];
        _accepted = [[valueDetail valueForKey:@"accepted"] boolValue];
        _ownerDetail = [[Owner alloc] initWithDictionary:[valueDetail valueForKey:@"owner"]];
    }
    return self;
}

@end