//
//  SightViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-25.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "SightViewController.h"
#import "InterfaceService.h"
#import "AddSightViewController.h"
#import "DateMethod.h"
#import "Catalog.h"

@interface SightCell:UITableViewCell{
   IBOutlet UIImageView *photoImageView;
   IBOutlet UILabel     *companyLabel;
   IBOutlet UILabel    *userNameLabel;
   IBOutlet UILabel    *contentLabel;
   IBOutlet UILabel    *timeLabel;
}
@property(nonatomic, retain) IBOutlet UIImageView *photoImageView;
@property(nonatomic, retain) IBOutlet UILabel     *userNameLabel;
@property(nonatomic, retain) IBOutlet UILabel    *contentLabel;
@property(nonatomic, retain) IBOutlet UILabel     *companyLabel;
@property(nonatomic, retain) IBOutlet UILabel    *timeLabel;
@end

@implementation SightCell
@synthesize photoImageView,userNameLabel,contentLabel,companyLabel,timeLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}
-(void)dealloc{
    [photoImageView release];
    [userNameLabel release];
    [contentLabel release];
    [companyLabel release];
    [timeLabel release];
    [super dealloc];
}

-(void)configureCellInfo:(NSDictionary *)info{
    NSDictionary *userDic = [info objectForKey:@"user"];
    NSString *name = [userDic objectForKey:@"name"];
    if (!name || name.length == 0) {
        name =  @"记者之家";
    }
    userNameLabel.text = name;

    //NSInteger type = [[info objectForKey:@"type"]integerValue];
    NSString *company = [userDic objectForKey:@"company"];
    if (!company || company.length == 0) {
        company =  @"记者之家";
    }
    companyLabel.text = company;
    
    UIFont *font = [UIFont systemFontOfSize:16];
    NSString *content =[info objectForKey:@"content"];
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(240,100) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = contentLabel.frame;
    frame.size.height = size.height;
    contentLabel.frame = frame;
    contentLabel.text = [info objectForKey:@"content"];
    
    NSString *time = [DateMethod timestampFromString:[info objectForKey:@"time"]];
    timeLabel.text = time;
    
    NSString *headurl = [userDic objectForKey:@"head_url"];
    if (headurl && headurl.length > 0) {
        NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:[headurl lastPathComponent]];
        photoImageView.image =[UIImage imageWithContentsOfFile:photoPath];
    }
}

@end


@interface SightViewController ()

@end

@implementation SightViewController
@synthesize dataArr,curUserInfo,header;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorStyle =     UITableViewCellSeparatorStyleNone;
    self.curUserInfo = [UserInfo sharedUserInfo];
    [self initData];
    [self addHeader];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    if (curUserInfo) {
        [curUserInfo release];
        curUserInfo = nil;
    }
    if (dataArr) {
        [dataArr removeAllObjects];
        [dataArr release];
        dataArr = nil;
    }
    if (header) {
        [header release];
        header = nil;
    }
    [super dealloc];
}
- (void)addHeader
{
    self.header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
        [self initData];
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0.2];
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
        // 刷新表格
        [self.tableView reloadData];
        
    };
}
- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    [refreshView endRefreshing];
}


-(void)initData{
    if (!dataArr) {
        dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    [dataArr removeAllObjects];
    InterfaceService *service = [[InterfaceService alloc]init];
    [dataArr addObjectsFromArray:[service getAllSights:curUserInfo.userID]];
    [service release];
    service = nil;
    
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIFont *font = [UIFont systemFontOfSize:16];
    NSDictionary *info = [dataArr objectAtIndex:indexPath.row];
    NSString *content =[info objectForKey:@"content"];
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(240,100) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height + 65;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"SightCell";
    SightCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[SightCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self makeCellAnswerWithCell:cell cellforRowIndexPath:indexPath];
    return cell;
}


-(void)makeCellAnswerWithCell:(SightCell *)cell cellforRowIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellInfo = [dataArr objectAtIndex:indexPath.row];
    [cell configureCellInfo:cellInfo];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    self.tabBarController.tabBar.hidden = YES;
    if ([segue.identifier isEqualToString:@"AddSightViewController"]) {
     AddSightViewController *destViewController = segue.destinationViewController;
        destViewController.updateDataBlock = ^{
            [self initData];
            [self.tableView reloadData];
        };
    }
    
}

@end
