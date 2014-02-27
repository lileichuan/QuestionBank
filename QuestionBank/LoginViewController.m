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
#import "PhoneVerifyViewController.h"
#import "LoginNavigationController.h"
#import "Catalog.h"
#import "UserInfoDao.h"

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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefaults objectForKey:@"user_ID"];
    if (userID) {
        UserInfoDao *dao = [[UserInfoDao alloc]init];
        UserInfo    *curUserInfo = [dao getUserWithID:userID];
        if (curUserInfo) {
            userNumber.text = curUserInfo.loginName;
            userPassword.text = curUserInfo.password;
            NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:curUserInfo.photoName];
            userLargeHead.image = [UIImage imageWithContentsOfFile:photoPath];
        }
    }
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
        [userNumber resignFirstResponder];
        [userPassword resignFirstResponder];
        InterfaceService *service = [[InterfaceService alloc]init];
        NSDictionary *userInfo = @{@"name":userNumber.text,@"password":userPassword.text};
        BOOL success = [service userLogin:userInfo];
        [service release];
        if (success) {
            [[NSNotificationCenter defaultCenter]postNotificationName:FINISHLOGIN object:nil];
            [self dismissViewControllerAnimated:NO completion:nil];
        }

    }
}
- (IBAction)forgetPassword:(id)sender{
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    NSLog(@"shouldPerformSegueWithIdentifier");
    return YES;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

-(BOOL)isContentValid{
    BOOL success = NO;
    if (userNumber.text.length == 0 && passwordLabel.text.length == 0) {
        [ProgressHUD showError:@"用户名和密码为空"];
    }
    else if (userNumber.text.length == 0) {
        [ProgressHUD showError:@"用户名为空"];
    }
    else if(userPassword.text.length == 0){
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
//    if (userPassword.text.length > 0 && userPassword.text.length > 0) {
//    [loginBtn setImage:[UIImage imageNamed:@"login_btn_red.png"] forState:UIControlStateNormal];
//    }
    return YES;
}



@end
