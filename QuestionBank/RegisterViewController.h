//
//  RegisterViewController.h
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController{
    NSString    *phoneNum;
    UITextField *nameField;
    UITextField *passwordField;
    NSInteger   sexFlag;
    UIButton    *saveBtn;
    UIButton    *maleBtn;
    UIButton    *femaleBtn;
    UIButton    *companyBtn;
}
@property(nonatomic, retain) NSString *phoneNum;
@property(nonatomic, retain) IBOutlet UITextField *nameField;
@property(nonatomic, retain) IBOutlet UITextField *passwordField;
@property(nonatomic, assign) NSInteger   sexFlag;
@property(nonatomic, retain) IBOutlet UIButton    *saveBtn;
@property(nonatomic, retain) IBOutlet UIButton    *maleBtn;
@property(nonatomic, retain) IBOutlet UIButton    *femaleBtn;
@property(nonatomic, retain) IBOutlet UIButton    *companyBtn;

-(IBAction)finishRegister:(id)sender;


-(IBAction)chooseSex:(id)sender;

@end
