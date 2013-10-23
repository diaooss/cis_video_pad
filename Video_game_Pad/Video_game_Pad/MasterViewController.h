//
//  MasterViewController.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-10-17.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
@interface MasterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)DetailViewController * detail;
@end
