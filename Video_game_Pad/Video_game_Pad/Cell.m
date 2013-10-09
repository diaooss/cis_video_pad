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
        self.contentView.backgroundColor = [UIColor greenColor];
        self.PicArry = [NSMutableArray arrayWithCapacity:2];
        // Initialization code
#pragma mark---这个宽度和cell 的宽度一样!!!!!手动添加
           }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize mainSize = self.bounds.size;


    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,mainSize.width, mainSize.height)];
    [_scrollerView setContentSize:CGSizeMake(mainSize.width, mainSize.height)];
    _scrollerView.backgroundColor = [UIColor yellowColor];
           [self.contentView addSubview:_scrollerView];
    [_scrollerView setPagingEnabled:YES];
    [_scrollerView release];
    [_scrollerView setShowsHorizontalScrollIndicator:NO];
    
    for (int j=0; j<2; j++) {
        for (int i=0; i<6; i++) {
            GroupView * view = [[GroupView alloc]initWithFrame:CGRectMake(padding+170*i, padding+240*j, (mainSize.width-240)/6, 250)];
            [_scrollerView addSubview:view];
            [view setTag:100+j*6+i];
            [view release];
            [view setDelegate:self];
            [self.PicArry addObject:view];
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
