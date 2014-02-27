//
//  SightViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-25.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "MJRefresh.h"

@interface SightViewController : UITableViewController{
    NSMutableArray   *dataArr;
    UserInfo     *curUserInfo;
    
     MJRefreshHeaderView *header;
}
@property(nonatomic, retain) NSMutableArray   *dataArr;
@property(nonatomic, retain) UserInfo     *curUserInfo;
@property(nonatomic, retain) MJRefreshHeaderView *header;



@end
