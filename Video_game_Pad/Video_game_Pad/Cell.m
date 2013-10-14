//
//  Cell.m
//  CELL
//
//  Created by huangfangwang on 13-8-28.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "Cell.h"
#import "GroupView.h"
#import "MyNsstringTools.h"
#define padding 20
#define spacePadding 40
#import "Tools_Header.h"
@implementation Cell
-(void)dealloc
{
    [self.PicArry release];
    [self.scrollerView release];
    [super dealloc];
   
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // self.contentView.backgroundColor = [UIColor greenColor];
        self.PicArry = [NSMutableArray arrayWithCapacity:2];
        // Initialization code
#pragma mark---这个宽度和cell 的宽度一样!!!!!手动添加
        for (int i=0; i<12; i++) {
            GroupView * view = [[GroupView alloc]init];
            [view setDelegate:self];
            [self.PicArry addObject:view];
            [view release];
            [self.contentView addSubview:view];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize mainSize = self.bounds.size;
    for (int i=0; i<2; i++) {
        for (int j=0; j<6; j++) {
            GroupView * view  = (GroupView *)[self.PicArry objectAtIndex:(i*6+j)];
            [view setFrame:CGRectMake(padding+170*j, padding+240*i, (mainSize.width-240)/6, 250)];
        }
    }
}
-(void)loadInforWithNetArry:(NSArray *)netArry
{
    int mark = 0;
    for (GroupView * obj in self.PicArry) {
        [obj.asImageView setImageURL:[MyNsstringTools changeStrWithUT8:[[netArry objectAtIndex:mark]valueForKey:@"thumbnail"]]];
        [obj.nameLabel setText:[[netArry objectAtIndex:mark]valueForKey:@"movieName"]];//名字
        [obj.timeLabel setText:[[netArry objectAtIndex:mark]valueForKey:@"duration"]];//时间
        [obj setVideoID:[[netArry objectAtIndex:mark]valueForKey:@"movieID"]];//视频ID;
        mark++;
    }
}
//cell  再触发点击视图的时候走代理 去做事情
-(void)clickThePictureWith:(NSString *)videoID
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(accessPlayViewControllerWithVideoID:)]) {
        [self.delegate performSelector:@selector(accessPlayViewControllerWithVideoID:) withObject:videoID];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
