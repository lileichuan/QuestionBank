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
@synthesize photoImageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 84, 84)];
        photoImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        photoImageView.layer.masksToBounds = YES;
        photoImageView.layer.cornerRadius = 50.0;
        photoImageView.layer.borderColor = [UIColor grayColor].CGColor;
        photoImageView.layer.borderWidth = 3.0f;
        photoImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        photoImageView.layer.shouldRasterize = YES;
        photoImageView.clipsToBounds = YES;
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    NSLog(@"photoImageView 0000000000000 is%f,%f,%f,%f",photoImageView.frame.origin.x,photoImageView.frame.origin.y,photoImageView.frame.size.width,photoImageView.frame.size.height);
    }
    return self;
}

-(void)dealloc{
    if (photoImageView) {
        [photoImageView release];
    }
    [super dealloc];
}
-(void)awakeFromNib{
//    enterExamBtn.layer.masksToBounds  = YES;
//    enterExamBtn.layer.cornerRadius  = 3.0;
    NSLog(@"photoImageView frame111111111 is%f,%f,%f,%f",photoImageView.frame.origin.x,photoImageView.frame.origin.y,photoImageView.frame.size.width,photoImageView.frame.size.height);
    self.photoImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
     self.photoImageView.layer.masksToBounds = YES;
     self.photoImageView.layer.cornerRadius = 50.0;
     self.photoImageView.layer.borderColor = [UIColor grayColor].CGColor;
     self.photoImageView.layer.borderWidth = 3.0f;
     self.photoImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
     self.photoImageView.layer.shouldRasterize = YES;
     self.photoImageView.clipsToBounds = YES;

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
