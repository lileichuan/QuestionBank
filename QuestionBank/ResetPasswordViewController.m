//
//  ResetPasswordViewController.m
//  QuestionBank
//
//  Created by hanbo on 14-2-22.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "InterfaceService.h"
#import "ProgressHUD.h"
@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController
@synthesize passwordTextField,saveBtn;
@synthesize phoneNum,code,identifier;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [passwordTextField release];
    [saveBtn release];
    [phoneNum release];
    [code release];
    [identifier release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)finishRegister:(id)sender{
    if (passwordTextField.text == 0) {
        [ProgressHUD showError:@"密码不能为空!"];
        return;
    }
    InterfaceService *service = [[InterfaceService alloc]init];
    NSDictionary *dic = @{@"phoneNum":phoneNum,@"password":passwordTextField.text,@"code":code,@"identifier":identifier};
    // NSDictionary *dic = @{@"phoneNum":@"1111111",@"password":@"123",@"company":companyBtn.titleLabel.text,@"name":@"lileichuan",@"sex":@(sexFlag)};
    BOOL success = [service findPassword:dic];
    [service release];
    if (success) {
        [self loadMainViewController];
    }
}

-(void)loadMainViewController{
    [[NSNotificationCenter defaultCenter]postNotificationName:FINISHLOGIN object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
