//
//  AddNewsViewController.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-21.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewsViewController : UIViewController{
    IBOutlet UITextField *textFiled;
    IBOutlet UITextView  *textView;
    
    NSInteger newsType;
}
@property(nonatomic, assign)NSInteger newsType;


-(IBAction)cancel:(id)sender;

-(IBAction)add:(id)sender;
@end
