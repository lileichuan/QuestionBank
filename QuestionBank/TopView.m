//
//  TopView.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-8.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "TopView.h"

@implementation TopView
@synthesize title,back;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        self.userInteractionEnabled = YES;
        UIImage *image = [[UIImage imageNamed:@"top_bar_line.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:3];
        self.image = image;
        
        back = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *bgImage =[UIImage imageNamed:@"back_bg.png"];
        CGSize imageSize = bgImage.size;
        back.frame = CGRectMake(10,CGRectGetHeight(self.bounds)/2 - imageSize.height/2,imageSize.width,imageSize.height);
        back.titleLabel.textAlignment = NSTextAlignmentCenter;
        [back setBackgroundImage:bgImage forState:UIControlStateNormal];
        [back setTitle:@"返回" forState:UIControlStateNormal];
        [back.titleLabel setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:14]];
        [self addSubview:back];
        
        title  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) / 2 - 70, 0, 140,CGRectGetHeight(self.bounds))];
        //title.font = [UIFont systemFontOfSize:13];
        title.textAlignment = NSTextAlignmentCenter;
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.userInteractionEnabled = YES;
        UIImage *image = [[UIImage imageNamed:@"top_bar_line.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:3];
        self.image = image;
        
        back = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *bgImage =[UIImage imageNamed:@"back_bg.png"];
        CGSize imageSize = bgImage.size;
        back.frame = CGRectMake(10,CGRectGetHeight(self.bounds)/2 - imageSize.height/2,imageSize.width,imageSize.height);
        back.titleLabel.textAlignment = NSTextAlignmentCenter;
        [back setBackgroundImage:bgImage forState:UIControlStateNormal];
        [back setTitle:@"返回" forState:UIControlStateNormal];
        [back.titleLabel setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:14]];
        [self addSubview:back];
        
        title  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) / 2 - 70, 0, 140,CGRectGetHeight(self.bounds))];
        //title.font = [UIFont systemFontOfSize:13];
        title.textAlignment = NSTextAlignmentCenter;
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
    }
    NSLog(@"aDecoder");
    return self;
}

//-(void)layoutSubviews{
//
//}
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [back addTarget:target action:action forControlEvents:controlEvents];
}

-(void)setReturnTitle:(NSString *)_title{
     [back setTitle:_title forState:UIControlStateNormal];
}
-(void)dealloc{
    if (title) {
        [title removeFromSuperview];
        [title release];
        title = nil;
    }
    [super dealloc];
}



@end
