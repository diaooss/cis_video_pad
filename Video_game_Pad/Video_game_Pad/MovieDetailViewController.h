//
//  MovieDetailViewController.h
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-9-30.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//单击电影缩略图时的弹出视图

#import <UIKit/UIKit.h>
@protocol MJSecondPopupDelegate;

@interface MovieDetailViewController : UIViewController

@property(nonatomic,copy)NSString *requestIdStr;//视频ID

@property(nonatomic,retain)NSDictionary *detailDic;//详情字典

@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;

@end


@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(MovieDetailViewController*)secondDetailViewController;
@end