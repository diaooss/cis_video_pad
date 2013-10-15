//
//  ForgetPSWViewController.m
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "ForgetPSWViewController.h"
#import "Tools_Header.h"
#import "Tools.h"
#import "MyNsstringTools.h"
#import "RequestUrls.h"
@interface ForgetPSWViewController ()

@end

@implementation ForgetPSWViewController
- (void)dealloc
{
    [emailField release];
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
    self.navigationItem.title = @"找回密码";
    
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(200, 50, 400, 40)];
    emailField.delegate= self;
    emailField.backgroundColor = [UIColor whiteColor];
    emailField.textColor = [UIColor grayColor];
    emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    emailField.textAlignment = NSTextAlignmentLeft;
    emailField.keyboardType = UIKeyboardTypeEmailAddress;
    emailField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailField.font  =[UIFont systemFontOfSize:19];
    emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailField.placeholder = @"注册时所用邮箱";
    emailField.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:emailField];
    
    UIButton *getEmailCheckInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getEmailCheckInBtn.frame = CGRectMake(emailField.left+80, emailField.bottom+40, 200, 40);
    getEmailCheckInBtn.showsTouchWhenHighlighted = YES;
    [getEmailCheckInBtn setTitle:@"邮箱验证" forState:UIControlStateNormal];
    getEmailCheckInBtn.backgroundColor = [UIColor redColor];
    [getEmailCheckInBtn addTarget:self action:@selector(checkInWithEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getEmailCheckInBtn];
    //提示
    UILabel *tipsLab = [[UILabel alloc] initWithFrame:CGRectMake(emailField.left, getEmailCheckInBtn.bottom+20, 400, 20)];
    tipsLab.text = @"我们将在稍后将验证信息发送至您的邮箱,请注意查收并妥善保管...";
    tipsLab.backgroundColor = [UIColor clearColor];
    tipsLab.textColor = [UIColor grayColor];
    tipsLab.font = [UIFont systemFontOfSize:13];
    tipsLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipsLab];
    [tipsLab release];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    
}
#pragma mark--键盘消失
-(void)tapBackGround
{
    
    [emailField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [emailField resignFirstResponder];
    return YES;
}
-(void)checkInWithEmail
{
    [emailField resignFirstResponder];
    if (emailField.text!=NULL&&[Tools cheeckEmail:emailField.text]==YES) {
        //发起请求
        NSString *newEmaiStr = [NSString stringWithFormat:@"?ToEmail=%@",[emailField text]];
        BOOL flag =    [RequestTools requestReturnYesOrOkWithCheckUrl_Synchronous:[MyNsstringTools groupStrByAStrArray:[NSArray arrayWithObjects:GET_NEW_PSW_byEmail,newEmaiStr, nil]]];
        [self checktoGetNewPSWIsOK:flag];
    }
    
}
-(void)checktoGetNewPSWIsOK:(BOOL)flag
{
    NSLog(@"%d",flag);
    //根据标记值进行判断
    if (flag == YES) {
        
        [Tools makeOneCautionViewOnView:[[UIApplication sharedApplication] keyWindow] withString:@"验证成功"];
        //同时进行合理提示
    }else
    {
        [Tools makeOneCautionViewOnView:self.view withString:@"验证失败"];
        
    }
    [self back];
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
