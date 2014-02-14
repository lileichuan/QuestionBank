//
//  UserInfoViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-22.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UITableViewController<UITabBarControllerDelegate>{
    IBOutlet UIImageView *photoImageView;
    IBOutlet UITableView *infoTableView;
}
@property(nonatomic, retain) IBOutlet UIImageView *photoImageView;
@property(nonatomic, retain) IBOutlet UITableView *infoTableView;

@end
