//
//  PhoneVerifyViewController.m
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "PhoneVerifyViewController.h"
#import "ProgressHUD.h"
#import "VerificationCodeViewController.h"
#import "InterfaceService.h"
#import "LoginNavigationController.h"
#import "UserInfo.h"
@interface PhoneVerifyViewController ()

@end

@implementation PhoneVerifyViewController
@synthesize phoneNumField,nextStepBtn,identifierCode;
@synthesize isRestPassword;
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
	// Do any additional setup after loading the view.
    self.title = @"验证手机号码";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    //self.navigationController.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.leftBarButtonItem = backItem;
    [backItem release];
    [phoneNumField becomeFirstResponder];
    LoginNavigationController *navigationController = (LoginNavigationController *)self.navigationController;
    BOOL isResetPassword = navigationController.isResetPassword;
    if (isResetPassword) {
        UserInfo *curUserInfo = [UserInfo sharedUserInfo];
        if (curUserInfo) {
            phoneNumField.text = curUserInfo.loginName;
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
  
}

-(void)dealloc{
    if (phoneNumField) {
        [phoneNumField release];
        phoneNumField = nil;
    }
    if (nextStepBtn) {
        [nextStepBtn release];
        nextStepBtn = nil;
    }
    if (identifierCode) {
        [identifierCode release];
        identifierCode = nil;
    }
    [super dealloc];
}

-(void)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToLogin:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)nextStep:(id)sender{
    if (phoneNumField.text.length == 0) {
        [ProgressHUD showError:@"手机号为空"];
    }
    else if(phoneNumField.text.length != 11){
        [ProgressHUD showSuccess:@"手机号不合法"];
    }
    else{
        
    }
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    NSLog(@"shouldPerformSegueWithIdentifier");
    BOOL success =  NO;
    if (phoneNumField.text.length == 0) {
        [ProgressHUD showError:@"手机号为空"];
        return NO;
    }
    else if(phoneNumField.text.length != 11){
        [ProgressHUD showSuccess:@"手机号不合法"];
        return NO;
    }
    else{
        InterfaceService *service = [[InterfaceService alloc]init];
        self.identifierCode =  [service getCaptchaWithPhoneNum:phoneNumField.text];
        if (identifierCode) {
            success = YES;
        }
        [service release];
        
    }
    return success;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue");
    if ([segue.identifier isEqualToString:@"VerifyCode"]) {
        VerificationCodeViewController *destViewController = segue.destinationViewController;
        destViewController.phoneNum = phoneNumField.text;
        destViewController.identifierCode = self.identifierCode;
    }
}

#pragma mark
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.text.length > 11) {
        return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (phoneNumField.text.length == 11) {
        [nextStepBtn setImage:[UIImage imageNamed:@"nextStep_red"] forState:UIControlStateNormal];
    }
    else{
         [nextStepBtn setImage:[UIImage imageNamed:@"nextStep_white"] forState:UIControlStateNormal];
    }
    if (textField.text.length > 11) {
        return NO;
    }
    return YES;
}
@end
