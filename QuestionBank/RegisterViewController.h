//
//  RegisterViewController.h
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController{
    NSInteger phoneNum;
    UITextField *nameField;
    UITextField *passwordField;
    UIButton    *saveBtn;
}
@property(nonatomic, assign) NSInteger phoneNum;
@property(nonatomic, retain) IBOutlet UITextField *nameField;
@property(nonatomic, retain) IBOutlet UITextField *passwordField;
@property(nonatomic, retain) UIButton    *saveBtn;

-(IBAction)finishRegister:(id)sender;

@end
