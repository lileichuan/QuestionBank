//
//  BottomView.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-8.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
          self.backgroundColor = [UIColor colorWithRed:156/255.0 green:28/255.5 blue:27/255.0 alpha:1.0];
        [self addBtns];
    }
    return self;
}

-(void)addBtns{
    float height =42;
    float width = 42;
    float space = 10;
    float startY =CGRectGetHeight(self.bounds) - height - 6;
    if (!leftBtn) {
        CGRect preBtnRect = CGRectMake(space,startY,width, height);
        leftBtn = [TIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = preBtnRect;
        leftBtn.tag = ANSWER_LIST;
        [self addSubview:leftBtn];
        [leftBtn release];
    }
    if (!rightBtn) {
        CGRect preBtnRect = CGRectMake(CGRectGetMaxX(self.frame) -width - space ,startY,width, height);
        rightBtn = [TIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = preBtnRect;
        rightBtn.tag = RANGKING;
        [self addSubview:rightBtn];
        [rightBtn release];
    }
}
-(void)setLeftImage:(UIImage *)image withTitle:(NSString *)title{
    [leftBtn setBtnImage:image];
    [leftBtn setBtnTitle:title];
}
-(void)setRightImage:(UIImage *)image withTitle:(NSString *)title{
    [rightBtn setBtnImage:image];
    [rightBtn setBtnTitle:title];

}
-(void)setLeftImage:(UIImage *)image{
    [leftBtn setBtnImage:image];

}
-(void)setRightImage:(UIImage *)image{
     [rightBtn setBtnImage:image];
}
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [leftBtn addTarget:target action:action forControlEvents:controlEvents];
    [rightBtn addTarget:target action:action forControlEvents:controlEvents];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
