//
//  QuestionTitleView.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-22.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTitleView : UIImageView{
    UILabel  *typeLabel;
    UILabel  *titleLabel;
}

-(void)configureTitleInfo:(NSDictionary *)dic;
@end
