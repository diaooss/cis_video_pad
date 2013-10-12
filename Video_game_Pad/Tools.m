//
//  Tools.m
//  NetTest
//
//  Created by huangfangwang on 13-8-19.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "Tools.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "LandingViewController.h"
#define NavigationBGImage @"navbar.png"
#define NavigationBACKImage @"goBack.png"

#import <QuartzCore/QuartzCore.h>
@implementation Tools

+(BOOL)isHaveNet
{
    if ([Reachability getCurrentNetWorkStatus]==NotReachable) {
        return NO;
    }
    return YES;
}
+(NSString *)currentNetState
{
    if (![self isHaveNet]) {
        return @"没有网络";
    }
    if ([Reachability getCurrentNetWorkStatus]==ReachableViaWiFi) {
        return @"WiFi";
    }
    return @"3G";
}
/*****************************/
+(void)addTipslabelWithTitle:(NSString *)title//加载提醒
{
    UILabel * notLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -40, 320, 40)];
    [notLabel setText:title];
    notLabel.textColor = [UIColor whiteColor];
    notLabel.backgroundColor = [UIColor lightGrayColor];
    [notLabel setTextAlignment:NSTextAlignmentCenter];
    [[UIApplication sharedApplication].keyWindow addSubview:notLabel];
    [self labelMakeAnimation:notLabel];
    [notLabel release];
}
//加载一个动画
+(void)labelMakeAnimation:(UIView* )sender
{
    [UIView animateWithDuration:2.0 animations:^{
        [sender setCenter:CGPointMake(160, 40)];

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 delay:2 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
            [sender setCenter:CGPointMake(160, -40)];

        } completion:^(BOOL finished) {
            [sender removeFromSuperview];

        }];
    }];
}
//*****邮箱检测
+(BOOL)cheeckEmail: (NSString *) userEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSLog(@"--------%d",[emailTest evaluateWithObject:userEmail]);
    return [emailTest evaluateWithObject:userEmail];
}
//***风火轮
+ (void)openLoadsign:(UIView* )view WithString:(NSString *)string
{
    MBProgressHUD * hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud setMode:MBProgressHUDModeIndeterminate];
    [hud setDetailsLabelText:string];
}
+ (void)closeLoadsign:(UIView* )view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
//***用户是否登陆
+(BOOL)isHaveLogin
{
    if ( [[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"]&&    [[NSUserDefaults standardUserDefaults] objectForKey:@"user_psw"]) {
        return YES;
    }
    return NO;
}
//发起评价
+(void)giveAppraiseForOurApp
{
    NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",626186545];//评论
    NSString *url2 = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=626186545"];//详情
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
//获得硬件信息
+(NSMutableDictionary *)getMobileInfo;
{
    NSMutableDictionary *mobileInfoDic = [NSMutableDictionary dictionary];
    UIDevice *device_=[UIDevice currentDevice];
    NSLog(@"设备所有者的名称－－%@",device_.name);//手机命名
    [mobileInfoDic setObject:device_.name forKey:@"mobileUserName"];
    NSLog(@"设备的类别－－－－－%@",device_.model);//设备是爱疯,touch,或者ipad
    [mobileInfoDic setObject:device_.model forKey:@"hardWareType"];
    [mobileInfoDic setObject:device_.systemName forKey:@"systemName"];
    NSLog(@"当前系统的版本－－－%@",device_.systemVersion);//当前系统版本号
    [mobileInfoDic setObject:device_.systemVersion forKey:@"systemVersion"];
    //得到设备屏幕高度,判断是爱疯5或以下.
    float screenHeight=[UIScreen mainScreen].bounds.size.height;
    if (screenHeight==960) {
        [mobileInfoDic setObject:@"爱疯5" forKey:@"mobileType"];
    }else
    {
        [mobileInfoDic setObject:@"爱疯4" forKey:@"mobileType"];
    }
    [mobileInfoDic setObject:[self getNowAppVersions] forKey:@"nowAppVersions"];
    
    return mobileInfoDic;
}
//获得当前版本号
+(NSString *)getNowAppVersions
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
//公共的返回视图--导航条,不涉及抽屉,只是促使页面返回
+ (void)navigaionView:(UIViewController *)viewController leftImageName:(NSString *)imgName title:(NSString *)title
{
    viewController.navigationItem.title = title;
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NavigationBGImage] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:NavigationBACKImage] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 30)];
    viewController.navigationItem.title = title;
    [button addTarget:viewController action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [viewController.navigationItem setLeftBarButtonItem:bar];
    [bar release];
}
//便捷生成导航视图,不涉及抽屉.带右上角按钮
+ (void)navigaionView:(UIViewController *)viewController leftImageName:(NSString *)imgName rightImageName:(NSString *)rightImgName title:(NSString *)title
{
    viewController.navigationItem.title = title;
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NavigationBGImage] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:NavigationBACKImage] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 30)];
    viewController.navigationItem.title = title;
    [button addTarget:viewController action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [viewController.navigationItem setLeftBarButtonItem:bar];
    [bar release];
    //右上角按钮
    UIButton  *topRightCorenerBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    topRightCorenerBtn.frame = CGRectMake(280, 0, 40, 30);
    [topRightCorenerBtn addTarget:viewController action:@selector(topRightCorenerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topRightCorenerBtn setBackgroundImage:[UIImage imageNamed:rightImgName] forState:UIControlStateNormal];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:topRightCorenerBtn];
    viewController.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}
+ (NSString *)calTimeMiss:(NSString *)dateString{
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormater setDateFormat:@"yyyyMMddhhmmss"];
    NSDate * createDate = [dateFormater dateFromString:dateString];
    NSString * strtime = @"1天前";
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:createDate];
    if (timeInterval <= 30) {
        strtime = @"刚刚";
    }else if (timeInterval > 60 && timeInterval < 60*60){
        NSString * strtime = [NSString stringWithFormat:@"%d%@",(int)timeInterval/60,@"分钟前"];
        return strtime;
    }else if (timeInterval >= 60*60 && timeInterval < 24*60*60){
        NSString * strtime = [NSString stringWithFormat:@"%d%@",(int)timeInterval/3600,@"小时前"];
        return strtime;
    }else {
        //        NSString * strtime = [NSString stringWithFormat:@"%d%@",(int)timeInterval/(60*60*24),@"天前"];
        strtime = @"N天前";
        return strtime;
    }
    return strtime;
}
+ (void)makeOneCautionViewOnView:(UIView *)view withString:(NSString *)string
{
        MBProgressHUD * hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
        [hud setMode:MBProgressHUDModeText];
        NSString *str = [NSString stringWithFormat:@"😉%@",string];
        [hud setDetailsLabelText:str];
        [hud setDetailsLabelFont:[UIFont systemFontOfSize:20]];
    [self test:view];
}
+(void)test:(UIView *)view
{
    MBProgressHUD * hud = [MBProgressHUD HUDForView:view];
    [hud hide:YES afterDelay:1.0];
}
//拉出登陆页面
+(void)showLoginPagesByViewController:(UIViewController *)viewController
{
    LandingViewController *login = [[LandingViewController alloc] init];
    UINavigationController *loginNavc = [[UINavigationController alloc] initWithRootViewController:login];
    [viewController presentViewController:loginNavc animated:YES completion:nil];
    [login release];
    [loginNavc release];
}
@end
