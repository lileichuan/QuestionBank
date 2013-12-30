//
//  TranscriptView.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-21.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TranscriptView :UIImageView{
    UILabel *titleLabel;
    UILabel *scoreLabel;
    UILabel *durationLabel;
    
}

-(void)configureTranscriptInfo:(NSDictionary *)dic;

@end
