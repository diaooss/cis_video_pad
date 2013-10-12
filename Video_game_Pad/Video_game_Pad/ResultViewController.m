//
//  ResultViewController.m
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "ResultViewController.h"
#import "Tools_Header.h"
@interface ResultViewController ()

@end

@implementation ResultViewController
- (void)dealloc
{
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
    return self;
}
-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.navigationItem.title = @"全部搜索结果";
    searchResultTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.height, self.view.width-55) style:UITableViewStylePlain];
    searchResultTab.delegate = self;
    searchResultTab.dataSource = self;
    searchResultTab.showsVerticalScrollIndicator = NO;
    [self.view addSubview:searchResultTab];
    
    NSLog(@"导航条高度是:%f",self.navigationController.navigationBar.height);
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
#pragma mark--列表代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.height, 40)];
    myView.backgroundColor = [UIColor whiteColor];
    UILabel *resultLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 40)];
    resultLab.text = [NSString stringWithFormat:@"搜索%@",_keyWordStr];
    resultLab.backgroundColor = [UIColor yellowColor];
    resultLab.font = [UIFont systemFontOfSize:20];
    [myView addSubview:resultLab];
    [resultLab release];
    
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(resultLab.right, resultLab.top, 500, 40)];
   countLab.text =  [NSString stringWithFormat:@"符合条件的结果有%d条",20];
    [myView addSubview:countLab];
    countLab.textAlignment = NSTextAlignmentRight;
    [countLab release];
    searchResultTab.tableHeaderView = myView;
    return [myView autorelease];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseName = @"use";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseName];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseName] autorelease];
        cell.textLabel.text = @"搜索结果呈现";
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
