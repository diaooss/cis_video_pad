//
//  SearchCell.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-14.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "SearchCell.h"
#import "MyNsstringTools.h"
@implementation SearchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    self.searchPicArry = [NSMutableArray arrayWithCapacity:2];
#pragma mark---这个宽度和cell 的宽度一样!!!!!手动添加
    
    for (int i=0; i<6; i++) {
        GroupView * view = [[GroupView alloc]init];
        [view setDelegate:self];
        [self.searchPicArry addObject:view];
        [view release];
        [view setHidden:NO];
        
        [self.contentView addSubview:view];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize mainSize = self.bounds.size;
    
    for (int j=0; j<6; j++) {
        GroupView * view  = (GroupView *)[self.searchPicArry objectAtIndex:j];
        [view setFrame:CGRectMake(10+170*j,20, (mainSize.width-80)/6, 250)];
        [view.asImageView setPlaceholderImage:[UIImage imageNamed:@"test.png"]];
    }
    
}
-(void)addSearchPictureWithNetArry:(NSArray *)netArry
{
    int mark = 0;
    //NSLog(@"+++++++%@",netArry );
    if ([netArry count]==0) {
        return;
    }
    for (GroupView * obj in self.searchPicArry) {
        
        if (mark<[netArry count]) {
            [obj.asImageView setImageURL:[MyNsstringTools changeStrWithUT8:[[netArry objectAtIndex:mark]valueForKey:@"thumbnail"]]];
            [obj.nameLabel setText:[[netArry objectAtIndex:mark]valueForKey:@"movieName"]];//名字
            [obj.timeLabel setText:[[netArry objectAtIndex:mark]valueForKey:@"duration"]];//时间
            [obj setVideoID:[[netArry objectAtIndex:mark]valueForKey:@"movieID"]];//视频ID;
            
        }else{
            [obj setHidden:YES];
        }
        mark++;
    }    
}
-(void)clickThePictureWith:(NSString *)videoID
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(transferSearchCellinforWithID:)]) {
        [self.delegate performSelector:@selector(transferSearchCellinforWithID:) withObject:videoID];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
