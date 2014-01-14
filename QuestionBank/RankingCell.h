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
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *compayLabel;
}

-(void)configureCellInfo:(NSDictionary *)info withRank:(NSInteger)rank;
@end
