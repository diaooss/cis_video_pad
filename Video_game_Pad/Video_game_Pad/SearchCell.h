//
//  SearchCell.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-14.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupView.h"
@protocol SearchCellDelegate <NSObject>

-(void)transferSearchCellinforWithID:(NSString *)ID;

@end
@interface SearchCell : UITableViewCell<GroupViewDelegate>

@property(nonatomic,assign)id<SearchCellDelegate>delegate;
@property(nonatomic,retain)NSMutableArray * searchPicArry;
-(void)addSearchPictureWithNetArry:(NSArray *)netArry;
@end
