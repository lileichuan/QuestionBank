//
//  FeedbackViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-18.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController<UITextViewDelegate>{
    IBOutlet UITextView *textView;
    IBOutlet UIButton   *submitBtn;
}

-(IBAction)submitFeedback:(id)sender;

-(IBAction)openJizheHome:(id)sender;
@end
