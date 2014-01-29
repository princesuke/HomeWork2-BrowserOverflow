//
//  HWViewController.h
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/28/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *questionsTable;
@property (copy, nonatomic) NSMutableData *responseData;

@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (copy, nonatomic) NSMutableArray *questions;

@end

