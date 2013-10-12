//
//  CategoryCell.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupView.h"
@protocol CategoryCellDelegate <NSObject>

-(void)transferCategoryCellinforWithID:(NSString *)ID;

@end

@interface CategoryCell : UITableViewCell<GroupViewDelegate>

@property(nonatomic,assign)id<CategoryCellDelegate>delegate;
@property(nonatomic,retain)NSMutableArray * PicArry;


-(void)addPictureWithNetArry:(NSArray *)netArry;
@end
