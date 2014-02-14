//
//  RankingCell.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-4.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingCell : UITableViewCell{
    IBOutlet  UILabel  *rankLabel;
    IBOutlet UIImageView *photoImageView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *timeLabel; //答题时长
    IBOutlet UILabel *compayLabel;
    IBOutlet UILabel *answerTimeLabel; //答题时间
}

-(void)configureCellInfo:(NSDictionary *)info withRank:(NSInteger)rank;
@end
