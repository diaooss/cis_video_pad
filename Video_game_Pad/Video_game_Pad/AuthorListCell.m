//
//  AuthorListCell.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "AuthorListCell.h"
#import "Tools_Header.h"
@implementation AuthorListCell

-(void)dealloc
{
    [self.authorName release];
    [self.authorPic release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    self.authorPic = [[AsynImageView alloc]init];
    [self.contentView addSubview:_authorPic];
    [_authorPic release];
    
    self.authorName = [[UILabel alloc]init];
    [self.contentView addSubview:_authorName];
    [_authorName release];
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_authorPic setFrame:CGRectMake(10, 0, self.height, self.height)];
    [_authorName setFrame:CGRectMake(_authorPic.right+20, self.height-40, self.width/3, 40)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
