//
//  Banner_view.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@protocol Banner_viewDelegate <NSObject>

-(void)transferBannerInfor:(NSString *)string;

@end
@interface Banner_view : UIView<iCarouselDataSource,iCarouselDelegate>

/*
 设置属性....加载图片要求的内容
 */
//创建一个代理
@property(nonatomic,assign)id<Banner_viewDelegate>delegate;
@end
