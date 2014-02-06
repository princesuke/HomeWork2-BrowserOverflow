//
//  HWViewController.h
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/28/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWViewController : UIViewController

@property (strong) NSURLConnection *connection;
@property (strong) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UITableView *questionsTable;
@property (copy, nonatomic) NSMutableData *responseData;

@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (strong, nonatomic) NSMutableArray *questions;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

