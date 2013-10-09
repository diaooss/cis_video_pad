//
//  SetButton.m
//  Button
//
//  Created by huangfangwang on 13-9-17.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "SetButton.h"

@implementation SetButton
-(void)dealloc
{
    [self.nameLabel release];
    [self.leftImage release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.leftImage = [[UIImageView alloc]init];
    [_leftImage setContentMode:UIViewContentModeCenter];
    [self addSubview:_leftImage];
    [_leftImage release];
    
    self.nameLabel = [[UILabel alloc]init];
    [_nameLabel setTextAlignment:NSTextAlignmentLeft];
    [_nameLabel setFont:[UIFont systemFontOfSize:15]];
    [_nameLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_nameLabel];
    [_nameLabel release];
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_leftImage setFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    [_nameLabel setFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width-self.frame.size.height, self.frame.size.height)];
}
@end
