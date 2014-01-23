//
//  UserCenterViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-6.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageExt.h"

@interface UserCenterViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>{
    IBOutlet UITextField  *nameTextField;
    IBOutlet UILabel      *companyLabel;
    IBOutlet UIImageView  *photoImageView;
    
    NSDictionary   *userInfoDic;
}
@property(nonatomic, retain)NSDictionary   *userInfoDic;
@property(nonatomic, copy) dispatch_block_t saveBlock;

-(void)configureUserInfo:(NSDictionary *)userDic;

-(IBAction)saveUserSetting:(id)sender;

- (IBAction)handleTableviewCellLongPressed:(UITapGestureRecognizer *)gestureRecognizer;
@end
