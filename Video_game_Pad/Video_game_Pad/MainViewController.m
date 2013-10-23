//
//  MainViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "MainViewController.h"
#import "Tools_Header.h"
#import "RequestTools.h"
#import "MyNsstringTools.h"
#import "UIViewController+MJPopupViewController.h"
#import "MovieDetailViewController.h"
#import "LandingViewController.h"

#define degreesToRadinas(x) (M_PI * (x)/180.0)
@interface MainViewController ()
{
    BOOL flag;
}
@end

@implementation MainViewController
- (void)dealloc
{
    [mainTab release];
    self.bannerArry = nil;
    self.tabArry = nil;
    [recommendRequest release];
    self.classDic = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        flag = YES;
    }
    return self;
}

-(void)startRequetsRecommendInfo
{

    recommendRequest  = [[RequestTools alloc] init];
    recommendRequest.delegate = self;
    [recommendRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:[NSArray arrayWithObjects:@"http://121.199.57.44:88/WebServer/HomeData.ashx", nil]]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    mainTab  =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.height, self.view.width-110) style:UITableViewStylePlain];
    mainTab.delegate = self;
    mainTab.dataSource =  self;
    mainTab.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainTab];
    
    [self startRequetsRecommendInfo];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0)
        return 50;
    return 500;
}
//定制列表头
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.width/4;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0.1)] ;//创建一个视图
    headerView.backgroundColor = [UIColor clearColor];
    
    Banner_view * banner = [[Banner_view alloc]initWithFrame:CGRectMake(0, 0, 1024, self.view.width/4) ];
    [banner setInforArry:self.bannerArry];
    [banner initSubview];
    [banner setDelegate:self];
    
    [headerView addSubview:banner];
    
    mainTab.tableHeaderView = headerView;
    [banner release];

     return [headerView autorelease];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSArray *cateGoryArry = [NSArray arrayWithObjects:@"英雄联盟",@"DOTA",@"DOTA2",@"魔兽争霸3",@"星际大战2", nil];
    if (indexPath.row%2==0) {
        NSString *reuseName = @"reuse";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseName];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseName] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        cell.imageView.image = [UIImage imageNamed:@"Next.png"];
        cell.textLabel.text = [cateGoryArry objectAtIndex:indexPath.row/2];
        return cell;
    }
//视图
    static NSString *detailReuse = @"reuseDetail";
    Cell *rootCell = [tableView dequeueReusableCellWithIdentifier:detailReuse];
    if (rootCell == Nil) {
        rootCell = [[[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailReuse] autorelease];
        
        [rootCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    NSArray * nameArry = [NSArray arrayWithObjects:@"英雄联盟",@"dota",@"dota2",@"魔兽争霸3",@"星际大战2", nil];
    if ([self.classDic valueForKey:[nameArry objectAtIndex:(indexPath.row-1)/2]]>0) {
        [rootCell loadInforWithNetArry:[self.classDic valueForKey:[nameArry objectAtIndex:(indexPath.row-1)/2]]];
        [rootCell setDelegate:self];
        self.mark=indexPath.row;
    }
    return rootCell;
}
#pragma mark--cell的传值代理
-(void)accessPlayViewControllerWithVideoID:(NSString *)videoID
{
    
    MovieDetailViewController *detailPage = [[MovieDetailViewController alloc] init];
   
    [self presentPopupViewController:detailPage animationType:MJPopupViewAnimationFade];
    [detailPage release];
}
#pragma mark--banner的传值
-(void)transferBannerInfor:(NSString *)string
{
    NSLog(@"%@",string);

}
#pragma mark--请求回调
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    self.bannerArry = [dic objectForKey:@"bannerResult"];
    [self setClassDic:dic];
    [mainTab reloadData];
}
-(void)showAlertView
{
    UIAlertView *tips = [[UIAlertView alloc] initWithTitle:@"😉紧张施工中..." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [tips show];
    [tips release];
    
}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
    
}
#pragma mark--点击消失 的代理
- (void)cancelButtonClicked:(MovieDetailViewController *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
-(void)showLoginPage
{
    LandingViewController * land = [[LandingViewController alloc]init];
    UINavigationController * landNVC = [[UINavigationController alloc]initWithRootViewController:land];
    [self presentPopupViewController:landNVC animationType:MJPopupViewAnimationFade];
    
    //        [landNVC setModalPresentationStyle:UIModalPresentationPageSheet];
    //        [self presentModalViewController:landNVC animated:YES];
    [land release];
    [landNVC release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (flag==YES) {
        [mainTab setOrigin:CGPointMake(0, -20)];
    }
    else
    {
    [mainTab setOrigin:CGPointMake(0,0)];
    }
    flag=NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [recommendRequest setDelegate:nil];
}
@end
