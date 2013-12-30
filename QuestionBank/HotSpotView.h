//
//  HotSpotView.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-18.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
#import "ViewController.h"
@interface HotSpotView : UIWebView<UIWebViewDelegate>{
    UIWebView  *webView;
    TopView    *topView;
}
@property (nonatomic,copy) dispatch_block_t exitBlock;
@end
