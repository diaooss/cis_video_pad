//
//  SearchViewController.m
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-8.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "SearchViewController.h"
#import "Tools_Header.h"
@interface SearchViewController ()

@end

@implementation SearchViewController
- (void)dealloc
{
    [searchBar release];
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
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view.backgroundColor = [UIColor grayColor];
    
    //搜索框
   searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 500, 44)];
    [searchBar setPlaceholder:@"视频/解说作者/游戏"];
    [searchBar setTag:100];
    searchBar.backgroundColor = [UIColor clearColor];
    [[searchBar.subviews objectAtIndex:0] setHidden:YES];
    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
    for (UIView *subview in searchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    [searchBar setTintColor:[UIColor clearColor]];
    [searchBar setBarStyle:UIBarStyleDefault];
    searchBar.delegate = self;
    //将搜索条放在一个UIView上
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(300, 0, 500, 44)];
    searchView.backgroundColor = [UIColor clearColor];
    [searchView addSubview:searchBar];
    self.navigationItem.titleView = searchView;
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 100, 44);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBar;
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    UILabel *hotSeachLab = [[UILabel alloc] initWithFrame:CGRectMake(200, 100, 100, 30)];
    hotSeachLab.text = @"热搜排行榜";
    hotSeachLab.backgroundColor = [UIColor clearColor];

    hotSeachLab.textColor = [UIColor yellowColor];
    [self.view addSubview:hotSeachLab];
    [hotSeachLab release];
    
    UILabel *moreLab = [[UILabel alloc] initWithFrame:CGRectMake(hotSeachLab.left+20, hotSeachLab.bottom+10, 100, 50)];
    moreLab.backgroundColor = [UIColor clearColor];
    moreLab.text = @"敬请期待...";
    [self.view addSubview:moreLab];
    [moreLab release];
    [searchBar becomeFirstResponder];
    
    
}
-(void)addAGeusterToBackKeyBord
{
    
}

-(void)tapBackGround
{
    [searchBar resignFirstResponder];
    
    
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    NSLog(@"???");
}
#pragma mark--触发搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    UIAlertView *tips = [[UIAlertView alloc] initWithTitle:@"😉紧张施工中..." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [tips show];
    [tips release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
