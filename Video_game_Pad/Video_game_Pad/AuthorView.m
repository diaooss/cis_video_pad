//
//  AuthorView.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "AuthorView.h"
#import "Tools_Header.h"
@interface AuthorView ()
{
    UIButton * _markButton;
}
@end
@implementation AuthorView
-(void)dealloc
{
    [_authorID release];
    [_videoCountLabel release];
    [_popularLabel release];
    [_nameLabel release];
    [_asyImage release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.asyImage = [[AsynImageView alloc]init];
    [self addSubview:_asyImage];
    [_asyImage setBackgroundColor:[UIColor redColor]];
    [_asyImage release];
    
    self.nameLabel = [[UILabel alloc]init];
    [self addSubview:_nameLabel];
    [_nameLabel setText:@"ADIAOSI"];
    [_nameLabel setBackgroundColor:[UIColor blueColor]];
    [_nameLabel release];
    
    self.popularLabel = [[UILabel alloc]init];
    [_popularLabel setText:@"👍100"];
    [self addSubview:_popularLabel];
    [_popularLabel setBackgroundColor:[UIColor grayColor]];
    [_popularLabel release];
    
    self.videoCountLabel = [[UILabel alloc]init];
    [_videoCountLabel setText:@"😍200"];
    [self addSubview:_videoCountLabel];
    [_videoCountLabel setBackgroundColor:[UIColor yellowColor]];
    [_videoCountLabel release];

    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPressAction)];
    [_asyImage addGestureRecognizer:tap];
    [tap release];
    
    _markButton =[[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [_markButton setBackgroundImage:[UIImage imageNamed:@"close_x.png"] forState:UIControlStateNormal];
    [self addSubview:_markButton];
    [_markButton addTarget:self action:@selector(markButtonActionWithVideoID) forControlEvents:UIControlEventTouchUpInside];
    return self;
}
-(void)tapPressAction
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(tapThePictureGetAuthorID:)]) {
        [self.delegate performSelector:@selector(tapThePictureGetAuthorID:) withObject:self.authorID];
    }
    
}
-(void)markButtonActionWithVideoID
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(pressMakeButtonGetAuthorID:)]) {
        [self.delegate performSelector:@selector(pressMakeButtonGetAuthorID:) withObject:self.authorID];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_markButton setHidden:self.isHide];
    _markButton.frame = CGRectMake(-10, -10, 40, 40);
    [_asyImage setFrame:CGRectMake(0, 0, self.width, self.height*3/4)];
    [_asyImage setUserInteractionEnabled:self.isHide];
    [_popularLabel setFrame:CGRectMake(0, _asyImage.height-20, self.width/2, 20)];
    [_videoCountLabel setFrame:CGRectMake(self.width/2,_asyImage.height-20, self.width/2, 20)];
    [_nameLabel setFrame:CGRectMake(0, _asyImage.bottom, self.width, self.width*1/4)];
}
@end
