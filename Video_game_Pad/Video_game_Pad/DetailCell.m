//
//  DetailCell.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "DetailCell.h"
#import "MyNsstringTools.h"
@interface DetailCell()


@end
@implementation DetailCell
-(void)dealloc
{
    
    [_PicArry dealloc];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }    self.PicArry = [NSMutableArray arrayWithCapacity:2];
#pragma mark---这个宽度和cell 的宽度一样!!!!!手动添加
    
    for (int i=0; i<4; i++) {
        DetailView * view = [[DetailView alloc]init];
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
        DetailView * view  = (DetailView *)[self.PicArry objectAtIndex:j];
        [view setIsHide:self.isHideMark];
        
        [view setFrame:CGRectMake(10+200*j,10, (mainSize.width-110)/4, 250)];
        [view layoutSubviews];
    }
    
}
-(void)addViodeoPictureWithNetArry:(NSArray *)netArry
{
    int mark = 0;
    //NSLog(@"+++++++%@",netArry );
    if ([netArry count]==0) {
        return;
    }
    for (DetailView * obj in self.PicArry) {
        
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
-(void)tapThePictureGetVideoID:(NSString *)ID
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(sendVideoID:)]) {
        [self.delegate performSelector:@selector(sendVideoID:) withObject:ID];
    }
}
-(void)pressMakeButtonGetVideoID:(NSString *)ID
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(deleteOneVideoByID:)]) {
        [self.delegate performSelector:@selector(deleteOneVideoByID:) withObject:ID];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
