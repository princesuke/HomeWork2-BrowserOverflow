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
        _tags = [valueDetail valueForKey:@"tags"];
        _title = [valueDetail valueForKey:@"title"];
        _body = [valueDetail valueForKey:@"body"];
        
        _questionId = [[valueDetail valueForKey:@"question_id"] integerValue];
        _answerCount = [[valueDetail valueForKey:@"answer_count"] integerValue];
        _ownerDetail = [[Owner alloc] initWithDictionary:[valueDetail valueForKey:@"owner"]];
    }
    return self;
}


@end
