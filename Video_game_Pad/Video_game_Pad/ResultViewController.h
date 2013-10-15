//
//  ResultViewController.h
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-11.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
#import "SearchCell.h"
@interface ResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate,SearchCellDelegate>
{
    UITableView *searchResultTab;
    
}
@property(nonatomic,copy)NSString *keyWordStr;
@end
