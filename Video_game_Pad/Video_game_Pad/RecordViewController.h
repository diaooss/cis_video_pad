//
//  RecordViewController.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _recordTab;
    UIButton *eiditBtn;
}
@property (nonatomic ,retain)NSMutableArray * recordArry;
@end
