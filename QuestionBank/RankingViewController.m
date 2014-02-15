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
#import "MJRefresh.h"

@interface RankingViewController (){
    IBOutlet TopView *topView;
    IBOutlet RankingView *rankingView;
    IBOutlet UISegmentedControl *segmentControl;
    NSMutableArray    *companyRankingArr;
    NSMutableArray    *rankingArr;
    NSArray          *curRaingkingArr;
    
    MJRefreshFooterView *_footer;
}
@property(nonatomic, retain) UISegmentedControl *segmentControl;
@property(nonatomic, retain) NSMutableArray    *companyRankingArr;
@property(nonatomic, retain) NSMutableArray    *rankingArr;
@property(nonatomic, retain) NSArray          *curRaingkingArr;


@end

@implementation RankingViewController
@synthesize userInfo,segmentControl,companyRankingArr,rankingArr,curRaingkingArr,indicator;
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
    //[self initData];
    [self addTopBarView];
    [self addRankingView];
    //初始化:
    indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    //设置显示样式,见UIActivityIndicatorViewStyle的定义
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    //设置显示位置
     [indicator setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 60)];
   //[indicator setCenter:self.view.center];
    //设置背景色
    //indicator.backgroundColor = [UIColor grayColor];
    //将初始化好的indicator add到view中
    [self.view addSubview:indicator];
    [self addFooter];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self initData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [rankingView reloadData];
            if (indicator) {
                [indicator removeFromSuperview];
                [indicator release];
                indicator = nil;
            }
        });

    });
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
    if (userInfo) {
        [userInfo release];
        userInfo =  nil;
    }
    if (curRaingkingArr) {
        [curRaingkingArr release];
        curRaingkingArr = nil;
    }
    if (companyRankingArr) {
        [companyRankingArr removeLastObject];
        [companyRankingArr release];
        companyRankingArr = nil;
    }
    if (rankingArr) {
        [rankingArr removeAllObjects];
        [rankingArr release];
        rankingArr = nil;
    }
    if (indicator) {
        [indicator removeFromSuperview];
        [indicator release];
        indicator = nil;
    }
    [super dealloc];
}
-(void)close{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)addFooter
{
    __unsafe_unretained RankingViewController *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = rankingView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        BOOL success = [self initData];
        if (success) {
        }
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0.5];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    _footer = footer;
}


- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [rankingView reloadData];
    [refreshView endRefreshing];
}


-(void)addTopBarView{
    [topView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    topView.title.text = @"排行榜";
    
}

-(void)addRankingView{
    CGRect contentRect =   CGRectMake(0,CGRectGetMaxY(topView.frame),CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topView.frame));
    rankingView.frame = contentRect;
}

-(BOOL)initData{
    BOOL success = NO;
    if (!companyRankingArr) {
        companyRankingArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    if(!rankingArr){
        rankingArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    InterfaceService *service = [[InterfaceService alloc]init];
    if (segmentControl.selectedSegmentIndex == 0) {
       
        NSInteger pageNum = companyRankingArr.count / 10;
        NSArray *tempArr = [service loadRakingWithCompany:userInfo.company withPageNum:pageNum+1];
        if (tempArr && tempArr.count > 0) {
            [companyRankingArr addObjectsFromArray:tempArr];
            success = YES;
        }
        curRaingkingArr = companyRankingArr;
    }
    else if(segmentControl.selectedSegmentIndex == 1){
        NSInteger pageNum = rankingArr.count / 10;
        NSArray *tempArr = [service loadRakingWithPageNum:pageNum + 1];
        if (tempArr && tempArr.count > 0) {
            [rankingArr addObjectsFromArray:tempArr];
            success = YES;
        }
        curRaingkingArr = rankingArr;

    }
    [service release];
    service = nil;
    return success;
  }



-(IBAction)switchRankIndex:(id)sender{
    [self initData];
    [rankingView reloadData];
    [rankingView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

#pragma mark
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(RankingView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(RankingView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return curRaingkingArr.count;
}

#pragma mark
#pragma mark UITableViewDataSource

-(void)makeCellAnswerWithCell:(RankingCell *)cell cellforRowIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellInfo = [curRaingkingArr objectAtIndex:indexPath.row];
    [cell configureCellInfo:cellInfo withRank:indexPath.row + 1];
    if ([userInfo.name isEqualToString:[cellInfo objectForKey:@"name"]]) {
        cell.contentView.backgroundColor = [UIColor grayColor];
    }
    else{
         cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (UITableViewCell *)tableView:(RankingView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"RankingCell";
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[RankingCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self makeCellAnswerWithCell:cell cellforRowIndexPath:indexPath];
    return cell;
}

- (void)tableView:(RankingView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

@end
