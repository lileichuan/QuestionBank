//
//  RegisterViewController.m
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "RegisterViewController.h"
#import "InterfaceService.h"
#import "CompanyViewController.h"
#import "ProgressHUD.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize phoneNum,nameField,passwordField,saveBtn,sexFlag;
@synthesize maleBtn,femaleBtn,companyBtn;

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
    self.title = @"用户注册";
}

-(void)dealloc{
    if (nameField) {
        [nameField removeFromSuperview];
        [nameField release];
        nameField = nil;
    }
    if (passwordField) {
        [passwordField removeFromSuperview];
        [passwordField release];
        passwordField = nil;
    }
    if (saveBtn) {
        [saveBtn removeFromSuperview];
        [saveBtn release];
        saveBtn = nil;
    }
    if (companyBtn) {
        [companyBtn removeFromSuperview];
        [companyBtn release];
        companyBtn = nil;
    }
    if (maleBtn) {
        [maleBtn removeFromSuperview];
        [maleBtn release];
        maleBtn = nil;
    }
    if (femaleBtn) {
        [femaleBtn removeFromSuperview];
        [femaleBtn release];
        femaleBtn = nil;
        
    }
    if (phoneNum) {
        [phoneNum release];
        phoneNum = nil;
    }
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)finishRegister:(id)sender{
    if (nameField.text ==  0 || passwordField.text == 0) {
        [ProgressHUD showError:@"用户名和密码不能为空!"];
        return;
    }
    if ([companyBtn.titleLabel.text isEqualToString:@"请选择您所在单位"]) {
         [ProgressHUD showError:@"您还没有选择单位!"];
        return;
    }
    InterfaceService *service = [[InterfaceService alloc]init];
    NSDictionary *dic = @{@"phoneNum":phoneNum,@"password":passwordField.text,@"company":companyBtn.titleLabel.text,@"name":nameField.text,@"sex":@(sexFlag)};
    // NSDictionary *dic = @{@"phoneNum":@"1111111",@"password":@"123",@"company":companyBtn.titleLabel.text,@"name":@"lileichuan",@"sex":@(sexFlag)};
    BOOL success = [service userRegister:dic];
    [service release];
    if (success) {
        [self loadMainViewController];
    }
}

-(IBAction)chooseSex:(id)sender{
    UIButton *btn = sender;
    if (btn.tag == 0) {
        [maleBtn setImage:[UIImage imageNamed:@"exercise_option_s"] forState:UIControlStateNormal];
        [femaleBtn setImage:[UIImage imageNamed:@"exercise_option_n"] forState:UIControlStateNormal];
    }
    else{
        [maleBtn setImage:[UIImage imageNamed:@"exercise_option_n"] forState:UIControlStateNormal];
        [femaleBtn setImage:[UIImage imageNamed:@"exercise_option_s"] forState:UIControlStateNormal];
    }
    sexFlag = btn.tag;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue");
    if ([segue.identifier isEqualToString:@"CompanyViewController"]) {
        CompanyViewController *destViewController = segue.destinationViewController;
        destViewController.chooseCompany = ^(NSString * companyName) {
            [self.companyBtn setTitle:companyName forState:UIControlStateNormal];
        };

    }
}

-(void)loadMainViewController{
    [[NSNotificationCenter defaultCenter]postNotificationName:FINISHLOGIN object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 1) {
        [nameField resignFirstResponder];
        [passwordField resignFirstResponder];
        
    } else if (touch.tapCount == 2) {
        NSLog(@"touch 2 time!");
    }
}
@end
