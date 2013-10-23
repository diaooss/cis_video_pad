//
//  MasterViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-17.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "MasterViewController.h"
#import "Tools_Header.h"
#import "AsynImageView.h"
#import "URBSegmentedControl.h"
@interface MasterViewController ()
{
    UITableView * _personTab;
    AsynImageView * _person;
}

@end

@implementation MasterViewController
-(void)dealloc
{
    
    [_person release];
    [_detail release];
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
    [self.view setBackgroundColor:[UIColor brownColor]];
    _person = [[AsynImageView alloc]initWithFrame:CGRectMake(20, 60, 100, 100)];
    [self.view addSubview:_person];
    [_person setBackgroundColor:[UIColor redColor]];
    [_person setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changPersonPic)];
    [_person addGestureRecognizer:tap];
    [tap release];
    
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(_person.right+20, _person.bottom-40, 70, 40)];
    [loginButton setBackgroundColor:[UIColor greenColor]];
    [loginButton setShowsTouchWhenHighlighted:YES];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];

    NSArray *titles = [NSArray arrayWithObjects:@"我的关注",@"我的收藏",@"应用推荐", nil];
	NSArray *icons = [NSArray arrayWithObjects:[UIImage imageNamed:@"mountains.png"], [UIImage imageNamed:@"snowboarder.png"], [UIImage imageNamed:@"biker.png"], nil];    
    URBSegmentedControl *verticalControl2 = [[URBSegmentedControl alloc] initWithTitles:titles icons:icons];
    [verticalControl2 setBaseColor:[UIColor whiteColor]];
    [verticalControl2 setStrokeColor:[UIColor whiteColor]];
    
    [verticalControl2 setSegmentBackgroundColor:[UIColor brownColor]];
	[verticalControl2 setFrame:CGRectMake(20, _person.bottom+50, 200, 260)];;
	verticalControl2.layoutOrientation = URBSegmentedControlOrientationVertical;
	[self.view addSubview:verticalControl2];
    [verticalControl2 release];
	[verticalControl2 addTarget:self action:@selector(segmentResultChange:) forControlEvents:UIControlEventValueChanged];
    
//判断是否登陆**********
    self.detail.specialMark = YES;
    [self showUesrCollectVideo];
    
}
-(void)segmentResultChange:(URBSegmentedControl *)obj
{
    switch (obj.selectedSegmentIndex) {
        case 0:
            self.detail.specialMark = YES;
            [self showUesrCollectVideo];
            break;
        case 1:
            self.detail.specialMark = NO;
            [self showUserAttentionAuthors];
            break;
        case 2:
            [self showAdvertisement];
            break;
        default:
            break;
    }
    
}
//展示用户收藏内容
-(void)showUesrCollectVideo
{
    self.detail.isNeedHide=YES;
    [self.detail.setButton setHidden:NO];
    [self.detail requestUserAttentionAndCollect:@"http://121.199.57.44:88/webServer/PadGetFavariteMovies.ashx?email=1823870397@qq.com"];
}
//展示用户关注的作者
-(void)showUserAttentionAuthors
{
    self.detail.isNeedHide=YES;
    [self.detail.setButton setHidden:NO];
    [self.detail requestUserAttentionAndCollect:@"http://121.199.57.44:88/webServer/PadGetCaredAuthors.ashx?email=1823870397@qq.com"];
}
//展示推荐广告
-(void)showAdvertisement
{
    
}
//登陆
-(void)login
{
  //登陆成功后调用 ***************用户收藏
}
//换照片
-(void)changPersonPic
{
    
}
#pragma mark--_personTab的代理
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * mark = @"mark";
    NSArray * nameArry = [NSArray arrayWithObjects:@"我的收藏",@"我的关注",@"应用推荐",@"清楚缓存", nil];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (nil==cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark] autorelease];
    }
    [cell setSelected:YES];
    //[cell.imageView setImage:[UIImage imageNamed:@"Next@2x.png"]];
    [cell.textLabel setText:[nameArry objectAtIndex:indexPath.row]];
    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.height/6;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [backView setBackgroundColor:[UIColor yellowColor]];
    UIButton * personBUtton = [UIButton buttonWithType:UIButtonTypeCustom];
    [personBUtton setFrame:CGRectMake(10, 10,100,100)];
    [personBUtton setBackgroundColor:[UIColor grayColor]];
    [backView addSubview:personBUtton];
    
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(personBUtton.right+20, personBUtton.bottom-40, 70, 40)];
    [loginButton setBackgroundColor:[UIColor grayColor]];
    [loginButton setShowsTouchWhenHighlighted:YES];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [backView addSubview:loginButton];
    return [backView autorelease];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row<2) {
        [self.detail.setButton setHidden:NO];
        self.detail.isNeedHide=YES;
        //[self.detail.resultArry removeAllObjects];
        if (indexPath.row==0) {
            self.detail.specialMark = YES;
        }else{
            self.detail.specialMark = NO;
        }
   // [self.detail requestUserAttentionAndCollect];
    
    }else
    {
        [self.detail.setButton setHidden:YES];
        //[self.detail.shouTab removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
