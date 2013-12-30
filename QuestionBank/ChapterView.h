//
//  ChapterView.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-22.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChapterDao.h"
@interface ChapterView : UIView<UITableViewDataSource,UITableViewDelegate>{
   
}
@property (nonatomic,copy) dispatch_block_t exitBlock;

-(void)initChapterWithType:(EXAM_TYPE)type;

@end
