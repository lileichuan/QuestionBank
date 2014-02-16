//
//  LoginViewController.m
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "LoginViewController.h"
#import "ProgressHUD.h"
#import "InterfaceService.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize dropButton,moveDownGroup,account_box,userNumber,userPassword,userLargeHead,numberLabel,passwordLabel;
@synthesize loginBtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [dropButton release];
    [moveDownGroup release];
    [account_box release];
    [userNumber release];
    [userPassword release];
    [userLargeHead release];
    [numberLabel release];
    [passwordLabel release];
    [loginBtn release];
    [super dealloc];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 1) {
        [userPassword resignFirstResponder];
        [userNumber resignFirstResponder];
       
    } else if (touch.tapCount == 2) {
        NSLog(@"touch 2 time!");
    }
}


- (IBAction)login:(id)sender{
    BOOL isValid = [self isContentValid];
    if (isValid) {
        
    }
}
- (IBAction)forgetPassword:(id)sender{
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    NSLog(@"shouldPerformSegueWithIdentifier");
    return YES;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue");
}

-(BOOL)isContentValid{
    BOOL success = NO;
    if (userNumber.text.length == 0 && passwordLabel.text.length == 0) {
        [ProgressHUD showError:@"用户名和密码为空"];
    }
    else if (userNumber.text.length == 0) {
        [ProgressHUD showError:@"用户名为空"];
    }
    else if(passwordLabel.text.length == 0){
        [ProgressHUD showError:@"密码为空"];
    }
    else{
        success = YES;
    }
    return success;
    
}
#pragma mark
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    BOOL isValid = [self isContentValid];
    if (isValid) {
        [userNumber resignFirstResponder];
        [userPassword resignFirstResponder];
    }
    return isValid;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (userPassword.text.length > 0 && userPassword.text.length > 0) {
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_red.png"] forState:UIControlStateNormal];
    }
    return YES;
}



@end
