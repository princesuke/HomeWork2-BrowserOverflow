//
//  HWViewController.m
//  HomeWork2-BrowserOverflow
//
//  Created by Mobile's iMac on 1/28/2557 BE.
//  Copyright (c) 2557 Jirat K. All rights reserved.
//

#import "HWViewController.h"


@interface HWViewController ()

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
    
	NSString *responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
//    
//	if ([responseString isEqualToString:@""Unable to find specified resource.""]) {
//		NSLog(@"Unable to find specified resource.n");
//	} else {
//		NSDictionary *dictionary = [responseString JSONValue];
//		self.someVariable = [dictionary valueForKey:@"somekey"];
//	}

    NSLog(@"%@ bb",responseString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
