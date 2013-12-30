//
//  QuestionTitleView.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-22.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "QuestionTitleView.h"
#define OPTION_TYPE_HEIGHT 18
@implementation QuestionTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.image = [[UIImage imageNamed:@"exercise_bg_n.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
        [self addSubVies];
    }
    return self;
}
-(void)addSubVies{
    if (!typeLabel) {
        typeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        UIFont *font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
        //设置字体
        typeLabel.font = font;
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.textColor =[UIColor redColor];
        typeLabel.frame = CGRectMake(0,2,CGRectGetWidth(self.bounds),OPTION_TYPE_HEIGHT);
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:typeLabel];
    }
    
    if (!titleLabel) {
        titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        UIFont *font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
        titleLabel.numberOfLines = 0;
        //设置字体
        titleLabel.font = font;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor =[UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
    }

}
-(void)configureTitleInfo:(NSDictionary *)dic{
    OPTION_TYPE type = (OPTION_TYPE)[[dic objectForKey:@"type"]integerValue];
    NSString *title = [dic objectForKey:@"title"];
    CGSize constraint = CGSizeMake(CGRectGetWidth(self.bounds) - 5,480.0f);
    CGSize size = [title sizeWithFont:titleLabel.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    CGRect titleRect = CGRectMake(5, 2, size.width, size.height);
    if (type == MUTABLE_CHOOSE) {
        titleRect.origin.y = OPTION_TYPE_HEIGHT;
        typeLabel.hidden = NO;
        typeLabel.text = @"(多选题)";
    }
    else{
        typeLabel.hidden = YES;
    }
    titleLabel.text =title;
    [titleLabel setFrame:titleRect];
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMinY(titleLabel.frame) + CGRectGetHeight(titleLabel.frame) + 4;
    self.frame = frame;
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
