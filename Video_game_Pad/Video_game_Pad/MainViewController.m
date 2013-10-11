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


#define degreesToRadinas(x) (M_PI * (x)/180.0)
@interface MainViewController ()
{
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
    }
    return self;
}
-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.view setBackgroundColor:[UIColor yellowColor]];

    
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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 0, 0)] ;//创建一个视图
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
    static NSString *detailReuse = @"reuseDetail";
    Cell *rootCell = [tableView dequeueReusableCellWithIdentifier:detailReuse];
    if (rootCell == Nil) {
        rootCell = [[[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailReuse] autorelease];
        
        [rootCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //rootCell.transform =CGAffineTransformMakeRotation(degreesToRadinas(90));
    }
//*****************确保重用的cell起始位置不变
    [rootCell.scrollerView setContentOffset:CGPointMake(0, 0)];
//***加载过以后不再加载-------很重要-----
    if (self.mark>indexPath.row||self.mark==9) {
        return rootCell;
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
    [self showAlertView];
    NSLog(@"%@",videoID);
}
#pragma mark--banner的传值
-(void)transferBannerInfor:(NSString *)string
{
    NSLog(@"%@",string);
    [self showAlertView];

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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
