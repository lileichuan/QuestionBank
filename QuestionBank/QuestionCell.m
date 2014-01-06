//
//  QuestionCell.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-19.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "QuestionCell.h"

@implementation QuestionCell
@synthesize num,state;
- (id)initWithFrame:(CGRect)frame{
	
    if (self = [super initWithFrame:frame]) {
        label = [[UILabel alloc]initWithFrame:self.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        //[self addSubview:self.view];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
		self.layer.borderWidth = 1.0;
		
	}
	
    return self;
	
}

-(void)setNum:(NSInteger)_num{
    num = _num;
    NSString *title = [NSString stringWithFormat:@"%ld",_num];
    label.text = title;
}

-(void)setState:(NSInteger)_state{
    state = _state;
    switch (_state) {
        case 0:
            self.backgroundColor = [UIColor whiteColor];
            break;
        case 1:
            self.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
            break;
        case 2:
            self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
            break;
            
        default:
            break;
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
