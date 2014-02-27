//
//  RootViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-18.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainController"];
    //self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"userCenterController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self loadLoginViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadLoginViewController{
    [[UserInfo sharedUserInfo]closeUserInfo];
    LoginViewController  *viewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
}
@end
