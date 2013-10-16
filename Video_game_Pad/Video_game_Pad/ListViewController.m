//
//  ListViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "ListViewController.h"
#import "Tools_Header.h"
#import "RequestUrls.h"
#import "MyNsstringTools.h"
#import "AuthorListCell.h"
#import "MGSplitViewController.h"
@interface ListViewController ()

{
    RequestTools * _Listrequest;
}
@property(nonatomic,retain)NSIndexPath * oldIndexPath;
@property (nonatomic,retain)NSMutableArray * authorListArry;

@end

@implementation ListViewController
-(void)dealloc
{
    [self.nowCategory release];
    [_oldIndexPath release];
    [_Listrequest release];
    [_authorListArry release];
    [_authorListTab release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.oldIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
	// Do any additional setup after loading the view.
    _authorListTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,200, self.view.width-93) style:UITableViewStylePlain];
    [_authorListTab setBackgroundColor:[UIColor whiteColor]];
    _authorListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_authorListTab];
    _authorListTab.showsVerticalScrollIndicator = NO;
    _authorListTab.separatorColor = [UIColor clearColor];
    [_authorListTab setDelegate:self];
    [_authorListTab setDataSource:self];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"作者列表";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [self.authorListArry count];
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * mark =@"mark";
    AuthorListCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (nil==cell) {
        cell = [[[AuthorListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark] autorelease];
    }
    if ([self.authorListArry count]>0) {
        [cell.authorPic setImageURL:[[self.authorListArry objectAtIndex:indexPath.row]valueForKey:@"photo"]];
        [cell.authorName setText:[[self.authorListArry objectAtIndex:indexPath.row]valueForKey:@"author"]];
        [cell setAuthorID: [[self.authorListArry objectAtIndex:indexPath.row]valueForKey:@"authorID"]];
    }
    return cell;
}

//选中的时候
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuthorListCell * cell =(AuthorListCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row!=0) {
        NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
        AuthorListCell * cellOne =(AuthorListCell *) [_authorListTab cellForRowAtIndexPath:index];
        [cellOne setSelected:NO];
    }
    if(indexPath.row== self.oldIndexPath.row){
        return;
    }
    self.oldIndexPath = indexPath;
//加载当前作者的的视频
    [self.nowCategory setAuthorID:cell.authorName.text];
    [self.nowCategory setFlag:1];
    [self.nowCategory .allInforArry removeAllObjects];
    [self.nowCategory addOneAuthorProductions];
}
#pragma mark---请求作者名字
-(void)requestAuthorListWithCategory:(NSString *)name
{
    _Listrequest = [[RequestTools alloc]init];
    [_Listrequest setDelegate:self];
    NSString *newCateStr = [NSString stringWithFormat:@"?category=%@",name];
    NSArray *strArry = [NSArray arrayWithObjects:@"http://121.199.57.44:88/webServer/PadGetAuthorlist.ashx",newCateStr,nil];
    [_Listrequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
    //NSLog(@" 当前的请求串 ---%@",[MyNsstringTools groupStrByAStrArray:strArry]);
}
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
//NSLog(@"----回来的结果%@",dic);
    [self setAuthorListArry:[dic valueForKey:@"AuthorResult"]];
    [_authorListTab reloadData];
//让第一个处于选中装态
    NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
    AuthorListCell * cell =(AuthorListCell *) [_authorListTab cellForRowAtIndexPath:index];
    [cell setSelected:YES];
//让详情界面开始加载第一个人的视频
    [self.nowCategory setAuthorID:cell.authorName.text];
    [self.nowCategory setShowCategory:self.category];
    [self.nowCategory addOneAuthorProductions];
}

-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
    NSLog(@"--------%@",dic);
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_Listrequest setDelegate:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
@end
