//
//  MyCompanyViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-20.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
@interface MyCompanyViewController : UITableViewController<UIAlertViewDelegate>{
    UserInfo *curUserInfo;
    
}
@property(nonatomic, retain) UserInfo *curUserInfo;

@end
