//
//  CategoryViewController.h
//  Video_game_Pad
//
//  Created by huangfangwang on 13-9-18.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
#import "CategoryCell.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
@interface CategoryViewController : UIViewController<EGORefreshTableDelegate,UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate,CategoryCellDelegate>
{
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;//状态提示
    
}
//通过作者列表加载视频
@property (nonatomic,assign)int flag;//请求的page值
@property (nonatomic,retain)NSMutableArray * allInforArry;//请求回来的所有视频
@property(nonatomic,copy)NSString * showCategory;//当前的分类
@property(nonatomic,copy)NSString * authorID;//作者的名字*****擦擦擦
-(void)addOneAuthorProductions;//请求数据方法
@end
