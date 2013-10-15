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
#import "SearchViewController.h"
#import "MyView.h"
#import "UINavigationController+MyNavigationcontroller.h"
#import "SetViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "MGSplitViewController.h"
@interface RootViewController ()

{
  
}
@property(nonatomic,retain)UIPopoverController * MyPopoverController;
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization


    }
    [self setDelegate:self];
    
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
                          [self createCategoryViewControllerWitnName:@"英雄联盟"],
                          [self createCategoryViewControllerWitnName:@"Dota"],
                          [self createCategoryViewControllerWitnName:@"Dota2"],
                          [self createCategoryViewControllerWitnName:@"魔兽争霸3"],
                          [self createCategoryViewControllerWitnName:@"星际大战2"],
                          
                          collect,
                          attention,
                          nil];
    [self setViewControllers:nameArry animated:YES];
    [main release];
    [collect release];
    
    
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    
    [self.view setExclusiveTouch:YES];
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
        // 设置popover视图⼤大⼩小
        self.MyPopoverController.popoverContentSize = CGSizeMake(300, 600);
        [self.MyPopoverController setDelegate:self];
        [self.MyPopoverController presentPopoverFromBarButtonItem:[self.navigationItem.leftBarButtonItems objectAtIndex:1] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}
//判断popView是否存在
-(void)isHavePopView
{
    if (self.MyPopoverController.popoverVisible) {
        [self.MyPopoverController dismissPopoverAnimated:YES];
    }
}
-(void)showSettingPage
{
   
    [self isHavePopView];
    
    SetViewController * set = [[SetViewController alloc]init];
    UINavigationController * setNVC = [[UINavigationController alloc]initWithRootViewController:set];
    [setNVC setModalPresentationStyle:UIModalPresentationFormSheet];
    [setNVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [setNVC disablesAutomaticKeyboardDismissal];

    [self presentModalViewController:setNVC animated:YES];
    [set release];
    [setNVC release];
}

-(MGSplitViewController*)createCategoryViewControllerWitnName:(NSString*)name
{
    
//配置tabbar
//左视图控制器
    ListViewController * list = [[ListViewController alloc] init];
    CategoryViewController * category = [[CategoryViewController alloc]init];
     MGSplitViewController * split = [[MGSplitViewController alloc]init];
    [list setNowCategory:category];
    [split setSplitPosition:200.0];
    [split setShowsMasterInPortrait:YES];
    [split setTitle:name];
    NSArray * arry = [NSArray arrayWithObjects:list,category, nil];
    [split setViewControllers:arry];
//释放
    [category release];
    [list release];
    return [split autorelease];;
}
#pragma mark--UITabBarController代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self isHavePopView];
    [self.navigationItem setTitle:viewController.title];
    
    if (tabBarController.selectedIndex>0&&tabBarController.selectedIndex<6) {
    
    NSArray * nameArry = [NSArray arrayWithObjects:@"英雄联盟",@"dota",@"dota2",@"魔兽争霸3",@"星际大战2", nil];
    MGSplitViewController * splitViewController = (MGSplitViewController *)viewController;
    ListViewController * list= [[splitViewController viewControllers]objectAtIndex:0];
//每次点击都要清空数据
    [list.nowCategory.allInforArry removeAllObjects];
    [list setCategory:[nameArry objectAtIndex:tabBarController.selectedIndex-1]];
    [list requestAuthorListWithCategory:[nameArry objectAtIndex:tabBarController.selectedIndex-1]];
    }
    
    
    
    
    
      
    
}
#pragma mark--拉起搜索页面
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar                     // return NO to not become first responder
{
    [self isHavePopView];
    //NSLog(@"点击");
    SearchViewController *seachVc  = [[SearchViewController alloc] init];
    UINavigationController *searchNavc = [[UINavigationController alloc] initWithRootViewController:seachVc];


    [self.navigationController presentViewController:searchNavc animated:YES completion:^{
        
    }];
    [seachVc release];
    [searchNavc release];

    
    return NO;
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"点击");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//
//{
//    
//    // 这里可以做子view自己想做的事，做完后，事件继续上传，就可以让其父类，甚至父viewcontroller获取到这个事件了
//    
//    [[self nextResponder]touchesBegan:touches withEvent:event];
//    NSLog(@"000000000");
//    
//}
//
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//
//{
//    
//    [[self nextResponder]touchesEnded:touches withEvent:event];
//    
//}
//
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//
//{
//    
//    [[self nextResponder] touchesCancelled:touches withEvent:event];
//    
//}
//
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//
//{
//    
//    [[self nextResponder] touchesMoved:touches withEvent:event];
//}
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    
//    return YES;
//}
@end
