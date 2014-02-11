//
//  HWViewController.m
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/28/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import "HWViewController.h"
#import "DetailViewController.h"
#import "Question.h"
#import "Owner.h"

@interface HWViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

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
    
    _searchBar.showsCancelButton = true;
    self.searchDisplayController.displaysSearchBarInNavigationBar = true;
    
    [self sendRequest:nil];

    _questionsTable.dataSource=self;
    _questionsTable.delegate=self;
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(sendRequest:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.tintColor = [UIColor greenColor];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(sendRequest:) forControlEvents:UIControlEventValueChanged];
    _refreshControl = refresh;
    [_questionsTable addSubview:refresh];

  
}

-(void)clearDataTabllView
{
    [_questions removeAllObjects];
    
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
    
    NSError *e;
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&e];

    _total = [[object objectForKey:@"total"] intValue];
    _page = [[object objectForKey:@"page"] intValue];
    _pageSize = [[object objectForKey:@"pagesize"] intValue];
    _questions = [object objectForKey:@"questions"];

    [_questionsTable reloadData];
    
    _connection=nil;
    _responseData=nil;
    
    [_refreshControl endRefreshing];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
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

-(void)sendRequest:(id)sender
{
    [self clearDataTabllView];
    
    //NSLog(@"%@",sender);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.stackoverflow.com/1.1/questions?body=true"]];
    
    _responseData = [[NSMutableData data] init];
    _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [_questionsTable reloadData];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

-(void)sendSearchRequest:(id)sender
{
    [self clearDataTabllView];
    
    NSString * requestStringUrl  = [NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/search?intitle=%@",sender];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestStringUrl]];
    
    _responseData = [[NSMutableData data] init];
    _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [_questionsTable reloadData];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary *temp = _questions[indexPath.row];
    
    Question *dataQuestion = [[Question alloc] initWithDictionary:temp];

    DetailViewController * detailVC = [[DetailViewController alloc] init];
    detailVC.questionDetail = dataQuestion;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma searchBar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
//     [self handleSearch:searchBar];
  //  NSLog(@"aaaa %@", searchBar.text);
     //[self.view endEditing:YES];
    [self sendSearchRequest:searchBar.text];
    [_searchBar resignFirstResponder];

}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//      NSLog(@"bbb %@", searchBar.text);
//    [self handleSearch:searchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
//    [self se:@"aaa"];
    
//    NSLog(@"User searched for %@", searchBar.text);
//     [searchBar resignFirstResponder]; // if you want the keyboard to go away
    
//    [self sendSearchRequest:searchBar.text];
//      [self.view endEditing:YES];
}

- (void)searchBarCancelButtondsdClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

//     [_searchBar resignFirstResponder];
//    [self.view endEditing:YES];
    [_searchBar resignFirstResponder];
}

@end
