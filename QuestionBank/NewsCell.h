//
//  NewsCell.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-21.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell{
    IBOutlet UIImageView *newsArrowImageView;
    IBOutlet UIImageView *newNewsImageView;
    IBOutlet UILabel *newsLabel;
}
@property(nonatomic, retain) IBOutlet UIImageView *newsArrowImageView;
@property(nonatomic, retain) IBOutlet UIImageView *newNewsImageView;
@property(nonatomic, retain) IBOutlet UILabel *newsLabel;


@end
