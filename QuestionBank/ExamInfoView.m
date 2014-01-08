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
        enterExamBtn.layer.masksToBounds  = YES;
        enterExamBtn.layer.cornerRadius  = 3.0;
    }
    return self;
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
  
}
@end
