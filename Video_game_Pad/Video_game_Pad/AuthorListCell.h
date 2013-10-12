//
//  AuthorListCell.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynImageView.h"
@interface AuthorListCell : UITableViewCell
@property(nonatomic,retain)AsynImageView * authorPic;//作者照片
@property(nonatomic,retain)UILabel * authorName;//作者名字
@property(nonatomic,assign)BOOL isAttention;//用户是否关注
@property(nonatomic,retain)NSString * authorID;
@end
