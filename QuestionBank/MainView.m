//
//  MainView.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-21.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        [self setupTopView];
//        [self setupMainBtn];
    }
    return self;
}

-(void)setupTopView{
    UIImageView *titleImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.bounds),TOP_BAR_HEIGHT)];
    UIImage *image = [UIImage imageNamed:@"icon_title.png"];
    titleImageView.image = image;
    [self addSubview:titleImageView];
    [titleImageView release];
                                                                              
}

-(void)setupMainBtn{
    UIImageView *bgImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0,TOP_BAR_HEIGHT,CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds)- TOP_BAR_HEIGHT)];
    UIImage *image = [UIImage imageNamed:@"main_bg.png"];
    bgImageView.image = image;
    [self addSubview:bgImageView];
    [bgImageView release];
    
    float btnWidth  = 90;
    float btnHeigth = 103;
    float widthSpace = 80;
    float heightSpace = 25;
    CGPoint center = self.center;
    float startX = center.x - btnWidth  - (btnWidth /2);
    float startY = center.y - btnHeigth - heightSpace - (btnHeigth/2);
    
    if (!freedomExamBtn) {
        CGRect rect = CGRectMake(startX,startY,btnWidth,btnHeigth);
        freedomExamBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        freedomExamBtn.frame = rect;
        [freedomExamBtn setImage:[UIImage imageNamed:@"freedom_exam.png"] forState:UIControlStateNormal];
        freedomExamBtn.tag = FREEDOM_EXAM;
        [self addSubview:freedomExamBtn];
    }
    
    if (!wrongBookBtn) {
        CGRect rect = CGRectMake(CGRectGetMaxX(freedomExamBtn.frame) + widthSpace,startY,btnWidth,btnHeigth);
        wrongBookBtn =[UIButton  buttonWithType:UIButtonTypeCustom];
        wrongBookBtn.frame = rect;
        [wrongBookBtn setImage:[UIImage imageNamed:@"wrong_book.png"] forState:UIControlStateNormal];
        wrongBookBtn.tag = ERROR_BOOK;
        [self addSubview:wrongBookBtn];
    }
    
    if (!mockExamBtn) {
        CGRect rect = CGRectMake(CGRectGetMaxX(freedomExamBtn.frame),CGRectGetMaxY(freedomExamBtn.frame) + heightSpace,btnWidth,btnHeigth);
        mockExamBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        mockExamBtn.frame = rect;
        [mockExamBtn setImage:[UIImage imageNamed:@"mock_exam.png"] forState:UIControlStateNormal];
        mockExamBtn.tag = MOCK_EXAM;
        [self addSubview:mockExamBtn];
    }
    
    if (!starBookBtn) {
        CGRect rect = CGRectMake(startX,CGRectGetMaxY(mockExamBtn.frame) + heightSpace,btnWidth,btnHeigth);
        starBookBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        starBookBtn.frame = rect;
        [starBookBtn setImage:[UIImage imageNamed:@"star_book.png"] forState:UIControlStateNormal];
        starBookBtn.tag = START_BOOK;
        [self addSubview:starBookBtn];
    }
    
    if (!hotSpotBtn) {
        CGRect rect = CGRectMake(CGRectGetMaxX(starBookBtn.frame) + widthSpace,CGRectGetMaxY(mockExamBtn.frame) + heightSpace,btnWidth,btnHeigth);
        hotSpotBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        hotSpotBtn.frame = rect;
        [hotSpotBtn setImage:[UIImage imageNamed:@"hot_sport.png"] forState:UIControlStateNormal];
        hotSpotBtn.tag = HOT_SPORT;
        [self addSubview:hotSpotBtn];
    }
    
    float bottomBtnWidth = 100;
    float bottomBtnHeigth = 44;
    float bottomSpace = 60;
    if (!historyBtn) {
        CGRect rect = CGRectMake(bottomSpace,CGRectGetHeight(self.bounds) - bottomBtnHeigth,bottomBtnWidth,bottomBtnHeigth);
        historyBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        historyBtn.frame = rect;
        [historyBtn setImage:[UIImage imageNamed:@"hot_sport.png"] forState:UIControlStateNormal];
        historyBtn.tag = ANSWER_RECORD;
        [self addSubview:historyBtn];
    }
    
    if (!rankBtn) {
        CGRect rect = CGRectMake(CGRectGetWidth(self.bounds) - bottomSpace - bottomBtnWidth,CGRectGetHeight(self.bounds) - bottomBtnHeigth,bottomBtnWidth,bottomBtnHeigth);
        rankBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        rankBtn.frame = rect;
        [rankBtn setImage:[UIImage imageNamed:@"rank.png"] forState:UIControlStateNormal];
        rankBtn.tag = RANGKING;
        [self addSubview:rankBtn];
    }
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [mockExamBtn addTarget:target action:action forControlEvents:controlEvents];
    [freedomExamBtn addTarget:target action:action forControlEvents:controlEvents];
    [hotSpotBtn addTarget:target action:action forControlEvents:controlEvents];
    [wrongBookBtn addTarget:target action:action forControlEvents:controlEvents];
    [starBookBtn addTarget:target action:action forControlEvents:controlEvents];
    [historyBtn addTarget:target action:action forControlEvents:controlEvents];
    [rankBtn addTarget:target action:action forControlEvents:controlEvents];
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
