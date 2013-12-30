//
//  TopView.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-8.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TopView : UIImageView{
    UILabel  *title;
    UIButton *back;
}
@property(nonatomic, retain) UIButton *back;
@property(nonatomic, retain) UILabel  *title;
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
-(void)setReturnTitle:(NSString *)title;
@end
