//
//  Owner.m
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/30/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import "Owner.h"

@implementation Owner

-(Owner *)initWithDictionary:(NSDictionary *)valueDetail
{
    self = [super init];
    if (self)
    {
        self.displayName = [valueDetail valueForKey:@"display_name"];
    }
    return self;
}

@end
