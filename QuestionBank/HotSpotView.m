//
//  HotSpotView.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-18.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "HotSpotView.h"

@implementation HotSpotView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addTopBarView];
        [self addWebView];
    }
    return self;
}
-(void)dealloc{
    [super dealloc];
}
-(void)addTopBarView{
    if (!topView) {
        CGRect topRect =   CGRectMake(0, 0,CGRectGetWidth(self.bounds), TOP_BAR_HEIGHT);
        topView = [[TopView alloc]initWithFrame:topRect];
        [topView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:topView];
        [topView  release];
    }
    topView.title.text = @"模拟考试";
}


-(void)addWebView{
    CGRect contentRect =   CGRectMake(0, TOP_BAR_HEIGHT,CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - TOP_BAR_HEIGHT );
    if (!webView) {
        webView = [[UIWebView alloc]initWithFrame:contentRect];
        [self addSubview:webView];
        [webView release];
    }
    NSString *docPath = [[NSBundle mainBundle]pathForResource:@"HotSpot" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:docPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    webView.multipleTouchEnabled = YES;
    [webView loadRequest:request];
}

-(void)close{
    if (self.exitBlock) {
        self.exitBlock();
    }
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
