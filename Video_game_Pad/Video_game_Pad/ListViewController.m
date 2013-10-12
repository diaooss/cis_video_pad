//
//  ListViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "ListViewController.h"
#import "Tools_Header.h"
#import "CategoryViewController.h"
#import "RequestUrls.h"
#import "MyNsstringTools.h"
#import "AuthorListCell.h"
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
    _authorListTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,320, self.view.height) style:UITableViewStylePlain];
    [_authorListTab setBackgroundColor:[UIColor whiteColor]];

    [self.view addSubview:_authorListTab];
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
    return 80.0;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
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
        //NSLog(@"ceshi nide cishu ");
        return;
        
    }
    self.oldIndexPath = indexPath;
    //NSLog(@"是不是你😚");
    CategoryViewController * nowCategory= [[self.splitViewController viewControllers] objectAtIndex:1];
    [nowCategory setAuthorID:cell.authorName.text];
    [nowCategory addOneAuthorProductions];
//    [nowCategory.view setBackgroundColor:[UIColor colorWithHue:arc4random()%255/255.0 saturation:arc4random()%255/255.0 brightness:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
}
#pragma mark---请求作者名字
-(void)requestAuthorListWithCategory:(NSString *)name
{
    _Listrequest = [[RequestTools alloc]init];
    [_Listrequest setDelegate:self];
    NSString *newCateStr = [NSString stringWithFormat:@"?category=%@",name];
    NSArray *strArry = [NSArray arrayWithObjects:@"http://121.199.57.44:88/webServer/PadGetAuthorlist.ashx",newCateStr,nil];
    [_Listrequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
}
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    [self setAuthorListArry:[dic valueForKey:@"AuthorResult"]];
    [_authorListTab reloadData];
//让第一个处于选中装态
    NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
    AuthorListCell * cell =(AuthorListCell *) [_authorListTab cellForRowAtIndexPath:index];
    [cell setSelected:YES];
//让详情界面开始加载第一个人的视频
     CategoryViewController * nowCategory= [[self.splitViewController viewControllers] objectAtIndex:1];
    [nowCategory setAuthorID:cell.authorName.text];
    [nowCategory setShowCategory:self.category];
    [nowCategory addOneAuthorProductions];
}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
    NSLog(@"--------%@",dic);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [_authorListTab removeAllSubviews];
    // Dispose of any resources that can be recreated.
}
@end
