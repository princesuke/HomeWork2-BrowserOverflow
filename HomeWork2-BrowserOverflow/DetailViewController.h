//
//  DetailViewController.h
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/30/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question;

@interface DetailViewController : UIViewController


@property (strong) NSURLConnection *detailConnection;
@property (strong) UIRefreshControl *detailRefreshControl;

@property (weak, nonatomic) IBOutlet UITableView *detailTable;
@property (copy, nonatomic) NSMutableData *detailResponseData;

@property (strong, nonatomic) Question *questionDetail;
@property (strong, nonatomic) NSMutableArray *answer;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionId;

@end
