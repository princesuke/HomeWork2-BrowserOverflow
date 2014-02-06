//
//  DetailViewController.m
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/30/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import "DetailViewController.h"
#import "Question.h"
#import "Owner.h"
#import "Answer.h"

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>


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
    
    if(_questionDetail.answerCount > 0){
        [self sendRequest:nil];
    }
    
    _detailTable.dataSource=self;
    _detailTable.delegate=self;

    NSString * tagsText;

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
        tagsText = [NSString stringWithFormat:@"tags: %@",tagsText];
    }
  
    // Do any additional setup after loading the view from its nib.
    
    _titleLabel.text = _questionDetail.title;
    _questionId.text = [NSString stringWithFormat:@"question id: %d",_questionDetail.questionId];
    _ownerLabel.text = [NSString stringWithFormat:@"owner: %@",_questionDetail.ownerDetail.displayName];
    _tagsLabel.text = tagsText;
    _bodyLabel.text = _questionDetail.body;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clearDataTabllView
{
    [_answer removeAllObjects];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[_detailResponseData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_detailResponseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSError *e;
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:_detailResponseData options:NSJSONReadingMutableContainers error:&e];

    _answer = [object objectForKey:@"answers"];

    [_detailTable reloadData];

    _detailConnection=nil;
    _detailResponseData=nil;

//    [_refreshControl endRefreshing];
  }


-(void)sendRequest:(id)sender
{
    [self clearDataTabllView];
    
    NSString * requestStringUrl  = [NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/questions/%d/answers?body=true&sort=votes",_questionDetail.questionId];
    
    NSURLRequest *detailRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:requestStringUrl]];
    
    _detailResponseData = [[NSMutableData data] init];
    _detailConnection = [NSURLConnection connectionWithRequest:detailRequest delegate:self];
    
    [_detailTable reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _answer.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
        NSDictionary *temp = _answer[indexPath.row];
        cell.textLabel.text = [temp valueForKeyPath:@"body"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"owner: %@",[temp valueForKeyPath:@"owner.display_name"]];
        cell.detailTextLabel.numberOfLines = 2;
    
    return cell;
}

@end
