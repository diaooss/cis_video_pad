//
//  CategoryViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "CategoryViewController.h"
#import "Tools_Header.h"
#import "Tools.h"
#import "RequestUrls.h"
#import "MyNsstringTools.h"
@interface CategoryViewController ()
{
    RequestTools * _categoryRequest;
    UILabel * _inforlabel;
    UITableView * _showTab;
     
}
@property (nonatomic,copy)NSString * oldAuthorID;//上一次请求的作者ID---------

@property (nonatomic ,copy)NSString * choseString;//当前选择是最热....还是最新

@end

@implementation CategoryViewController
-(void)dealloc
{
    [_refreshHeaderView release];
    [_refreshFooterView release];
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
        //NSLog(@"mark");
    }
    self.allInforArry = [NSMutableArray arrayWithCapacity:2];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSArray * segName = [NSArray arrayWithObjects:@"❤最新✌",@"😘最热😜", nil];
    UISegmentedControl * categorySeg =[[UISegmentedControl alloc]initWithItems:segName];
    [categorySeg setFrame:CGRectMake(0, 0, 300, 50)];
    [categorySeg setSegmentedControlStyle:UISegmentedControlStyleBar];
    [self.view addSubview:categorySeg];
    [categorySeg setSelectedSegmentIndex:0];
    self.choseString = @"time";
    [categorySeg addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventValueChanged];
    [categorySeg release];
    
    _inforlabel  = [[UILabel alloc]initWithFrame:CGRectMake(self.view.width-300, 0, 200, 50)];
    [self.view addSubview:_inforlabel];
    [_inforlabel setTextAlignment:NSTextAlignmentCenter];
    [_inforlabel setBackgroundColor:[UIColor yellowColor]];
    [_inforlabel setText:@"😜骚年有1000部满足要求"];
    
    _showTab = [[UITableView alloc]initWithFrame:CGRectMake(0, categorySeg.bottom, self.view.width+75, self.view.width-140) style:UITableViewStylePlain];
    [_showTab setDelegate:self];
    [_showTab setDataSource:self];
    [_showTab setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_showTab];
    
    
    //为加载更多做准备
    self.oldAuthorID = self.authorID;
    [self createHeaderView];
    [self setFooterView];
    
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
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
    NSLog(@"----%@",ID);
}
#pragma mark 根据作者请求图片
-(void)addOneAuthorProductions
{
    [Tools openLoadsign:self.view WithString:@"😂😂😂正在为你回调数据....."];
    _categoryRequest = [[RequestTools alloc] init];
    [_categoryRequest setDelegate:self];
    
    NSString *authorIdStr = [NSString stringWithFormat:@"?author=%@&sort=%@&category=%@",self.authorID,self.choseString,self.showCategory];
    
    NSString *pageStr = [NSString stringWithFormat:@"&dataPage=%d",self.flag];
    NSArray *strArry = [NSArray arrayWithObjects:@"http://121.199.57.44:88/webServer/PadGetMovielist.ashx",authorIdStr,pageStr,nil];
    [_categoryRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
}
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    [_inforlabel setText:[NSString stringWithFormat:@"❤😘有%@",[dic valueForKey:@"allCount"]]];
    
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
    [Tools closeLoadsign:self.view];
    if ([dic valueForKey:@"allCount"]==0) {
#warning 没数据时候-----------------
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [Tools closeLoadsign:self.view];
    [_categoryRequest setDelegate:nil];
//请求指针社为空
     //NSLog(@"没内容??=%@",self.allInforArry);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//初始化刷新视图
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f, 0.0f - self.view.bounds.size.height,
                                     self.view.width+75, self.view.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
	[_showTab addSubview:_refreshHeaderView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)removeHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
    _refreshHeaderView = nil;
}

-(void)setFooterView{
    // if the footerView is nil, then create it, reset the position of the footer
    CGFloat height = MAX(_showTab.contentSize.height, _showTab.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              _showTab.frame.size.width,
                                              _showTab.bounds.size.height);
    }else {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         _showTab.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [_showTab addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView refreshLastUpdatedDate];
    }
}

-(void)removeFooterView{
    if (_refreshFooterView && [_refreshFooterView superview]) {
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark-
#pragma mark force to show the refresh headerView
-(void)showRefreshHeader:(BOOL)animated{
	if (animated)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		_showTab.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        // scroll the table view to the top region
        [_showTab scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
        [UIView commitAnimations];
	}
	else
	{
        _showTab.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[_showTab scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
	}
    
    [_refreshHeaderView setState:EGOOPullRefreshLoading];
}
//===============
//刷新delegate
#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader) {
        // pull down to refresh data
        [self performSelector:@selector(refreshView) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter){
        // pull up to load more data
        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
    }
    
	// overide, the actual loading data operation is done in the subclass
}

#pragma mark -
#pragma mark method that should be called when the refreshing is finished
- (void)finishReloadingData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_showTab];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_showTab];
        [self setFooterView];
    }
    [_showTab reloadData];
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:_showTab];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:_showTab];
        [self setFooterView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark -
#pragma mark EGORefreshTableDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
	
	[self beginToReloadData:aRefreshPos];
	
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return _reloading; // should return if data source model is reloading
}


// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

//刷新调用的方法----------下拉刷新
-(void)refreshView{
    //下拉刷新--------
    self.flag = 1;
    [self.allInforArry removeAllObjects];
    [self addOneAuthorProductions];
    [self testFinishedLoadData];
    
}
//加载调用的方法----------上拉加载
-(void)getNextPageView{
    [self removeFooterView];
    self.flag ++;
    [self addOneAuthorProductions];
    [self testFinishedLoadData];
}-(void)testFinishedLoadData{
    
    [self finishReloadingData];
    [self setFooterView];
}

@end
