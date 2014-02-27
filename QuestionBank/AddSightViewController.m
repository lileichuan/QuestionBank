//
//  AddSightViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-27.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "AddSightViewController.h"
#import "InterfaceService.h"
#import "UserInfo.h"

@interface AddSightViewController ()

@end

@implementation AddSightViewController

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

-(IBAction)cancel:(id)sender{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(IBAction)save:(id)sender{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    self.tabBarController.tabBar.hidden = NO;
    InterfaceService *service = [[InterfaceService alloc]init];
    UserInfo *curUserInfo = [UserInfo sharedUserInfo];
    NSDictionary *dic = @{@"userID":curUserInfo.userID,@"content":contentView.text};
    BOOL success =  [service addSight:dic];
    [service release];
    service = nil;
    if (success) {
        if (self.updateDataBlock) {
            self.updateDataBlock();
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
