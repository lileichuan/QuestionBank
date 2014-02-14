//
//  ExamInfoView.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-6.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
@interface ExamInfoView : UIView{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *companyLabel;
    IBOutlet UIImageView *photoImageView;
    IBOutlet UIButton *enterExamBtn;
}
@property(nonatomic, retain) IBOutlet UIImageView *photoImageView;
-(void)configureUserInfo:(UserInfo *)userInfo;

@end
