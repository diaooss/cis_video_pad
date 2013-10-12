//
//  ListViewController.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
@interface ListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,myHttpRequestDelegate>
{
    UITableView * _authorListTab;
}
@property(nonatomic,copy)NSString * category;
-(void)requestAuthorListWithCategory:(NSString *)name;
@end
