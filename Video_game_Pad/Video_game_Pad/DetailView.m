//
//  DetailView.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-17.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "DetailView.h"
@interface DetailView()
{
    UIButton * _markButton;
}
@end
@implementation DetailView
-(void)dealloc
{
    [_videoID release];
    [_timeLabel release];
    [_nameLabel release];
    [_asImageView release];
    [super dealloc];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.asImageView = [[AsynImageView alloc]init];
        _asImageView.backgroundColor = [UIColor blackColor];
        [_asImageView setPlaceholderImage:[UIImage imageNamed:@"test.png"]];
        [self addSubview:_asImageView];
        [_asImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_asImageView release];
        
        
        
        
        self.timeLabel = [[UILabel alloc]init];
        [_asImageView addSubview:_timeLabel];
        [_timeLabel setText:@"88:88"];
        [_timeLabel setTextColor:[UIColor whiteColor]];
        [_timeLabel setFont:[UIFont systemFontOfSize:11]];
        [_timeLabel setTextAlignment:NSTextAlignmentCenter];
        [_timeLabel setBackgroundColor:[UIColor blackColor]];
        //[_timeLabel setAlpha:0.5];
        
        [_timeLabel release];
        
        self.nameLabel = [[UILabel alloc]init];
        [self addSubview:_nameLabel];
        [_nameLabel setFont:[UIFont systemFontOfSize:13]];
        [_nameLabel setNumberOfLines:0];
        [_nameLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_nameLabel setBackgroundColor:[UIColor clearColor]];
        
        [_nameLabel setText:@"精彩视频,即将上线"];
        [_nameLabel release];
        
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPressAction)];
        [_asImageView addGestureRecognizer:tap];
        [tap release];

        _markButton =[[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [_markButton setBackgroundImage:[UIImage imageNamed:@"close_x.png"] forState:UIControlStateNormal];
        [self addSubview:_markButton];
        [_markButton addTarget:self action:@selector(markButtonActionWithVideoID) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize mainSize = self.frame.size;
    _markButton.frame = CGRectMake(-10, -10, 40, 40);
    [_markButton setHidden:self.isHide];
    _asImageView.frame = CGRectMake(0, 0, mainSize.width, mainSize.height*3/4);
    [_asImageView setUserInteractionEnabled:self.isHide];
    _timeLabel.frame = CGRectMake(mainSize.width-50, _asImageView.frame.size.height-15, 50, 15);
    _nameLabel.frame = CGRectMake(0, mainSize.height*3/5+15, mainSize.width, mainSize.height*2/5);
}
-(void)tapPressAction
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tapThePictureGetVideoID:)]) {
        [self.delegate performSelector:@selector(tapThePictureGetVideoID:) withObject:self.videoID];
    }
}
-(void)markButtonActionWithVideoID
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(pressMakeButtonGetVideoID:)]) {
        [self.delegate performSelector:@selector(pressMakeButtonGetVideoID:) withObject:self.videoID];
    }
}
@end
