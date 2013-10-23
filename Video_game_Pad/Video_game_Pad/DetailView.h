//
//  DetailView.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-17.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynImageView.h"
@protocol DetailViewDelegate <NSObject>

-(void)tapThePictureGetVideoID:(NSString *)ID;
-(void)pressMakeButtonGetVideoID:(NSString *)ID;
@end
@interface DetailView : UIView
@property (nonatomic,assign)id<DetailViewDelegate>delegate;
@property (nonatomic,retain)AsynImageView * asImageView;
@property (nonatomic,retain)UILabel * timeLabel;
@property (nonatomic,retain)UILabel * nameLabel;
@property (nonatomic,copy)NSString * videoID;
@property (nonatomic,assign)BOOL isHide;
@end