//
//  CategoryViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "CategoryViewController.h"
#import "Tools_Header.h"

#import "RequestUrls.h"
#import "MyNsstringTools.h"
@interface CategoryViewController ()
{
    RequestTools * _categoryRequest;
    UILabel * _inforlabel;
    UITableView * _showTab;
}
@property (nonatomic,copy)NSString * oldAuthorID;//上一次请求的作者ID---------
@property (nonatomic,retain)NSMutableArray * allInforArry;//请求回来的所有视频
@property (nonatomic ,copy)NSString * choseString;//当前选择是最热....还是最新

@end

@implementation CategoryViewController
-(void)dealloc
{
    [self.showCategory release];
    [self.oldAuthorID release];
    [self.choseString release];
    [self.allInforArry release];
    [_categoryRequest release];
    _categoryRequest=nil;
    [_showTab release];
    [_inforlabel release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.allInforArry = [NSMutableArray arrayWithCapacity:2];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor redColor]];
    NSArray * segName = [NSArray arrayWithObjects:@"❤最新✌",@"😘最热😜", nil];
    UISegmentedControl * categorySeg =[[UISegmentedControl alloc]initWithItems:segName];
    [categorySeg setFrame:CGRectMake(0, 0, 300, 70)];
    [categorySeg setSegmentedControlStyle:UISegmentedControlStylePlain];
    [self.view addSubview:categorySeg];
    [categorySeg setSelectedSegmentIndex:0];
    self.choseString = @"time";
    [categorySeg addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventValueChanged];
    [categorySeg release];
    
    _inforlabel  = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width-300, 0, 200, 70)];
    [self.view addSubview:_inforlabel];
    [_inforlabel setTextAlignment:NSTextAlignmentCenter];
    [_inforlabel setText:@"😜骚年有1000部满足要求"];
    
    _showTab = [[UITableView alloc]initWithFrame:CGRectMake(0, categorySeg.bottom, self.view.width-45, self.view.width-164) style:UITableViewStylePlain];
    [_showTab setDelegate:self];
    [_showTab setDataSource:self];
    [self.view addSubview:_showTab];
    
    
    //为加载更多做准备
    self.oldAuthorID = self.authorID;
}
-(void)segmentedControlChange:(UISegmentedControl *)segment{
    if ([segment selectedSegmentIndex]==1) {
        self.choseString = @"popular";
    }else
    {
       self.choseString = @"time"; 
    }
    //加载图片
    [self.allInforArry removeAllObjects];
    [self addOneAuthorProductions];
}
#pragma mark--- tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allInforArry count];
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 260.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * mark =@"mark";
    CategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (cell==nil) {
        cell = [[[CategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark] autorelease];
        [cell setDelegate:self];
    }
    for(id obj in cell.PicArry )
    {
        [obj setHidden:NO];
    }
    [cell addPictureWithNetArry:nil];
    if ([self.allInforArry count]>0) {
       
        //NSLog(@"==========%@",[self.allInforArry objectAtIndex:indexPath.row]);
        [cell addPictureWithNetArry:[self.allInforArry objectAtIndex:indexPath.row]];
    }
    return cell;
}
#pragma mark --cell的代理----传递点击图片的代理事件
-(void)transferCategoryCellinforWithID:(NSString *)ID
{
#warning 这里进入播放界面
    NSLog(@"----%@",ID);
}
#pragma mark 根据作者请求图片
-(void)addOneAuthorProductions
{
    _categoryRequest = [[RequestTools alloc] init];
    [_categoryRequest setDelegate:self];
    
    NSString *authorIdStr = [NSString stringWithFormat:@"?author=%@&sort=%@&category=%@",self.authorID,self.choseString,self.showCategory];
    
    //NSString *pageStr = [NSString stringWithFormat:@"&dataPage=%d",flag];
    NSArray *strArry = [NSArray arrayWithObjects:@"http://121.199.57.44:88/webServer/PadGetMovielist.ashx",authorIdStr,nil];
    NSLog(@"拼接字符串是:%@",[MyNsstringTools groupStrByAStrArray:strArry]);
    [_categoryRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];

}
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    //NSLog(@"%@",dic);
    [_inforlabel setText:[NSString stringWithFormat:@"❤😘有%@",[dic valueForKey:@"allCount"]]];
//    [self setAllInforArry:[dic valueForKey:@"result"]];
    
    if (![self.oldAuthorID isEqualToString:self.authorID]) {
        [self.allInforArry removeAllObjects];
        self.oldAuthorID = self.authorID;
    }
    for(id obj in [dic valueForKey:@"result"] )
    {
        [self.allInforArry addObject:obj];
    }
//更新界面
    [_showTab reloadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//请求指针社为空
    [_categoryRequest setDelegate:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
