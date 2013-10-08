//
//  MyView.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    backImage = [[UIImageView alloc]init];
    [backImage setImage:[UIImage imageNamed:@"test.png"]];
    [self addSubview:backImage];
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [backImage setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
+(UIEdgeInsets)contentViewInsets{
    return UIEdgeInsetsMake(0, 10, 0, 0);
}

+(CGFloat)arrowHeight{
    return 30.0;
}

+(CGFloat)arrowBase{
    return 42.0;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
