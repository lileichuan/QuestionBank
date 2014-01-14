//
//  RankingCell.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-4.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "RankingCell.h"
#import "Catalog.h"
@implementation RankingCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
       // [self addSubViews];
        
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
}

-(void)addSubViews{
    if (!photoImageView) {
        photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5,CGRectGetMidY(self.frame) - 20,40,40)];
        [self addSubview:photoImageView];
        [photoImageView release];
    }
    if (!rankLabel) {
        rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - 55,CGRectGetMidY(self.frame) - 20,50,40)];
        [rankLabel setNumberOfLines:0];
        rankLabel.font = [UIFont systemFontOfSize:16];
        rankLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:rankLabel];
        [rankLabel release];
    }
    if (!nameLabel) {
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(photoImageView.frame) + 5,6,60,20)];
        [nameLabel setNumberOfLines:0];
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        [nameLabel release];
    }
    if (!scoreLabel) {
        scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(photoImageView.frame) +5,CGRectGetMaxY(nameLabel.frame)+ 2,40,20)];
        [scoreLabel setNumberOfLines:0];
        scoreLabel.font = [UIFont systemFontOfSize:12];
        scoreLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:scoreLabel];
        [scoreLabel release];
    }
    if (!timeLabel) {
        timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(scoreLabel.frame) +5,CGRectGetMinY(scoreLabel.frame),60,20)];
        [timeLabel setNumberOfLines:0];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        [timeLabel release];
    }
}

-(void)configureCellInfo:(NSDictionary *)info withRank:(NSInteger)rank{
    NSDictionary *userInfo = [info objectForKey:@"user"];
    NSString *userID = [userInfo objectForKey:@"user_id"];
    NSString *name = [userInfo objectForKey:@"name"];
    NSString *score = [NSString stringWithFormat:@"%.1f分",[[info objectForKey:@"score"]floatValue]];
    NSInteger duration = [[info objectForKey:@"duration"]integerValue];
    NSString *time = [NSString stringWithFormat:@"%ld分%ld秒",duration/60,duration%60];
    NSString *rankInfo = [NSString stringWithFormat:@"第%ld名",rank];
    NSString *company = [userInfo objectForKey:@"company"];
    NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:[NSString stringWithFormat:@"%@.png",userID]];
    if([[NSFileManager defaultManager]fileExistsAtPath:photoPath]){
         photoImageView.image = [UIImage imageWithContentsOfFile:photoPath];
    }
    nameLabel.text = name;
    rankLabel.text = rankInfo;
    timeLabel.text = time;
    scoreLabel.text = score;
    compayLabel.text = company;
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
