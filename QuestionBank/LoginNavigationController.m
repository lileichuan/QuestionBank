//
//  LoginNavigationController.m
//  QuestionBank
//
//  Created by hanbo on 14-2-22.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "LoginNavigationController.h"

@interface LoginNavigationController ()

@end

@implementation LoginNavigationController
@synthesize isResetPassword;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
