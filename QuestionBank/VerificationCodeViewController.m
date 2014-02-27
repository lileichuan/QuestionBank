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
#import "PhoneVerifyViewController.h"
#import "ResetPasswordViewController.h"
#import "LoginNavigationController.h"
@interface VerificationCodeViewController ()

@end

@implementation VerificationCodeViewController
@synthesize phoneNum,infoLabel,codeField,resendBtn,nextStep;
@synthesize countdownLabel;
@synthesize identifierCode;
@synthesize timer;
@synthesize isResetPassword;
@synthesize gotoRestPasswordBtn;
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
    NSString *info = [NSString stringWithFormat:@"我们已给你的手机号码%@发送了一条验证短信。",phoneNum];
    infoLabel.text = info;
    CGSize labelsize = [info sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    infoLabel.frame =CGRectMake(50.0,0, labelsize.width, labelsize.height);
    [codeField becomeFirstResponder];
    
    LoginNavigationController *navigationController = (LoginNavigationController *)self.navigationController;
    isResetPassword = navigationController.isResetPassword;
    if (isResetPassword) {
        gotoRestPasswordBtn.hidden = NO;
        nextStep.hidden = YES;
    }
    else{
        gotoRestPasswordBtn.hidden = YES;
        nextStep.hidden = NO;
    }
    [self startTimer];
}

-(void)dealloc{
    [self stopTimer];
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
    if (countdownLabel) {
        [countdownLabel removeFromSuperview];
        [countdownLabel release];
        countdownLabel = nil;
    }
    if (phoneNum) {
        [phoneNum release];
        phoneNum = nil;
    }
    if (identifierCode) {
        [identifierCode release];
        identifierCode = nil;
    }
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startTimer{
    leftTime = 120;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLeftTime:) userInfo:nil repeats:YES];
    resendBtn.hidden = YES;
    countdownLabel.hidden =  NO;
    countdownLabel.text = [NSString stringWithFormat:@"%ld秒",leftTime];
}

-(void)stopTimer{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    resendBtn.hidden = NO;
    countdownLabel.hidden =  YES;
}

-(void)updateLeftTime:(NSTimer *)_timer{
    leftTime --;
    if (leftTime == 0) {
        [self stopTimer];
      
    }
    countdownLabel.text = [NSString stringWithFormat:@"%ld秒",leftTime];
    
}

-(IBAction)resendCode:(id)sender{
    InterfaceService *service = [[InterfaceService alloc]init];
    [service getCaptchaWithPhoneNum:phoneNum];
    [service release];
    [self startTimer];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    InterfaceService *service = [[InterfaceService alloc]init];
    BOOL success = [service checkCaptchaWithPhoneNum:phoneNum withCaptcha:codeField.text
                    withIdentifier:identifierCode];
    [service release];
    return success;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
      [self stopTimer];
    if ([segue.identifier isEqualToString:@"RegisterViewController"]) {
        RegisterViewController *destViewController = segue.destinationViewController;
        destViewController.phoneNum = self.phoneNum;
      
    }
    if ([segue.identifier isEqualToString:@"ResetViewController"]) {
        ResetPasswordViewController  *destViewController = segue.destinationViewController;
        destViewController.phoneNum = self.phoneNum;
        destViewController.code = codeField.text;
        destViewController.identifier = identifierCode;
        [self stopTimer];
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
        [nextStep setImage:[UIImage imageNamed:@"nextStep_red"] forState:UIControlStateNormal];
    }
}
@end
