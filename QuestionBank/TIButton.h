//
//  TIButton.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-18.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TIButton : UIButton{
    UIImageView *imageView;
    UILabel     *label;
}

-(void)setBtnTitle:(NSString *)title;


- (void)setBtnImage:(UIImage *)image;

@end
