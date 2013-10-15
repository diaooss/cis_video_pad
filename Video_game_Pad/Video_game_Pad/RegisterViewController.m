//
//  RegisterViewController.m
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "RegisterViewController.h"
#import "Tools.h"
#import "RequestTools.h"
#import "RequestUrls.h"
#import "MyNsstringTools.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

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

    for (int i = 0; i<3; i++) {
        UITextField *contentFiled = [[UITextField alloc] initWithFrame:CGRectMake(170, 50+i*50+i*40, 400, 50)];
        contentFiled.tag = 100*i+100;
        contentFiled.backgroundColor = [UIColor yellowColor];
        contentFiled.textColor = [UIColor grayColor];
        contentFiled.autocorrectionType = UITextAutocorrectionTypeNo;
        contentFiled.textAlignment = NSTextAlignmentLeft;
        contentFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        contentFiled.font  =[UIFont systemFontOfSize:19];
        contentFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        contentFiled.borderStyle = UITextBorderStyleBezel;
        if (i==0) {
            contentFiled.placeholder = @"请输入昵称(不超过八位字符)";
        }else if (i==1)
        {
            contentFiled.placeholder = @"请输入正确邮箱以便找回密码...";
            contentFiled.delegate= self;
        }else
        {
            contentFiled.placeholder = @"请输入密码";
            contentFiled.secureTextEntry = YES;
        }
        [self.view addSubview:contentFiled];
        [contentFiled release];
    }
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(220, 320, 300, 60);
    registerBtn.backgroundColor = [UIColor greenColor];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn setShowsTouchWhenHighlighted:YES];
    [registerBtn addTarget:self action:@selector(goToRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
    [self.view addGestureRecognizer:tap];
    [tap release];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    
	// Do any additional setup after loading the view.
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    UITextField *emailText =(UITextField *)[self.view viewWithTag:200];
    self.isEmailRingt = [Tools cheeckEmail:emailText.text];//将格式值取出
    if (emailText.text.length==0) {
        [self remindBoxWith:@"邮箱不能为空"];
        return YES;
    }
    if (!self.isEmailRingt)
    {
        [self remindBoxWith:@"邮箱格式错误"];
        return YES;
    }
    [self performSelectorInBackground:@selector(cheeckEmail:) withObject:emailText.text];
    return YES;
}
-(void)cheeckEmail:(NSString *)email//邮箱格式是否正确提醒
{
    self.isEmailExist = [RequestTools requestReturnYesOrOkWithCheckUrl_Synchronous:[NSString stringWithFormat:@"%@?email=%@",CHECK_EMAIL,email]];
    if (!self.isEmailExist) {
        [self performSelectorOnMainThread:@selector(remindBoxWith:) withObject:@"邮箱已被注册.." waitUntilDone:NO];
        UITextField * emailText = (UITextField *)[self.view viewWithTag:200];
        [emailText becomeFirstResponder];
    }
}


#pragma mark--取消键盘
-(void)tapBackGround
{
    for (int i = 0; i<3; i++) {
        UITextField *ff = (UITextField *)[self.view viewWithTag:100*i+100];
        [ff resignFirstResponder];
    }
}
-(void)goToRegister
{
    //做不为空判断
    UITextField * nameText = (UITextField *)[self.view viewWithTag:100];
    UITextField * emailText = (UITextField *)[self.view viewWithTag:200];
    UITextField * pswText = (UITextField *)[self.view viewWithTag:300];
    //名字检测.....
    if (nameText.text.length==0) {
        [self remindBoxWith:@"名字不能为空.."];
        [nameText becomeFirstResponder];
        return;
    }else if (nameText.text.length>10)
    {
        [self remindBoxWith:@"名字太长...."];
        [nameText becomeFirstResponder];
        return;
    }
    //邮箱注册前检测....
    if (emailText.text.length==0) {
        [self remindBoxWith:@"邮箱不能为空"];
        [emailText becomeFirstResponder];
        return;
    }
    if (!self.isEmailRingt) {
        [self remindBoxWith:@"邮箱格式不对..."];
        [emailText becomeFirstResponder];
        return;
    }
    if (!self.isEmailExist)
    {
        [self remindBoxWith:@"邮箱已被注册...."];
        [emailText becomeFirstResponder];
        return;
    }
    //密码检测..
    if (pswText.text.length==0) {
        [self remindBoxWith:@"密码不能为空.."];
        [pswText becomeFirstResponder];
        return;
    }else if (pswText.text.length<6)
    {
        UIAlertView  * alert = [[UIAlertView alloc]initWithTitle:nil message:@"密码不安全.." delegate:self cancelButtonTitle:@"增加密码" otherButtonTitles:@"继续注册", nil];
        [alert show];
        [alert release];
        return;
    }
}

//警告处理
-(void)remindBoxWith:(NSString *)string
{
    UIAlertView  * alert = [[UIAlertView alloc]initWithTitle:@"Waring" message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField * pswText = (UITextField *)[self.view viewWithTag:300];
    if (buttonIndex==0) {
        [pswText becomeFirstResponder];
    }
    else
    {
        [self login];
    }
}
//真正注册
-(void)login
{
    UITextField * nameText = (UITextField *)[self.view viewWithTag:100];
    UITextField * emailText = (UITextField *)[self.view viewWithTag:200];
    UITextField * pswText = (UITextField *)[self.view viewWithTag:300];
    NSArray *newArry  =[NSArray arrayWithObjects:REGISTER,[NSString stringWithFormat:@"?user_Name=%@&email=%@&psw=%@",nameText.text,emailText.text,pswText.text], nil];
    BOOL registrIsOk = [RequestTools requestReturnYesOrOkWithCheckUrl_Synchronous:[MyNsstringTools groupStrByAStrArray:newArry]];
    [self registerIsSuccess:registrIsOk];
    [Tools openLoadsign:self.view WithString:@"正在注册......."];
}
-(void)registerIsSuccess:(BOOL)flag
{
    [Tools makeOneCautionViewOnView:[[UIApplication sharedApplication] keyWindow] withString:@"注册成功"];
    UITextField * nameText = (UITextField *)[self.view viewWithTag:100];
    UITextField * emailText = (UITextField *)[self.view viewWithTag:200];
    UITextField * pswText = (UITextField *)[self.view viewWithTag:300];
    [[NSUserDefaults standardUserDefaults] setObject:nameText.text forKey:@"user_name"];
    [[NSUserDefaults standardUserDefaults] setObject:emailText.text forKey:@"user_email"];
    [[NSUserDefaults standardUserDefaults] setObject:pswText.text forKey:@"user_psw"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [Tools closeLoadsign:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
