//
//  MyCompanyCell.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-20.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "MyCompanyCell.h"

@implementation MyCompanyCell
@synthesize name,imageView;
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
    if (name) {
        [name release];
        name = nil;
    }
    if (imageView) {
        [imageView release];
        imageView = nil;
    }
    [super dealloc];
}

@end
