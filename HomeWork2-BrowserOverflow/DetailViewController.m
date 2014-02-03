//
//  DetailViewController.m
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/30/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import "DetailViewController.h"
#import "Question.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"title = %@ \n owner = %@",_questionDetail.title,_questionDetail.ownerDetail.displayName);
    NSString * tagsText;
    NSLog(@"%d",[_questionDetail.tags count]);
    for (NSInteger i=0;i<[_questionDetail.tags count];i++) {
        if(i==0)
        {
            tagsText = [NSString stringWithFormat:@"%@, ",_questionDetail.tags[i]];
        }else
        {
            tagsText = [NSString stringWithFormat:@"%@ %@, ",tagsText,_questionDetail.tags[i]];
        }
    }
    if ([tagsText length] > 0) {
        tagsText = [tagsText substringToIndex:[tagsText length] - 2];
        tagsText = [NSString stringWithFormat:@"tags:\n%@",tagsText];
    }
  
    // Do any additional setup after loading the view from its nib.
    
    _titleLabel.text = _questionDetail.title;
    _ownerLabel.text = [NSString stringWithFormat:@"Owner: %@",_questionDetail.ownerDetail.displayName];
    _tagsLabel.text = tagsText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
