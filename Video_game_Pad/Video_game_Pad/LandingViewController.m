//
//  LandingViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-8.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "LandingViewController.h"

@interface LandingViewController ()

@end

@implementation LandingViewController

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
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(viewDisappear)];
    [self.navigationItem setRightBarButtonItem:bar];
    [bar release];
    [self.view setBackgroundColor:[UIColor grayColor]];
    self.navigationItem.title = @"登陆";
    
    
    
    
}
//界面消失
-(void)viewDisappear
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
