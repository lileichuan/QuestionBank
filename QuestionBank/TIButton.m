//
//  TIButton.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-18.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "TIButton.h"

@implementation TIButton

//+ (id)buttonWithType:(UIButtonType)buttonType{
//    self = [super buttonWithType:buttonType];
//    if (self) {
//    
//    }
//    return self;
//
//}
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        //[self addSubviewsWithFrame:frame];
//
//    }
//    return self;
//}

//-(void)setFrame:(CGRect)frame{
//    //[self addSubviewsWithFrame:frame];
//}

-(void)addSubviewsWithFrame:(CGRect)frame{

    
    

}

-(void)dealloc{
    [super dealloc];
}

-(void)setBtnTitle:(NSString *)title{
    if (!label) {
        CGRect labelRect = CGRectMake(0,CGRectGetMaxY(self.frame) - 8,CGRectGetWidth(self.frame),10);
        label = [[UILabel alloc]initWithFrame:labelRect];
        label.font =[UIFont systemFontOfSize:10];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label release];
    }
    label.text = title;
}


- (void)setBtnImage:(UIImage *)image{
//    if (!imageView) {
//        CGRect imageRect = CGRectMake(0,0,CGRectGetWidth(self.frame),CGRectGetHeight(self.frame) -10);
//        imageView = [[UIImageView alloc]initWithFrame:imageRect];
//        imageView.contentMode = UIViewContentModeCenter;
//        [self addSubview:imageView];
//        [imageView release];
//    }
//    [imageView setImage:image];
    self.imageView.contentMode = UIViewContentModeTop;
    [self setImage:image forState:UIControlStateNormal];
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
