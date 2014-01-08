//
//  ExamViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-1.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExamInfoView.h"
@interface ExamViewController : UIViewController{
    IBOutlet ExamInfoView  *infoView;
}

- (IBAction)handleTableviewCellLongPressed:(UITapGestureRecognizer *)gestureRecognizer;
- (IBAction)addQuestionBrowserView:(id)sender;
@end
