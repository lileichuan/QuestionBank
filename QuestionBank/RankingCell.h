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
    IBOutlet UIImageView *rankImageView;
}
@property(nonatomic, retain) IBOutlet UILabel  *rankLabel;
@property(nonatomic, retain) IBOutlet UIImageView *photoImageView;
@property(nonatomic, retain) IBOutlet UILabel *nameLabel;
@property(nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property(nonatomic, retain) IBOutlet UILabel *timeLabel; //答题时长
@property(nonatomic, retain) IBOutlet UILabel *compayLabel;
@property(nonatomic, retain) IBOutlet UILabel *answerTimeLabel; //答题时间
@property(nonatomic, retain) IBOutlet UIImageView *rankImageView;

-(void)configureCellInfo:(NSDictionary *)info withRank:(NSInteger)rank;
@end
