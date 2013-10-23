//
//  DetailViewController.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-17.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
#import "DetailCell.h"
#import "AuthorCell.h"
@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate,DetailCellDelegate,AuthorCellDelegate>

@property(nonatomic,retain)UIButton * setButton;
@property(nonatomic,assign)BOOL specialMark;///判断是展示视频还是作者 
@property(nonatomic,assign)BOOL isNeedHide;
@property(nonatomic,retain)NSMutableArray * resultArry;
@property(nonatomic,retain)UITableView * collectTab;//展示收藏视频
-(void)requestUserAttentionAndCollect:(NSString *)string;///请求
@end
