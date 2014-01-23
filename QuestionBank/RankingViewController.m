//
//  RankingViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-3.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "RankingViewController.h"
#import "RankingView.h"
#import "TopView.h"
#import "RankingCell.h"
#import "InterfaceService.h"

@interface RankingViewController (){
    IBOutlet TopView *topView;
    IBOutlet RankingView *rankingView;
    IBOutlet UISegmentedControl *segmentControl;
    NSArray    *rankArr;
}
@property(nonatomic, retain)UISegmentedControl *segmentControl;


@end

@implementation RankingViewController
@synthesize userInfo,segmentControl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.userInfo = [UserInfo sharedUserInfo];
    [self initData];
    [self addTopBarView];
    [self addRankingView];

}
- (BOOL)shouldAutorotate{
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
//    if (userInfo) {
//        [userInfo release];
//        userInfo =  nil;
//    }
    [super dealloc];
}
-(void)close{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)addTopBarView{
    [topView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    topView.title.text = @"排行榜";
    
}

-(void)addRankingView{
    CGRect contentRect =   CGRectMake(0,CGRectGetMaxY(topView.frame),CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topView.frame));
    rankingView.frame = contentRect;
}

-(void)initData{
    InterfaceService *service = [[InterfaceService alloc]init];
    if (segmentControl.selectedSegmentIndex == 0) {
         rankArr = [service loadRakingWithCompany:userInfo.company];
    }
    else if(segmentControl.selectedSegmentIndex == 1){
         rankArr = [service loadAnswerRaking];
    }
   
    [rankArr retain];
    [service release];
    service = nil;
}

-(IBAction)switchRankIndex:(id)sender{
    [self initData];
    [rankingView reloadData];
    
}

#pragma mark
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(RankingView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(RankingView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return rankArr.count;
}

#pragma mark
#pragma mark UITableViewDataSource

-(void)makeCellAnswerWithCell:(RankingCell *)cell cellforRowIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellInfo = [rankArr objectAtIndex:indexPath.row];
    [cell configureCellInfo:cellInfo withRank:indexPath.row + 1];
}

- (UITableViewCell *)tableView:(RankingView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"RankingCell";
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[RankingCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    [self makeCellAnswerWithCell:cell cellforRowIndexPath:indexPath];
    return cell;
}

- (void)tableView:(RankingView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

@end
