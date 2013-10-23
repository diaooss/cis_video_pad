//
//  DetailViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-17.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "DetailViewController.h"
#import "Tools_Header.h"
#import "MyNsstringTools.h"

@interface DetailViewController ()
{
    RequestTools * _request;
}

@end

@implementation DetailViewController
-(void)dealloc
{
    [_resultArry release];
    [_request release];
    [_setButton release];
    [_collectTab release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isNeedHide= YES;
    }
    self.resultArry = [NSMutableArray arrayWithCapacity:0];
    self.specialMark=YES;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];

    self.collectTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.height-230, self.view.width-44-49-50) style:UITableViewStylePlain];
    [self.view addSubview:_collectTab];
    [_collectTab setDelegate:self];
    [_collectTab setDataSource:self];
    [_collectTab release];
    
    self.setButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_setButton setTitle:@"删除" forState:UIControlStateNormal];
    [_setButton setFrame:CGRectMake(self.view.height-230-100, 0, 100, 50)];
    [self.view addSubview:_setButton];
    [_setButton addTarget:self action:@selector(showTheDeleteMark) forControlEvents:UIControlEventTouchUpInside];
}
-(void)showTheDeleteMark
{
    if (_isNeedHide) {
        _isNeedHide = NO;
        [_setButton setTitle:@"完成" forState:UIControlStateNormal];
    }else
    {
        _isNeedHide = YES;
        [_setButton setTitle:@"删除" forState:UIControlStateNormal];
    }

    [_collectTab reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resultArry count];
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 270.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.specialMark) {
        static NSString * mark = @"mark";
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:mark];
        if (cell==nil) {
            cell = [[[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setDelegate:self];
        }
        [cell setIsHideMark:_isNeedHide];
        for(id obj in cell.PicArry )
        {
            [obj setHidden:NO];
        }
        if ([self.resultArry count]>0) {
            
            [cell addViodeoPictureWithNetArry:[self.resultArry objectAtIndex:indexPath.row]];
        }
        return cell;
    }else{
        static NSString * mark = @"cclove";
        AuthorCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
        if (nil==cell) {
            cell = [[[AuthorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark] autorelease];
            [cell setDelegate:self];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell setIsHideMark:_isNeedHide];
        for(id obj in cell.subViewArry )
        {
            [obj setHidden:NO];
        }
        if ([self.resultArry count]>0) {
            
            [cell addAuthorPictureWithNetArry:[self.resultArry objectAtIndex:indexPath.row]];
        }
        return cell;
    }
}
#pragma mark---收藏视频的.......代理
-(void)sendVideoID:(NSString *)ID
{
    NSLog(@"得到视频的");

}
-(void)deleteOneVideoByID:(NSString *)ID
{
    NSLog(@"删除视频的");
    [_collectTab reloadData];
    [_collectTab reloadInputViews];
}
#pragma mark---关注作者的代理
-(void)getAuthorID:(NSString *)ID
{
    NSLog(@"得到作者");

}
-(void)deleteOneAuthorByID:(NSString *)ID
{
    NSLog(@"删除作者");
    [_collectTab reloadData];
    [_collectTab reloadInputViews];
}
#pragma mark--请求网络
-(void)requestUserAttentionAndCollect:(NSString *)string
{
    _request = [[RequestTools alloc]init];
    [_request setDelegate:self];
    [_request requestWithUrl_Asynchronous:[MyNsstringTools changeStrWithUT8:string]];
    if (_isNeedHide) {
        [self.setButton setTitle:@"删除" forState:UIControlStateNormal];
    }
}
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    [self.resultArry removeAllObjects];
    for (id obj in [dic valueForKey:@"result"]) {
        [self.resultArry addObject:obj];
    }
    
    [self.collectTab reloadData];
    [self.collectTab reloadInputViews];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[_shouTab reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
