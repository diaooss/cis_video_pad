//
//  RegisterViewController.h
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
@interface RegisterViewController : UIViewController<UITextFieldDelegate,myHttpRequestDelegate>
@property(nonatomic,assign)BOOL isEmailRingt;//邮箱是否正确
@property(nonatomic,assign)BOOL isEmailExist;//邮箱是否已经被注册
@end
