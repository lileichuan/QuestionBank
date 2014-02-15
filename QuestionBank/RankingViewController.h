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
    UIActivityIndicatorView* indicator;
}
@property(nonatomic, retain) UserInfo *userInfo;
@property(nonatomic, retain) UIActivityIndicatorView* indicator;
-(IBAction)switchRankIndex:(id)sender;
@end
