//
//  SearchViewController.h
//  Video_game_Pad
//
//  Created by huanfang_liu on 13-10-8.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate,UISearchDisplayDelegate>
{
    UISearchBar*  _searchBar;
}

@end
