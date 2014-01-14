//
//  ExamInfoView.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-6.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "ExamInfoView.h"
#import "Catalog.h"
@implementation ExamInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {

        
      
    }
    return self;
}

-(void)awakeFromNib{
    enterExamBtn.layer.masksToBounds  = YES;
    enterExamBtn.layer.cornerRadius  = 3.0;
    
    [photoImageView.layer setMasksToBounds:YES];
    [photoImageView.layer setCornerRadius:CGRectGetHeight(photoImageView.frame)/2];
    photoImageView.layer.borderWidth = 2.0;
    photoImageView.layer.borderColor =  [UIColor grayColor].CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)configureUserInfo:(UserInfo *)userInfo{
    nameLabel.text = userInfo.name;
    companyLabel.text = userInfo.company;
    NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:[NSString stringWithFormat:@"%@.png",userInfo.userID]];
    if ([[NSFileManager defaultManager]fileExistsAtPath:photoPath]) {
          photoImageView.image = [UIImage imageWithContentsOfFile:photoPath];
    }
//    [photoImageView.layer setMasksToBounds:YES];
//    [photoImageView.layer setCornerRadius: (photoImageView.frame.size.height/2)];
//    photoImageView.layer.borderWidth = 5.0;
//    photoImageView.layer.borderColor =  [UIColor redColor].CGColor;
}
@end
