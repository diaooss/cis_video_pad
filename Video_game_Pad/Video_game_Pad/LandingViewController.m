//
//  LandingViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-8.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "LandingViewController.h"
#import "RegisterViewController.h"
#import "ForgetPSWViewController.h"
#import "RequestTools.h"
#import "SetButton.h"
#import "Tools_Header.h"
#import "Tools.h"
#import "MyNsstringTools.h"
#import "RequestUrls.h"
@interface LandingViewController ()

@end

@implementation LandingViewController
- (void)dealloc
{
    [eMailTextF release];
    [pswTextF release];
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
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(viewDisappear)];
    [self.navigationItem setRightBarButtonItem:bar];
    [bar release];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"登陆";
    
    //
    eMailTextF = [[UITextField alloc] initWithFrame:CGRectMake(200, 80, 350, 50)];
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
    eMailTextF.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:eMailTextF];
    //密码
    pswTextF = [[UITextField alloc] initWithFrame:CGRectMake(eMailTextF.left, eMailTextF.bottom+40, 350, 50)];
    pswTextF.delegate= self;
    pswTextF.backgroundColor = [UIColor yellowColor];
    pswTextF.textColor = [UIColor grayColor];
    pswTextF.textAlignment = NSTextAlignmentLeft;
    pswTextF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    pswTextF.borderStyle = UITextBorderStyleBezel;
    pswTextF.font  =[UIFont systemFontOfSize:19];
    pswTextF.secureTextEntry = YES;
    pswTextF.clearButtonMode = UITextFieldViewModeUnlessEditing;
    pswTextF.placeholder = @"密码";
    [self.view addSubview:pswTextF];
    //登陆
    UIButton *login_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    login_btn.backgroundColor = [UIColor greenColor];
    login_btn.frame = CGRectMake(pswTextF.left+30, pswTextF.bottom+50, 280, 50);
    [login_btn setTitle:@"登陆" forState:UIControlStateNormal];
    login_btn.showsTouchWhenHighlighted = YES;
    [login_btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:login_btn];

    
    
    
    SetButton *registerBtn = [SetButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(eMailTextF.left, 450, 160, 50);
    registerBtn.backgroundColor = [UIColor clearColor];
    [registerBtn setShowsTouchWhenHighlighted:YES];
    registerBtn.leftImage.image = [UIImage imageNamed:@"Next.png"];
    [registerBtn addTarget:self action:@selector(goToRegisterPage) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.nameLabel.text = @"快速注册";
    [self.view addSubview:registerBtn];
    
    SetButton *getPswBtn = [SetButton buttonWithType:UIButtonTypeCustom];
    getPswBtn.frame = CGRectMake(registerBtn.right+90, 450, 160, 50);
    getPswBtn.backgroundColor = [UIColor clearColor];
    getPswBtn.leftImage.image = [UIImage imageNamed:@"Next.png"];
    [getPswBtn addTarget:self action:@selector(goToForgetPswPage) forControlEvents:UIControlEventTouchUpInside];
    [getPswBtn setShowsTouchWhenHighlighted:YES];
    getPswBtn.nameLabel.text = @"忘记密码";
    [self.view addSubview:getPswBtn];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    
}
//界面消失
-(void)viewDisappear
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
-(void)tapBackGround
{
    [eMailTextF resignFirstResponder];
    [pswTextF resignFirstResponder];
}
#pragma mark--登陆
-(void)login
{
    //做邮箱格式及所有内容是否为空的判断
    if ([Tools cheeckEmail:eMailTextF.text]==YES) {
        NSString *nameStr = [NSString stringWithFormat:@"?email=%@",eMailTextF.text];
        NSString *pswStr = [NSString stringWithFormat:@"&psw=%@",pswTextF.text];
        [Tools openLoadsign:self.view WithString:@"正在登陆..."];
        BOOL isLogin =   [RequestTools requestReturnYesOrOkWithCheckUrl_Synchronous:[MyNsstringTools groupStrByAStrArray:[NSArray arrayWithObjects:LOGIN,nameStr,pswStr,nil]]];
        [self loginIsSuccess:isLogin];
        //需重新定义一个在中央显示的提示块.淡入淡出,可以用在正误提醒,收藏关注成功与否等提醒.
    }
}

-(void)loginIsSuccess:(BOOL)flag
{
    if (flag == YES) {
        [Tools closeLoadsign:self.view];
        [Tools makeOneCautionViewOnView:[[UIApplication sharedApplication] keyWindow] withString:@"登陆成功"];
        
        //存起来用户名(邮箱)和登陆密码
        [[NSUserDefaults standardUserDefaults] setObject:eMailTextF.text forKey:@"user_email"];
        [[NSUserDefaults standardUserDefaults] setObject:pswTextF.text forKey:@"user_psw"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [UIView beginAnimations:nil context:nil];
        [UIView animateWithDuration:2 animations:^{
            [self performSelector:@selector(viewDisappear) withObject:nil afterDelay:0.2];
        }];
        [UIView commitAnimations];
    }else
    {
        [Tools closeLoadsign:self.view];
        [Tools makeOneCautionViewOnView:self.view withString:@"登录失败"];
    }
    
}

#pragma mark--前往注册页面和忘记密码页面
-(void)goToRegisterPage
{
    RegisterViewController *newRegister = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:newRegister animated:YES];
    [newRegister release];
}
-(void)goToForgetPswPage
{
    ForgetPSWViewController *getPsw = [[ForgetPSWViewController alloc] init];
    [self.navigationController pushViewController:getPsw animated:YES];
    [getPsw release];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [eMailTextF setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"user_email"]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
