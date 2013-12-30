//
//  TranscriptView.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-21.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "TranscriptView.h"

@implementation TranscriptView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.image = [UIImage imageNamed:@"transcript.png"];
        self.userInteractionEnabled = YES;
        [self addSubViews];
    }
    return self;
}


-(void)dealloc{
    if (titleLabel) {
        [titleLabel removeFromSuperview];
        [titleLabel release];
        titleLabel = nil;
    }
    if (scoreLabel) {
        [scoreLabel removeFromSuperview];
        [scoreLabel release];
        scoreLabel = nil;
    }
    if (durationLabel) {
        [durationLabel removeFromSuperview];
        [durationLabel release];
        durationLabel = nil;
    }
    [super dealloc];
}

-(void)addSubViews{
    CGRect titleRect = CGRectMake(148,28,100,24 );
    titleLabel = [[UILabel alloc]initWithFrame:titleRect];
    titleLabel.font =[UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    
    CGRect scoreRect = CGRectMake(138.5,86 ,100,20 );
    scoreLabel = [[UILabel alloc]initWithFrame:scoreRect];
    scoreLabel.font =[UIFont systemFontOfSize:14];
    scoreLabel.textAlignment = NSTextAlignmentLeft;
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textColor = [UIColor blackColor];
    [self addSubview:scoreLabel];
    
    CGRect durationRect = CGRectMake(138.5,107,100,20);
    durationLabel = [[UILabel alloc]initWithFrame:durationRect];
    durationLabel.font =[UIFont systemFontOfSize:14];
    durationLabel.textAlignment = NSTextAlignmentLeft;
    durationLabel.backgroundColor = [UIColor clearColor];
    durationLabel.textColor = [UIColor blackColor];
    [self addSubview:durationLabel];
    
    
    
}

-(void)configureTranscriptInfo:(NSDictionary *)dic{
    NSInteger score = [[dic objectForKey:@"score"]integerValue];
    scoreLabel.text = [NSString stringWithFormat:@"%d分",score];
    
    NSInteger duration = [[dic objectForKey:@"duration"]integerValue];
    NSString *useTime = [NSString stringWithFormat:@"%d分%d秒",duration/60,duration%60];
    durationLabel.text = useTime;
    
    NSString *title;
    if (score < 60) {
        title = @"业余爱好";
    }
    else if(score >= 60 && score < 70){
         title = @"职业记者";
    }
    else if(score >= 70 && score < 80){
         title = @"出类拔萃";
    }
    else if(score >= 80 && score < 90){
         title = @"满腹经纶";
    }
    else if(score >= 90 && score < 100){
        title = @"闻名中外";
    }
    else if(score == 100){
        title = @"旷世奇才";

    }
    titleLabel.text = title;
    
    
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
