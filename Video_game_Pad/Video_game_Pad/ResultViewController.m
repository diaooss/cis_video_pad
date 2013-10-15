//
//  ResultViewController.m
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "ResultViewController.h"
#import "Tools_Header.h"
#import "RequestUrls.h"
#import "MyNsstringTools.h"
@interface ResultViewController ()
{
    RequestTools * _request;
}
@property (nonatomic,retain)NSMutableArray * searchArry;
@property (nonatomic,copy)NSString * allSearchCount;
@end

@implementation ResultViewController
- (void)dealloc
{
    [self.allSearchCount release];
    [self.searchArry release];
    [_request release];
    [searchResultTab release];
    self.keyWordStr = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.searchArry = [NSMutableArray arrayWithCapacity:2];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"全部搜索结果";
    searchResultTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.height, self.view.width-40) style:UITableViewStylePlain];
    searchResultTab.delegate = self;
    searchResultTab.dataSource = self;
    searchResultTab.showsVerticalScrollIndicator = NO;
    [self.view addSubview:searchResultTab];
    [searchResultTab setBackgroundColor:[UIColor redColor]];
    [searchResultTab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
	// Do any additional setup after loading the view.
    _request = [[RequestTools alloc] init];
    [_request setDelegate:self];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",search_url,self.keyWordStr];
    NSLog(@"%@",requestUrl);
    [_request requestWithUrl_Asynchronous:[MyNsstringTools changeStrWithUT8:requestUrl]];

}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
    
}
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    self.allSearchCount=[dic valueForKey:@"count"];
    //NSLog(@"%@",dic);
    self.searchArry = [dic valueForKey:@"result"];
    [searchResultTab reloadData];
    [searchResultTab reloadInputViews];
    
}
#pragma mark--列表代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,1,0)];
    myView.backgroundColor = [UIColor whiteColor];
    UILabel *resultLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 40)];
    resultLab.text = [NSString stringWithFormat:@"搜索%@",_keyWordStr];
    resultLab.backgroundColor = [UIColor yellowColor];
    resultLab.font = [UIFont systemFontOfSize:20];
    [myView addSubview:resultLab];
    [resultLab release];
    
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(resultLab.right, resultLab.top, 500, 40)];
    //搜索结果;
   countLab.text =  [NSString stringWithFormat:@"符合条件的结果有%@条",self.allSearchCount];
    [myView addSubview:countLab];
    countLab.textAlignment = NSTextAlignmentRight;
    [countLab release];
    searchResultTab.tableHeaderView = myView;
    return [myView autorelease];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchArry count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * mark =@"mark";
    SearchCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (cell==nil) {
        cell = [[[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark] autorelease];
        [cell setDelegate:self];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    for(id obj in cell.searchPicArry )
    {
        [obj setHidden:NO];
    }
    [cell addSearchPictureWithNetArry:nil];
    if ([self.searchArry count]>0) {
        NSLog(@"%d",indexPath.row);
        [cell addSearchPictureWithNetArry:[self.searchArry objectAtIndex:indexPath.row]];
    }
    return cell;
}
#pragma mark---cell 的代理
-(void)transferSearchCellinforWithID:(NSString *)ID
{
    NSLog(@"ID啊有木有%@",ID);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
