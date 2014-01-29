//
//  HWViewController.m
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/28/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import "HWViewController.h"


@interface HWViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HWViewController

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
    // Do any additional setup after loading the view from its nib.
    _responseData = [[NSMutableData data] init];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.stackoverflow.com/1.1/questions"]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [connection start];
    
    _questionsTable.dataSource=self;
    _questionsTable.delegate=self;
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[_responseData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//	label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//	[connection release];
    
    
//	NSString *responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    
//    NSDictionary *responseDictionary = [NSPropertyListSerialization propertyListFromData:_responseData mutabilityOption:NSPropertyListImmutable format:nil errorDescription:nil];
    
    
    //
//	if ([responseString isEqualToString:@""Unable to find specified resource.""]) {
//		NSLog(@"Unable to find specified resource.n");
//	} else {
//		NSDictionary *dictionary = [responseString JSONValue];
//		self.someVariable = [dictionary valueForKey:@"somekey"];
//	}

    //NSLog(@"%@ bb",responseString);
    
    NSError *e;
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&e];
    
    //NSLog(@"Object: %@", object);
    
  //  [_questionsData addObject:];
    _total = [[object objectForKey:@"total"] intValue];
    _page = [[object objectForKey:@"page"] intValue];
    _pageSize = [[object objectForKey:@"pagesize"] intValue];
    _questions = [object objectForKey:@"questions"];
//    for(int i=0;i <[[object objectForKey:@"questions"] count];i++)
//    {
//        [_questions addObject:object[i]];
//    }
    
   // NSLog(@"%i",);
//
    [_questionsTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _questions.count;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *temp = _questions[indexPath.row];
//    cell.textLabel.text = [[temp valueForKeyPath:@"owner.user_id"] stringValue];
    
    NSString *tempScore = [[temp valueForKeyPath:@"view_count"] stringValue];
    NSString *tempAnswerCount = [[temp valueForKeyPath:@"answer_count"] stringValue];
    NSString *tempViewCount = [[temp valueForKeyPath:@"view_count"] stringValue];
    
//    nsa tempTags = [[temp valueForKeyPath:@"tags"] count];
   // NSLog(@"%@",[temp valueForKeyPath:@"tags"]);
    
    NSString *tempSubtitle = [NSString stringWithFormat:@"vote:%@  answer:%@  views:%@",tempScore ,tempAnswerCount, tempViewCount];
    
    cell.textLabel.text = [temp valueForKeyPath:@"title"];
    cell.detailTextLabel.text = tempSubtitle;
    cell.detailTextLabel.numberOfLines = 2;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)refresh:(id)sender
{
    [_questionsTable reloadData];
}

@end
