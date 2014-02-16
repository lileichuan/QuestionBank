//
//  VerificationCodeViewController.h
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerificationCodeViewController : UIViewController<UITextFieldDelegate>{
    NSInteger phoneNum;
    IBOutlet UILabel *infoLabel;
    IBOutlet UITextField *codeField;
    IBOutlet UIButton *resendBtn;
    IBOutlet UIButton *nextStep;
    
}
@property(nonatomic, assign)NSInteger phoneNum;
@property(nonatomic, retain)IBOutlet UILabel *infoLabel;
@property(nonatomic, retain)IBOutlet UITextField *codeField;
@property(nonatomic, retain)IBOutlet UIButton *resendBtn;
@property(nonatomic, retain)IBOutlet UIButton *nextStep;

-(IBAction)nextStep:(id)sender;

-(IBAction)resendCode:(id)sender;
@end
