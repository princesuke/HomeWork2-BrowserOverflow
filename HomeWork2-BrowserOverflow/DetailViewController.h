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

@property (strong, nonatomic) Question *questionDetail;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;

@end
