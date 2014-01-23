//
//  RankingViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-3.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "UserInfoDao.h"
@interface RankingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    
    UserInfo *userInfo;
}
@property(nonatomic, retain)  UserInfo *userInfo;
-(IBAction)switchRankIndex:(id)sender;
@end
