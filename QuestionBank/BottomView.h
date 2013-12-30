//
//  BottomView.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-8.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIButton.h"
@interface BottomView : UIView{
    TIButton   *leftBtn;
    TIButton   *rightBtn;
}
-(void)setLeftImage:(UIImage *)image withTitle:(NSString *)title;
-(void)setRightImage:(UIImage *)image withTitle:(NSString *)title;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
