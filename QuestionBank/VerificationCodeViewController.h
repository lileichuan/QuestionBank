//
//  VerificationCodeViewController.h
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerificationCodeViewController : UIViewController<UITextFieldDelegate>{
    NSString *phoneNum;
    NSString *identifierCode;
    IBOutlet UILabel *infoLabel;
    IBOutlet UITextField *codeField;
    IBOutlet UIButton *resendBtn;
    IBOutlet UIButton *nextStep;
    IBOutlet UILabel  *countdownLabel;
    NSTimer  *timer;
    NSInteger leftTime;
    
    BOOL    isResetPassword;
    
   IBOutlet UIButton *gotoRestPasswordBtn;
    
}
@property(nonatomic, retain)NSString  *phoneNum;
@property(nonatomic, retain)IBOutlet UILabel *infoLabel;
@property(nonatomic, retain)IBOutlet UITextField *codeField;
@property(nonatomic, retain)IBOutlet UIButton *resendBtn;
@property(nonatomic, retain)IBOutlet UIButton *nextStep;
@property(nonatomic, retain)IBOutlet UILabel  *countdownLabel;
@property(nonatomic, retain)NSString *identifierCode;
@property(nonatomic, retain)NSTimer  *timer;
@property(nonatomic, assign)BOOL    isResetPassword;
@property(nonatomic, retain)IBOutlet UIButton *gotoRestPasswordBtn;

-(IBAction)nextStep:(id)sender;

-(IBAction)resendCode:(id)sender;

@end
