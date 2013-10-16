//
//  MovieDetailViewController.m
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-9-30.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"
@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController
//- (void)dealloc
//{
//    //[web release];
//    self.detailDic = nil;
//    self.requestIdStr = nil;
//    [super dealloc];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 600)] autorelease];
    self.view.backgroundColor = [UIColor yellowColor];
       
    
    web = [[UIWebView alloc] initWithFrame:CGRectMake(10, 20, 400, 400)];
    web.backgroundColor = [UIColor redColor];
    web.delegate = self;
    web.scalesPageToFit = YES;
    [self.view addSubview:web];

    NSURLRequest *detailRequest =
    [NSURLRequest requestWithURL:nil cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    
    


   // [web loadRequest:detailRequest];

    
    
    
    
    
    
    
    
    
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
-(void)hide
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:nil];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
