//
//  LandingViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-8.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "LandingViewController.h"
#import "SetButton.h"
#import "Tools_Header.h"
@interface LandingViewController ()

@end

@implementation LandingViewController

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
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(viewDisappear)];
    [self.navigationItem setRightBarButtonItem:bar];
    [bar release];
    [self.view setBackgroundColor:[UIColor grayColor]];
    self.navigationItem.title = @"登陆";
    
    //
    eMailTextF = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 280, 35)];
    eMailTextF.delegate= self;
    eMailTextF.backgroundColor = [UIColor yellowColor];
    eMailTextF.textColor = [UIColor grayColor];
    eMailTextF.keyboardType = UIKeyboardTypeEmailAddress;
    eMailTextF.autocorrectionType = UITextAutocorrectionTypeNo;
    eMailTextF.textAlignment = NSTextAlignmentLeft;
    eMailTextF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    eMailTextF.font  =[UIFont systemFontOfSize:19];
    eMailTextF.clearButtonMode = UITextFieldViewModeUnlessEditing;
    eMailTextF.placeholder = @"登陆邮箱";
    eMailTextF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:eMailTextF];
    //密码
    pswTextF = [[UITextField alloc] initWithFrame:CGRectMake(eMailTextF.left, eMailTextF.bottom+30, 280, 35)];
    pswTextF.delegate= self;
    pswTextF.backgroundColor = [UIColor yellowColor];
    pswTextF.textColor = [UIColor grayColor];
    pswTextF.textAlignment = NSTextAlignmentLeft;
    pswTextF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    pswTextF.borderStyle = UITextBorderStyleRoundedRect;
    pswTextF.font  =[UIFont systemFontOfSize:19];
    pswTextF.secureTextEntry = YES;
    pswTextF.clearButtonMode = UITextFieldViewModeUnlessEditing;
    pswTextF.placeholder = @"密码";
    [self.view addSubview:pswTextF];
    //登陆
    UIButton *login_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    login_btn.backgroundColor = [UIColor greenColor];
    login_btn.frame = CGRectMake(pswTextF.left, pswTextF.bottom+30, 280, 50);
    [login_btn setTitle:@"登陆" forState:UIControlStateNormal];
    login_btn.showsTouchWhenHighlighted = YES;
    [login_btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login_btn];

    
    
    
    SetButton *registerBtn = [SetButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(100, 410, 160, 50);
    registerBtn.backgroundColor = [UIColor clearColor];
    [registerBtn setShowsTouchWhenHighlighted:YES];
    registerBtn.leftImage.image = [UIImage imageNamed:@"Next.png"];
    registerBtn.nameLabel.text = @"快速注册";
    [self.view addSubview:registerBtn];
    
    SetButton *getPswBtn = [SetButton buttonWithType:UIButtonTypeCustom];
    getPswBtn.frame = CGRectMake(300, 410, 160, 50);
    getPswBtn.backgroundColor = [UIColor clearColor];
    getPswBtn.leftImage.image = [UIImage imageNamed:@"Next.png"];

    [getPswBtn setShowsTouchWhenHighlighted:YES];
    getPswBtn.nameLabel.text = @"忘记密码";
    [self.view addSubview:getPswBtn];
    
    
    
    
    
}
//界面消失
-(void)viewDisappear
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
