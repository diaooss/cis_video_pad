//
//  Banner_view.m
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import "Banner_view.h"
#import "Tools_Header.h"
#import "AsynImageView.h"
@interface Banner_view()
//记载每一个banner的信息
@property(nonatomic,retain)NSMutableArray * bannerInfors;
@end
@implementation Banner_view
-(void)dealloc
{
    [self.bannerInfors release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化--bannerInfors
        self.bannerInfors = [NSMutableArray arrayWithCapacity:2];
        
        
        [self initSubview];
    }
    return self;
}
-(void)initSubview
{
   //创建一个banner动画
    iCarousel * icarView = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [icarView setDataSource:self];
//调节出镜的大小
    [icarView setPerspective:-1.0f/1200.0f];
    [icarView setType:iCarouselTypeRotary];
    [icarView setDelegate:self];
    [icarView setBackgroundColor:[UIColor redColor]];
    [self addSubview:icarView];
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 5;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index{
    
    AsynImageView * asimage = [[[AsynImageView alloc]initWithFrame:CGRectMake(0, 0, self.width/2, self.height)] autorelease];
    [asimage setPlaceholderImage:[UIImage imageNamed:@"test.png"]];
// 配置参数--图片的Url
    if ([self.inforArry count]>0) {
        [asimage setImageURL:[[self.inforArry objectAtIndex:index] valueForKey:@"picPath"]];
        [self.bannerInfors addObject:[[self.inforArry objectAtIndex:index] valueForKey:@"linkUrl"]];
    }
    //测试配置每一个banner的信息
    
    return asimage;
}-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    /*
    传递参数
     */
    if (self.delegate&&[self.delegate respondsToSelector:@selector(transferBannerInfor:)]) {
//#warning 参数暂且传递当前点击的id
        [self.delegate transferBannerInfor:[self.bannerInfors objectAtIndex:index]];
    }
}
@end
