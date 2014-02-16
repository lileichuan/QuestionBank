//
//  VerificationCodeViewController.m
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "VerificationCodeViewController.h"
#import "ProgressHUD.h"
#import "InterfaceService.h"
#import "RegisterViewController.h"
@interface VerificationCodeViewController ()

@end

@implementation VerificationCodeViewController
@synthesize phoneNum,infoLabel,codeField,resendBtn,nextStep;
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
    self.title = @"填写验证码";
    [infoLabel setNumberOfLines:0];
    infoLabel.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = CGSizeMake(320,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    NSString *info = [NSString stringWithFormat:@"我们已给你的手机号码%ld发送了一条验证短信。",phoneNum];
    infoLabel.text = info;
    CGSize labelsize = [info sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    infoLabel.frame =CGRectMake(50.0,0, labelsize.width, labelsize.height);
    
    [codeField becomeFirstResponder];
   }

-(void)dealloc{
    if (infoLabel) {
        [infoLabel removeFromSuperview];
        [infoLabel release];
        infoLabel = nil;
    }
    if (codeField) {
        [codeField removeFromSuperview];
        [codeField release];
        codeField = nil;
    }
    if (resendBtn) {
        [resendBtn removeFromSuperview];
        [resendBtn release];
        resendBtn = nil;
    }
    if (nextStep) {
        [nextStep removeFromSuperview];
        [nextStep release];
        nextStep = nil;
    }
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)nextStep:(id)sender{
    
}

-(IBAction)resendCode:(id)sender{
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    InterfaceService *service = [[InterfaceService alloc]init];
    BOOL success = [service checkCaptchaWithPhoneNum:phoneNum withCaptcha:[codeField.text integerValue]];
    [service release];
    return success;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"RegisterView"]) {
        RegisterViewController *destViewController = segue.destinationViewController;
        destViewController.phoneNum = self.phoneNum;
    }
}

#pragma mark
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.text.length > 6) {
        [ProgressHUD showError:@"验证码长度不可以大于6"];
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (codeField.text.length == 6) {
        [nextStep setBackgroundImage:[UIImage imageNamed:@"nextStep_red"] forState:UIControlStateNormal];
    }
}
@end
