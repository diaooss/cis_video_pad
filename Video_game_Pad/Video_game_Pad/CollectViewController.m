//
//  CollectViewController.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "CollectViewController.h"
#import "Tools.h"
#import "LandingViewController.h"
#import "UINavigationController+MyNavigationcontroller.h"
@interface CollectViewController ()

@end

@implementation CollectViewController

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
    [self.view setBackgroundColor:[UIColor blueColor]];
    if ([Tools isHaveLogin]==NO) {
        [self showLoginPage];
    }
	// Do any additional setup after loading the view.
}
-(void)showLoginPage
{
    LandingViewController *login = [[LandingViewController alloc] init];
    UINavigationController *loginNavc = [[UINavigationController alloc] initWithRootViewController:login];
    [loginNavc setModalPresentationStyle:UIModalPresentationFormSheet];
    [loginNavc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [loginNavc disablesAutomaticKeyboardDismissal];
    
    [self presentModalViewController:loginNavc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self showLoginPage];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
