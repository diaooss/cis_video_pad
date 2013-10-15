//
//  ForgetPSWViewController.h
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
@interface ForgetPSWViewController : UIViewController<UITextFieldDelegate,myHttpRequestDelegate>
{
    UITextField *emailField;//输入的验证邮箱

}

@end
