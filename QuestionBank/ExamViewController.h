//
//  ExamViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-1.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ExamViewController : UIViewController{
    
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *companyLabel;
    IBOutlet UIImageView *photoImageView;
    IBOutlet UIButton *enterExamBtn;
}

- (IBAction)showPhotoLibary:(id)sender;

- (IBAction)enterExamView:(id)sender;
@end
