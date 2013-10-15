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
- (void)dealloc
{
    self.detailDic = nil;
    self.requestIdStr = nil;
    [super dealloc];
}

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
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 600)];
    self.view.backgroundColor = [UIColor yellowColor];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    titleLab.text = @"紧张进行中";
    [titleLab setTextAlignment:NSTextAlignmentCenter];
    [titleLab setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:titleLab];
    [titleLab release];
    
    
    
    
    
    
    
    
    
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
