//
//  DetailCell.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"
@protocol DetailCellDelegate <NSObject>

-(void)sendVideoID:(NSString *)ID;
-(void)deleteOneVideoByID:(NSString *)ID;

@end
@interface DetailCell : UITableViewCell<DetailViewDelegate>
@property(nonatomic,retain)NSMutableArray * PicArry;//子视图
@property(nonatomic,assign)BOOL isHideMark;
@property(nonatomic,assign)id<DetailCellDelegate>delegate;

-(void)addViodeoPictureWithNetArry:(NSArray *)netArry;
@end
