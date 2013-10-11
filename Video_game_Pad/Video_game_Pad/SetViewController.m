//
//  SetViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-8.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "SetViewController.h"
#import "Tools_Header.h"
@interface SetViewController ()

@end

@implementation SetViewController

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
    self.view.backgroundColor = [UIColor yellowColor];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTintColor:[UIColor brownColor]];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(viewDisappear)];
    [self.navigationItem setRightBarButtonItem:bar];
    [bar release];
    self.navigationItem.title = @"设置";
    UITableView *setTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width-220, self.view.height-44) style:UITableViewStyleGrouped];
    setTab.scrollEnabled = NO;
    setTab.delegate = self;
    setTab.dataSource = self;
    [self.view addSubview:setTab];
    [setTab release];
    
    
    
    
}

#pragma mark--列表的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 2;
    }
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseName = @"reuse";
    UITableViewCell *setCell = [tableView dequeueReusableCellWithIdentifier:reuseName];
    if (setCell == nil) {
        setCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseName] autorelease];
        setCell.tag = indexPath.section*10+indexPath.row;
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                setCell.textLabel.text = @"缓存清理";
                break;
            case 1:
                setCell.textLabel.text = @"通知设置";
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                setCell.textLabel.text = @"使用帮助";
                break;
            case 1:
                setCell.textLabel.text = @"意见反馈";
                break;
            case 2:
                setCell.textLabel.text = @"用户协议";
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                setCell.textLabel.text = @"给个好评";
                break;
            case 1:
                setCell.textLabel.text = @"版本更新";
                break;
            case 2:
                setCell.textLabel.text = @"关于我们";
                break;
            default:
                break;
        }
    }


    return setCell;
}
#pragma mark--点击设置按钮
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self showAlertView];
                break;
            case 1:
                [self showAlertView];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self showAlertView];
                break;
            case 1:
                [self showAlertView];
                break;
            case 2:
                [self showAlertView];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                [self showAlertView];
                break;
            case 1:
                [self showAlertView];
                break;
            case 2:
                [self showAlertView];
                break;
            default:
                break;
        }
    }

    
}
-(void)showAlertView
{
    UIAlertView *tips = [[UIAlertView alloc] initWithTitle:@"😉紧张施工中..." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [tips show];
    [tips release];

}
-(void)viewDisappear
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
