//
//  HotspotViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-1.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "HotspotViewController.h"
#import "TopView.h"
@interface HotspotViewController ()<UIWebViewDelegate>{
    UIWebView  *webView;
    TopView    *topView;
}

@end

@implementation HotspotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addTopBarView];
    [self addWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [super dealloc];
}

-(void)addTopBarView{
    if (!topView) {
        CGRect topRect =   CGRectMake(0, 0,CGRectGetWidth(self.view.bounds), TOP_BAR_HEIGHT);
        topView = [[TopView alloc]initWithFrame:topRect];
        [topView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:topView];
        [topView  release];
    }
    topView.title.text = @"热点问答";
}


-(void)addWebView{
    CGRect contentRect =   CGRectMake(0, TOP_BAR_HEIGHT,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - TOP_BAR_HEIGHT );
    if (!webView) {
        webView = [[UIWebView alloc]initWithFrame:contentRect];
        [self.view addSubview:webView];
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
