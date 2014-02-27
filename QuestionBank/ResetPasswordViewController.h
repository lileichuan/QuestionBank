//
//  ResetPasswordViewController.h
//  QuestionBank
//
//  Created by hanbo on 14-2-22.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController{
    IBOutlet UITextField *passwordTextField;
    IBOutlet UIButton   *saveBtn;
    
    NSString *phoneNum;
    NSString *code;
    NSString *identifier;
}
@property(nonatomic, retain) IBOutlet UITextField *passwordTextField;
@property(nonatomic, retain) IBOutlet UIButton   *saveBtn;
@property(nonatomic, retain) NSString *phoneNum;
@property(nonatomic, retain) NSString *code;
@property(nonatomic, retain) NSString *identifier;
-(IBAction)finishRegister:(id)sender;

@end
