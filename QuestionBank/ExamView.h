//
//  ExamVIew.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-22.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"

@interface ExamView : UIView<UIGridViewDelegate>{
  
}
@property (nonatomic,copy) dispatch_block_t exitBlock;
@end
