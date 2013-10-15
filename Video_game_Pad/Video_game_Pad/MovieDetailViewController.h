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
@property(nonatomic,copy)NSString *movieNameStr;//显示电影名
@property(nonatomic,copy)NSString *authorNameStr;//显示作者名
@property(nonatomic,copy)NSString *durationStr;//显示时长
@property(nonatomic,copy)NSString *requestIdStr;
@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;

@end


@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(MovieDetailViewController*)secondDetailViewController;
@end