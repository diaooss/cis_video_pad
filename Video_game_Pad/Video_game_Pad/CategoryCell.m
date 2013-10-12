//
//  CategoryCell.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "CategoryCell.h"
#import "GroupView.h"
#import "MyNsstringTools.h"
#define padding 20
#define spacePadding 40
#import "Tools_Header.h"
@interface CategoryCell ()


@end
@implementation CategoryCell
-(void)dealloc
{
    [self.PicArry release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    self.PicArry = [NSMutableArray arrayWithCapacity:2];
#pragma mark---这个宽度和cell 的宽度一样!!!!!手动添加
    
    for (int i=0; i<4; i++) {
        GroupView * view = [[GroupView alloc]init];
        [view setDelegate:self];
        [self.PicArry addObject:view];
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

        for (int j=0; j<4; j++) {
            GroupView * view  = (GroupView *)[self.PicArry objectAtIndex:j];
            [view setFrame:CGRectMake(15+173*j,10, (mainSize.width-80)/4, 250)];
            [view.asImageView setPlaceholderImage:[UIImage imageNamed:@"test.png"]];
        }
    
}
-(void)addPictureWithNetArry:(NSArray *)netArry
{
    int mark = 0;
    //NSLog(@"+++++++%@",netArry );
    if ([netArry count]==0) {
        return;
    }
    for (GroupView * obj in self.PicArry) {

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
    if (self.delegate&&[self.delegate respondsToSelector:@selector(transferCategoryCellinforWithID:)]) {
        [self.delegate performSelector:@selector(transferCategoryCellinforWithID:) withObject:videoID];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
