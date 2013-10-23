//
//  AuthorCell.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-21.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorView.h"
@protocol AuthorCellDelegate <NSObject>

-(void)getAuthorID:(NSString *)ID;
-(void)deleteOneAuthorByID:(NSString *)ID;

@end
@interface AuthorCell : UITableViewCell<AuthorViewDelegate>
@property(nonatomic,retain)NSMutableArray * subViewArry;//子视图
@property(nonatomic,assign)BOOL isHideMark;
@property(nonatomic,assign)id<AuthorCellDelegate>delegate;

-(void)addAuthorPictureWithNetArry:(NSArray *)netArry;
@end
