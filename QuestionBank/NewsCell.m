//
//  NewsCell.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-21.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell
@synthesize newNewsImageView,newsArrowImageView,newsLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    [super dealloc];
}
@end
