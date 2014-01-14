//
//  CompanyViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-6.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

-(IBAction)addCompany:(id)sender;

-(IBAction)closeSetting:(id)sender;
@end
