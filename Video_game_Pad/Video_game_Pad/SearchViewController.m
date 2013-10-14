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
#import "RequestUrls.h"
#import "RequestTools.h"
#import "MyNsstringTools.h"

#define padding 20
@interface SearchViewController ()

@end

@implementation SearchViewController
- (void)dealloc
{
    [_searchBar release];
    hotWordRequest.delegate = nil;
    [hotWordRequest release];
    self.hotWordDic = nil;
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
    hotSeachLab.tag = 137;
    hotSeachLab.textColor = [UIColor yellowColor];
    [self.view addSubview:hotSeachLab];
    [hotSeachLab release];
    //生成标签
    for (int i = 0; i<5; i++)
    {
        UILabel *titilLab = [[UILabel alloc] initWithFrame:CGRectMake(hotSeachLab.left, padding+hotSeachLab.bottom+i*50, 80, 30)];
        titilLab.backgroundColor = [UIColor yellowColor];
        [titilLab setTextAlignment:NSTextAlignmentLeft];
        titilLab.tag = i*1231+3;
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
            [titilLab setText:@"星际大战2"];
        }
        if (i==4) {
            [titilLab setText:@"魔兽争霸3"];
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
    
}
-(void)showTitle:(NSDictionary *)dic
{
    for (UILabel *l in self.view.subviews) {
        if ((l.tag-10)%10==0) {
            int index = (l.tag-10)/10;
            l.text = [[dic objectForKey:@"dota"] objectAtIndex:index];
        }
        if ((l.tag-11)%10==0) {
            int index = (l.tag-11)/10;
            l.text = [[dic objectForKey:@"英雄联盟"] objectAtIndex:index];
        }
       if ((l.tag-12)%10==0) {
           int index = (l.tag-12)/10;
             l.text = [[dic objectForKey:@"dota2"] objectAtIndex:index];
        }
         if ((l.tag-13)%10==0) {
              int index = (l.tag-13)/10;
             NSLog(@"星际:%d",index);
             if (index<0) {
                 index =0;
             }
              l.text = [[dic objectForKey:@"星际大战2"] objectAtIndex:index];
          }
    if ((l.tag-14)%10==0) {
        int flag = (l.tag -14)/10;
        NSLog(@"编辑是:%d",flag);
        switch (l.tag) {
            case 14:
                l.text = [[dic objectForKey:@"魔兽争霸3"] objectAtIndex:0];
                break;
            case 24:
                l.text = [[dic objectForKey:@"魔兽争霸3"] objectAtIndex:1];
                break;
            case 34:
                l.text = [[dic objectForKey:@"魔兽争霸3"] objectAtIndex:2];
                break;
            case 44:
                l.text = [[dic objectForKey:@"魔兽争霸3"] objectAtIndex:3];
                break;
                
            default:
                break;
        }
        
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
-(void)viewWillAppear:(BOOL)animated
{
    [self getHoeWordFromServer];
}
-(void)getHoeWordFromServer
{
    hotWordRequest = [[RequestTools alloc] init];
    hotWordRequest.delegate = self;
[hotWordRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:[NSArray arrayWithObjects:get_hotword_url, nil]]];
    
}
#pragma mark--请求热词的代理方法
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
    
}
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    self.hotWordDic = dic;
    NSLog(@"%@",dic);
    [self showTitle:dic];

}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    hotWordRequest.delegate = nil;
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
