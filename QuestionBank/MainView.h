//
//  MainView.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-21.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIButton.h"
@interface MainView : UIView{
    UIButton   *mockExamBtn;
    UIButton   *freedomExamBtn;
    UIButton   *wrongBookBtn;
    UIButton   *hotSpotBtn;
    UIButton   *starBookBtn;
    
    UIButton   *historyBtn;
    UIButton   *rankBtn;

}
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
