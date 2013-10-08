//
//  RootViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "CategoryViewController.h"
#import "ListViewController.h"
#import "CollectViewController.h"
#import "AttentionViewController.h"
#import "RecordViewController.h"

#import "MyView.h"
@interface RootViewController ()
@property(nonatomic,retain)UIPopoverController * MyPopoverController;
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //推荐主页
        MainViewController * main = [[MainViewController alloc]init];
        
        [main setTitle:@"推荐"];
        //视频收藏页面
        CollectViewController * collect = [[CollectViewController alloc]init];
        [collect setTitle:@"我的收藏"];
        //我的关注
        AttentionViewController * attention = [[AttentionViewController alloc]init];
        [attention setTitle:@"我的关注"];
        //
        NSArray * nameArry = [NSArray arrayWithObjects:main,
                              [self createCategoryViewControllerWitnName:@"Dota"],
                              [self createCategoryViewControllerWitnName:@"英雄联盟"],
                              [self createCategoryViewControllerWitnName:@"Dota2"],
                              [self createCategoryViewControllerWitnName:@"星际争霸2"],
                              [self createCategoryViewControllerWitnName:@"魔兽世界"],
                              collect,
                              attention,
                              nil];
        [self setViewControllers:nameArry];
        [main release];
        [collect release];

    }
    [self setSelectedIndex:3];
    [self setDelegate:self];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"推荐"];
        //搜索框
    UISearchBar*  searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    [searchBar setPlaceholder:@"关键字"];
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
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(300, 0, 400, 44)];
    searchView.backgroundColor = [UIColor clearColor];
    [searchView addSubview:searchBar];
    self.navigationItem.titleView = searchView;
    [searchBar release];
    //产品logo
    UIButton *logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoBtn.frame = CGRectMake(0, 0, 100, 44);
    [logoBtn setTitle:@"幻方科技" forState:UIControlStateNormal];
    logoBtn.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *logoBar = [[UIBarButtonItem alloc] initWithCustomView:logoBtn];
   //观看记录
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc]initWithTitle:@"观看记录" style:UIBarButtonItemStyleDone target:self action:@selector(makeRecordView)];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:logoBar,barItem, nil] animated:YES];
    //系统设置
    UIBarButtonItem * setBarItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(showSettingPage)];
    [self.navigationItem setRightBarButtonItem:setBarItem];
   
    [barItem release];
    [setBarItem release];
    
}
-(void)makeRecordView
{
    if (self.MyPopoverController.popoverVisible) {
        [self.MyPopoverController dismissPopoverAnimated:YES];
        
    }else {
        // 初始化内容视图控制器
        RecordViewController *splitVC = [[RecordViewController alloc] init];
        
        splitVC.title = @"观看记录";
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:splitVC];
        [splitVC release];
        // 添加内容视图控制器
        self.MyPopoverController = [[[UIPopoverController alloc]initWithContentViewController:navigation] autorelease];
        [navigation release];//popoverBackgroundViewClass
        UIImageView * image =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 280, 600)];
        [image setImage:[UIImage imageNamed:@"plant1.png"]];
//        MyView * view = [[MyView alloc]initWithFrame:CGRectMake(0, 0, 280, 600)];
//        if ([self.MyPopoverController respondsToSelector:@selector(popoverBackgroundViewClass)]) {
//            [self.MyPopoverController setPopoverBackgroundViewClass:[view class]];
//        }
        // 设置popover视图⼤大⼩小
        self.MyPopoverController.popoverContentSize = CGSizeMake(280, 600);
        [self.MyPopoverController presentPopoverFromBarButtonItem:[self.navigationItem.leftBarButtonItems objectAtIndex:1] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}
-(void)showSettingPage
{
    
    
}
-(UISplitViewController*)createCategoryViewControllerWitnName:(NSString*)name
{
    CategoryViewController * category = [[CategoryViewController alloc]init];
//配置tabbar
    
//左视图控制器
    ListViewController * list = [[ListViewController alloc] init];
    UISplitViewController * split = [[UISplitViewController alloc]init];
    [split setTitle:name];
    NSArray * arry = [NSArray arrayWithObjects:list,category, nil];
    [split setViewControllers:arry];
//释放
    [category release];
    [list release];
    return [split autorelease];
}
#pragma mark--UITabBarController代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//#warning 配置头
    [self.navigationItem setTitle:viewController.title];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
