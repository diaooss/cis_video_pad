//
//  SearchViewController.m
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-8.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultViewController.h"
#import "Tools_Header.h"
#define padding 20
@interface SearchViewController ()

@end

@implementation SearchViewController
- (void)dealloc
{
    [_searchBar release];
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
   _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 500, 44)];
    [_searchBar setPlaceholder:@"视频/解说作者/游戏"];
    [_searchBar setTag:100];
    _searchBar.backgroundColor = [UIColor clearColor];
    [[_searchBar.subviews objectAtIndex:0] setHidden:YES];
    [[_searchBar.subviews objectAtIndex:0] removeFromSuperview];
    for (UIView *subview in _searchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    [_searchBar setTintColor:[UIColor clearColor]];
    [_searchBar setBarStyle:UIBarStyleDefault];
    _searchBar.delegate = self;
    [_searchBar becomeFirstResponder];

    //将搜索条放在一个UIView上
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(300, 0, 500, 44)];
    searchView.backgroundColor = [UIColor clearColor];
    [searchView addSubview:_searchBar];
    self.navigationItem.titleView = searchView;
    /*/显示搜索内容/*/
    
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
    
    UILabel *hotSeachLab = [[UILabel alloc] initWithFrame:CGRectMake(230, 60, 100, 30)];
    hotSeachLab.text = @"热搜排行榜";
    hotSeachLab.backgroundColor = [UIColor clearColor];

    hotSeachLab.textColor = [UIColor yellowColor];
    [self.view addSubview:hotSeachLab];
    [hotSeachLab release];
    //生成标签
    for (int i = 0; i<5; i++) {
        UILabel *titilLab = [[UILabel alloc] initWithFrame:CGRectMake(hotSeachLab.left, padding+hotSeachLab.bottom+i*50, 80, 30)];
        titilLab.backgroundColor = [UIColor yellowColor];
        [titilLab setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:titilLab];
        [titilLab release];
        if (i==0) {
            [titilLab setText:@"Dota"];
        }
        if (i==1) {
            [titilLab setText:@"英雄联盟"];
        }
        if (i==2) {
            [titilLab setText:@"Dota2"];
        }
        if (i==3) {
            [titilLab setText:@"星际争霸2"];
        }
        if (i==4) {
            [titilLab setText:@"魔兽世界"];
        }
    }
    for (int i = 0 ; i<5; i++) {
        for (int j =0;j<4; j++) {
            UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(hotSeachLab.right+j*(padding+100), 110+i*50, 100, 30)];
            [contentLab setBackgroundColor:[UIColor greenColor]];
            contentLab.tag = i+j*10+10;
            contentLab.font = [UIFont systemFontOfSize:13];
            contentLab.userInteractionEnabled = YES;
            [self.view addSubview:contentLab];
            [contentLab release];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHotSearchLabWithSender:)];
            [contentLab addGestureRecognizer:tap];
            [tap release];

        }
    }
    [self showTitle];
    
    
}
-(void)showTitle
{
    for (UILabel *l in self.view.subviews) {
        if (l.tag>=10) {
            l.text = @"自定义的热词";
        }
    }
}
-(void)goToSearchResultPageWithKeyWord:(NSString *)keyWord
{
    ResultViewController *searchResultPage = [[ResultViewController alloc] init];
    searchResultPage.keyWordStr = keyWord;
    [self.navigationController pushViewController:searchResultPage animated:YES];
    [searchResultPage release];

}
-(void)tapHotSearchLabWithSender:(UITapGestureRecognizer *)tap
{
    UILabel *l = (UILabel *) tap.view;
    NSLog(@"是:%@",l.text);
    [self goToSearchResultPageWithKeyWord:l.text];
}

-(void)tapBackGround
{
    [_searchBar resignFirstResponder];
    
    
}
-(void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    //[[UIApplication sharedApplication].keyWindow setRootViewController:[[NSUserDefaults standardUserDefaults]valueForKey:@"root"]];
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
    NSString *s = searchBar.text;
    [self goToSearchResultPageWithKeyWord:s];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
