//
//  FeedbackViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-18.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "FeedbackViewController.h"
#import "InterfaceService.h"
#import "UserInfo.h"
@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

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
	// Do any additional setup after loading the view.å®
    //textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    //textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textView.delegate = self;
    //[textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)submitFeedback:(id)sender{
    InterfaceService *service = [[InterfaceService alloc]init];
    UserInfo *curUserInfo = [UserInfo sharedUserInfo];
    NSDictionary *infoDic = nil;
    if (curUserInfo) {
        infoDic = @{@"user_id":curUserInfo.userID,@"content":textView.text};
    }
    else{
        infoDic = @{@"content":textView.text};
    }
    [service feedbackWithContent:infoDic];
    [service release];
    [textView resignFirstResponder];
}
#pragma mark
#pragma mark UITextFieldDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{

}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
}

-(IBAction)openJizheHome:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jizhehome.com/"]];
}

@end
