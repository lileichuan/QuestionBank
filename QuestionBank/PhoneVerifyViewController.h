//
//  PhoneVerifyViewController.h
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneVerifyViewController : UIViewController<UITextFieldDelegate>{
    IBOutlet UITextField *phoneNumField;
    IBOutlet UIButton    *nextStepBtn;
}
@property(nonatomic, retain) IBOutlet UITextField *phoneNumField;
@property(nonatomic, retain) IBOutlet UIButton    *nextStepBtn;
-(IBAction)nextStep:(id)sender;
@end
