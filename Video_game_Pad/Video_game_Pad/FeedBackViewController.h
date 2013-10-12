//
//  FeedBackViewController.h
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-12.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedBackViewController : UIViewController<UITextFieldDelegate,NSCoding>
{
    UITextField *feedTextField;//反馈内容
    UITextField *qqOrPhoneField;//QQ号码
}

@end
