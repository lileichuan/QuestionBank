//
//  AddNewsViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-21.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "AddNewsViewController.h"
#import "InterfaceService.h"
#import "UserInfo.h"
#import "ProgressHUD.h"
@interface AddNewsViewController ()

@end

@implementation AddNewsViewController
@synthesize newsType;
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
    
        [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)add:(id)sender{
    if (textFiled.text.length == 0 || textView.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"标题或内空为空,请输入正确信息!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UserInfo *curUserInfo = [UserInfo sharedUserInfo];
        InterfaceService *service = [[InterfaceService alloc]init];
        NSDictionary *dic =@{@"user_id":curUserInfo.userID,@"company":curUserInfo.company,@"title":textFiled.text,@"content":textView.text,@"type":[NSNumber numberWithInteger:newsType]};
        BOOL success =  [service uploadNewsWithInfo:dic];
        if (success) {
            [ProgressHUD showSuccess:@"添加成功"];
        }
        else{
            [ProgressHUD showSuccess:@"添加失败"];
        }
        [service release];
        
    });
        [self.navigationController popViewControllerAnimated:YES];
}

@end
