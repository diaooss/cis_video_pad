//
//  MainViewController.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate>
{
    UITableView *mainTab;
    RequestTools*recommendRequest;//推荐
    
    
}
@property(nonatomic,assign)int mark;
@property(nonatomic,retain)NSArray *bannerArry;
@property(nonatomic,retain)NSArray *tabArry;
@property(nonatomic,retain)NSDictionary * classDic;
@end
