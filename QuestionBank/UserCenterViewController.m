//
//  UserCenterViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-6.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "UserCenterViewController.h"
#import "InterfaceService.h"
#import "UserInfo.h"
#import "UserInfoDao.h"
@interface UserCenterViewController ()

@end

@implementation UserCenterViewController
@synthesize userInfoDic;
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
    NSString *company = [userInfoDic objectForKey:@"company"];
    companyLabel.text = company;
    nameTextField.delegate = self;
    [nameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configureUserInfo:(NSDictionary *)userDic{
    self.userInfoDic = userDic;
  
}
-(IBAction)saveUserSetting:(id)sender{
    if (nameTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"考生姓名为空" delegate:nil cancelButtonTitle:@"重新设置" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    else{
        [nameTextField resignFirstResponder];
        CFUUIDRef uuidObj = CFUUIDCreate(nil);   //create a new UUID
        NSString *userID = (NSString *)CFUUIDCreateString(nil, uuidObj);
        CFRelease(uuidObj);
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:userID forKey:@"userID"];
        [userDefaults synchronize];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            InterfaceService *service = [[InterfaceService alloc]init];
            
            UserInfo *userInfo = [[UserInfo alloc]init];
            userInfo.userID = userID;
            userInfo.name = nameTextField.text;
            userInfo.company = companyLabel.text;
            BOOL success =  [service uploadUserInfo:userInfo];
            UserInfoDao *dao  =[[UserInfoDao alloc]init];
            [dao insertUser:userInfo];
            [dao release];
            if (success) {
                [userDefaults setBool:YES forKey:@"IsUploadUser"];
            }
            [service release];
            [userInfo release];
        });
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }

}
#pragma --mark-- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(id)sender
{

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{

    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{

}

//按回车键登录后回收键盘
-(BOOL)textFieldShouldReturn:(id)sender{
    [self saveUserSetting:nil];
    return YES;
}


@end
