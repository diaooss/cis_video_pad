//
//  SearchViewController.h
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-8.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"

@interface SearchViewController : UIViewController<UISearchBarDelegate,myHttpRequestDelegate>
{
    UISearchBar*  _searchBar;
    RequestTools *hotWordRequest;//请求热词

}
@property(nonatomic,retain)NSDictionary *hotWordDic;
@end
