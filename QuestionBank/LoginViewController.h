//
//  LoginViewController.h
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>{
    UIButton *dropButton;
    UIView *moveDownGroup;
    UIView *account_box;
    
    UITextField *userNumber;
    UILabel *numberLabel;
    UITextField *userPassword;
    UILabel *passwordLabel;
    
    UIImageView *userLargeHead;
    
    UIButton  *loginBtn;

}
@property (retain, nonatomic) IBOutlet UIButton *dropButton;
@property (retain, nonatomic) IBOutlet UIView *moveDownGroup;
@property (retain, nonatomic) IBOutlet UIView *account_box;


@property (retain, nonatomic) IBOutlet UITextField *userNumber;
@property (retain, nonatomic) IBOutlet UILabel *numberLabel;
@property (retain, nonatomic) IBOutlet UITextField *userPassword;
@property (retain, nonatomic) IBOutlet UILabel *passwordLabel;

@property (retain, nonatomic) IBOutlet UIImageView *userLargeHead;
@property (nonatomic, retain) IBOutlet UIButton  *loginBtn;

- (IBAction)login:(id)sender;
- (IBAction)forgetPassword:(id)sender;


@end
