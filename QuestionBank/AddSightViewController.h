//
//  AddSightViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-27.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSightViewController : UIViewController{
    IBOutlet UITextView *contentView;
    IBOutlet UIScrollView *picScrollerView;
}
@property(nonatomic,copy)dispatch_block_t updateDataBlock;

-(IBAction)cancel:(id)sender;

-(IBAction)save:(id)sender;

@end
