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
#import "ViewController.h"
#import "Catalog.h"
#import "ProgressHUD.h"
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
-(void)dealloc{
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [photoImageView.layer setMasksToBounds:YES];
    [photoImageView.layer setCornerRadius:photoImageView.frame.size.height/2];
    [photoImageView.layer setMasksToBounds:YES];
    [photoImageView setContentMode:UIViewContentModeScaleAspectFill];
    [photoImageView setClipsToBounds:YES];
    photoImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    photoImageView.layer.shadowOffset = CGSizeMake(4, 4);
    photoImageView.layer.shadowOpacity = 0.5;
    photoImageView.layer.shadowRadius = 2.0;
    photoImageView.layer.borderColor = [[UIColor blackColor] CGColor];
    photoImageView.layer.borderWidth = 2.0f;
    photoImageView.userInteractionEnabled = YES;

    
	// Do any additional setup after loading the view.
    NSString *company = [userInfoDic objectForKey:@"company"];
    companyLabel.text = company;
    nameTextField.delegate = self;
    [nameTextField becomeFirstResponder];
    UserInfo *curUserInfo = [UserInfo sharedUserInfo];
    if (curUserInfo) {
        nameTextField.text = curUserInfo.name;
        NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:curUserInfo.photoName];
        photoImageView.image = [UIImage imageWithContentsOfFile:photoPath];
    }
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
        UserInfo *curUserInfo = [UserInfo sharedUserInfo];
        BOOL isNewUser = NO;
        if (!curUserInfo) {
            CFUUIDRef uuidObj = CFUUIDCreate(nil);   //create a new UUID
            NSString *userID = (NSString *)CFUUIDCreateString(nil, uuidObj);
            CFRelease(uuidObj);
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:userID forKey:@"user_ID"];
            [userDefaults synchronize];
            curUserInfo = [[UserInfo alloc]init];
            curUserInfo.userID =userID;
            isNewUser = YES;
        }

        NSData *imageData = UIImagePNGRepresentation(photoImageView.image);
        if(imageData != nil)
        {
            imageData = UIImageJPEGRepresentation(photoImageView.image, 1.0);
        }
        NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:curUserInfo.photoName];
        [imageData writeToFile:photoPath atomically:YES];
        
        curUserInfo.name = nameTextField.text;
        curUserInfo.company = companyLabel.text;
        UserInfoDao *dao  =[[UserInfoDao alloc]init];
        if (isNewUser) {
             [dao insertUser:curUserInfo];
        }
        else{
            [dao updateUserInfo:curUserInfo];
        }
        [dao release];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            InterfaceService *service = [[InterfaceService alloc]init];
            NSDictionary *info = @{@"userID":curUserInfo.userID,@"photoPath":photoPath};
            BOOL success =  [service uploadPhoto:info];
            [service release];
            if (success) {
                [ProgressHUD showSuccess:@"添加成功"];
            }
            else{
                [ProgressHUD showSuccess:@"添加失败"];
            }
        });
        [[UserInfo sharedUserInfo]closeUserInfo];
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"FinishRegist" object:nil];
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


#pragma mark
#pragma mark 切换头像

- (IBAction)handleTableviewCellLongPressed:(UITapGestureRecognizer *)gestureRecognizer {
    UIActionSheet* actionsheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照",@"从相册中选取",nil];
    
    actionsheet.delegate = self;
    [actionsheet showInView:self.view];
    [actionsheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex is:%d",buttonIndex);
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerControllerSourceType sourceType;
    //判断是否有摄像头
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        if(![UIImagePickerController isSourceTypeAvailable:sourceType])
        {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    else if(buttonIndex == 1){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;   // 设置委托
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];  //需要以模态的形式展示
    [imagePickerController release];
}
#pragma mark -
#pragma mark UIImagePickerController Method
//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //获取图片的url
    UIImage *photoImage =[image scaleToSize:image size:CGSizeMake(image.size.width / 5, image.size.height / 5)];
    photoImageView.image = photoImage;
}
//用户取消拍照
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
