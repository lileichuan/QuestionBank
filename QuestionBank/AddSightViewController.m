//
//  AddSightViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-27.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "AddSightViewController.h"

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
}

-(IBAction)save:(id)sender{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
