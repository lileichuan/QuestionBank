//
//  MyCompanyCell.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-20.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCompanyCell : UITableViewCell{
    IBOutlet UILabel    *name;
    IBOutlet UIImageView *imageView;
}
@property(nonatomic, retain) IBOutlet UILabel    *name;
@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@end
