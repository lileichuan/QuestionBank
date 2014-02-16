//
//  RegisterViewController.m
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "RegisterViewController.h"
#import "InterfaceService.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize phoneNum,nameField,passwordField,saveBtn;

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
}

-(void)dealloc{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)finishRegister:(id)sender{
    InterfaceService *service = [[InterfaceService alloc]init];
    NSDictionary *dic = @{@"phoneNum":@(phoneNum),@"password":@(12345),@"company":@"方正",@"name":@"李雷川",@"sex":@(1)};
    BOOL success = [service userRegister:dic];
    [service release];
    if (success) {
        
    }
}
@end
