//
//  MainViewController.m
//  QuestionBank
//
//  Created by hanbo on 14-2-19.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
 #import "QuestionDefine.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefaults objectForKey:@"user_ID"];
    if (!userID) {
        [self loadLoginViewController];
    }
    else{
        [self loadMainViewContoller];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadMainViewContoller) name:FINISHLOGIN object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadLoginViewController) name:LOGOUT object:nil];

}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:FINISHLOGIN object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:LOGOUT object:nil];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadLoginViewController{
    LoginViewController *loginViewController= [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginViewController animated:YES];
}
-(void)loadMainViewContoller{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    UITabBarController *tabBarController= [self.storyboard instantiateViewControllerWithIdentifier:@"TabViewController"];
    [self.navigationController pushViewController:tabBarController animated:YES];
}





@end
