//
//  GroupView.m
//  CELL
//
//  Created by huangfangwang on 13-8-28.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "GroupView.h"
#import <QuartzCore/QuartzCore.h>
@implementation GroupView
-(void)dealloc
{
    [self.asImageView release];
    [self.timeLabel release];
    [self.nameLabel release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
         CGSize mainSize = self.frame.size;
        
        self.asImageView = [[AsynImageView alloc]initWithFrame:CGRectMake(0, 0, mainSize.width, mainSize.height*3/4)];
        _asImageView.backgroundColor = [UIColor blackColor];
        [_asImageView setPlaceholderImage:[UIImage imageNamed:@"test.png"]];
        [self addSubview:_asImageView];
        [_asImageView release];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainSize.width-50, _asImageView.frame.size.height-15, 50, 15)];
        [_asImageView addSubview:_timeLabel];
        [_timeLabel setText:@"88:88"];
        [_timeLabel setTextColor:[UIColor whiteColor]];
        [_timeLabel setFont:[UIFont systemFontOfSize:11]];
        [_timeLabel setTextAlignment:NSTextAlignmentCenter];
        [_timeLabel setBackgroundColor:[UIColor blackColor]];
        //[_timeLabel setAlpha:0.5];
        
        [_timeLabel release];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, mainSize.height*3/5, mainSize.width, mainSize.height*2/5)];
        [self addSubview:_nameLabel];
        [_nameLabel setFont:[UIFont systemFontOfSize:13]];
        [_nameLabel setNumberOfLines:0];
        [_nameLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_nameLabel setBackgroundColor:[UIColor clearColor]];
        
        [_nameLabel setText:@"精彩视频,即将上线"];
        [_nameLabel release];
        
       
               
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(transferVideoID)];
        [self addGestureRecognizer:tap];
        [tap release];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize mainSize = self.frame.size;

    _asImageView.frame = CGRectMake(0, 0, mainSize.width, mainSize.height*3/4);
    _timeLabel.frame = CGRectMake(mainSize.width-50, _asImageView.frame.size.height-15, 50, 15);
    _nameLabel.frame = CGRectMake(0, mainSize.height*3/5, mainSize.width, mainSize.height*2/5);
}
-(void)transferVideoID
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(clickThePictureWith:)]) {
        [self.delegate performSelector:@selector(clickThePictureWith:) withObject:self.videoID];
    }
}
@end
