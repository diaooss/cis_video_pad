//
//  AuthorCell.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-21.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "AuthorCell.h"
#import "MyNsstringTools.h"
@interface AuthorCell()

@end
@implementation AuthorCell
-(void)dealloc
{
    [_subViewArry release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.subViewArry = [NSMutableArray arrayWithCapacity:2];
    }
    for (int i=0; i<4; i++) {
        AuthorView * view = [[AuthorView alloc]init];
        [view setDelegate:self];
        [self.subViewArry addObject:view];
        [self.contentView addSubview:view];
        [view release];
        [view setHidden:NO];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize mainSize = self.bounds.size;
    
    for (int j=0; j<4; j++) {
        AuthorView * view  = (AuthorView *)[self.subViewArry objectAtIndex:j];
        [view setIsHide:self.isHideMark];
        
        [view setFrame:CGRectMake(10+200*j,10, (mainSize.width-110)/4, 250)];
        [view layoutSubviews];
    }
}
-(void)tapThePictureGetAuthorID:(NSString *)ID
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getAuthorID:)]) {
        [self.delegate getAuthorID:ID];
    }
}
-(void)pressMakeButtonGetAuthorID:(NSString *)ID{
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(deleteOneAuthorByID:)]) {
        [self.delegate deleteOneAuthorByID:ID];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)addAuthorPictureWithNetArry:(NSArray *)netArry
{
    int mark = 0;
    //NSLog(@"+++++++%@",netArry );
    if ([netArry count]==0) {
        return;
    }
    for (AuthorView * obj in self.subViewArry) {
        
        if (mark<[netArry count]) {
            [obj.asyImage setImageURL:[[netArry objectAtIndex:mark]valueForKey:@"photo"]];
            [obj.nameLabel setText:[[netArry objectAtIndex:mark]valueForKey:@"author"]];//名字
            [obj.popularLabel setText:[NSString stringWithFormat:@"%@",[[netArry objectAtIndex:mark]valueForKey:@"popular"]]];//
            [obj.videoCountLabel setText:[NSString stringWithFormat:@"%@",[[netArry objectAtIndex:mark]valueForKey:@"opusCount"]]];//
            [obj setAuthorID:[[netArry objectAtIndex:mark]valueForKey:@"authorID"]];//ID;
        }else{
            [obj setHidden:YES];
        }
        mark++;
    }
}
@end
