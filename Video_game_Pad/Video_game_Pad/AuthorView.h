//
//  AuthorView.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynImageView.h"
@protocol AuthorViewDelegate <NSObject>

-(void)tapThePictureGetAuthorID:(NSString *)ID;
-(void)pressMakeButtonGetAuthorID:(NSString *)ID;
@end
@interface AuthorView : UIView
@property(nonatomic,retain)AsynImageView * asyImage;//放作者头像
@property(nonatomic,retain)UILabel * nameLabel;//作者名字
@property(nonatomic,retain)UILabel * popularLabel;//作者人气
@property(nonatomic,retain)UILabel * videoCountLabel;//作者作品数量
@property(nonatomic,copy)NSString * authorID;//作者ID
@property (nonatomic,assign)BOOL isHide;
@property(nonatomic,assign)id<AuthorViewDelegate>delegate;
@end
