//
//  FeedBackViewController.m
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-12.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "FeedBackViewController.h"
#import "Tools_Header.h"
@interface FeedBackViewController ()

@end

@implementation FeedBackViewController
- (void)dealloc
{
    [feedTextField release];
    [qqOrPhoneField release];
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
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255. blue:240/255. alpha:1];
    feedTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, self.view.width, self.view.height/4)];
    feedTextField.tag = 1000;
    feedTextField.delegate= self;
    feedTextField.backgroundColor = [UIColor whiteColor];
    feedTextField.textColor = [UIColor grayColor];
    feedTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    feedTextField.textAlignment = NSTextAlignmentLeft;
    feedTextField.font  =[UIFont systemFontOfSize:17];
    feedTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    feedTextField.placeholder = @"您的反馈将帮助我们更快的成长";
    [self.view addSubview:feedTextField];
    qqOrPhoneField = [[UITextField alloc] initWithFrame:CGRectMake(feedTextField.left, feedTextField.bottom+5, feedTextField.width, 35)];
    qqOrPhoneField.tag = 1100;
    qqOrPhoneField.delegate= self;
    qqOrPhoneField.backgroundColor = [UIColor colorWithRed:220/255.0 green:223/255. blue:223/255. alpha:1];
    qqOrPhoneField.placeholder = @"留下您的QQ(选填)";
    qqOrPhoneField.textColor = [UIColor colorWithRed:102/255.0 green:108/255. blue:120/255. alpha:1];
    qqOrPhoneField.font = [UIFont systemFontOfSize:15];
    qqOrPhoneField.textAlignment = NSTextAlignmentLeft;
    qqOrPhoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    qqOrPhoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    qqOrPhoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:qqOrPhoneField];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
    [self.view addGestureRecognizer:tap];
    [tap release];
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}
-(void)tapBackGround
{
    [feedTextField resignFirstResponder];
    [qqOrPhoneField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
