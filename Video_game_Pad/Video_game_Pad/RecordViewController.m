//
//  RecordViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "RecordViewController.h"
#import "Tools_Header.h"
@interface RecordViewController ()



@end

@implementation RecordViewController
- (void)dealloc
{
    [recordTab release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor grayColor]];
    
    recordTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, self.view.width-54) style:UITableViewStylePlain];
    recordTab.dataSource = self;
    recordTab.delegate = self;
    recordTab.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:recordTab];
    
    
	// Do any additional setup after loading the view.
}
#pragma mark--列表代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseName = @"use";
    UITableViewCell *cell  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseName];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseName] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = @"星级争霸之阿里巴巴";
    cell.detailTextLabel.text = @"视频简介啊发卡女款;你; 你卡率那块";
    
    cell.imageView.image = [UIImage imageNamed:@"headerimage.png"];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
