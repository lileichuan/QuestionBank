//
//  NewsViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-21.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "NewsViewController.h"
#import "InterfaceService.h"
#import "UserInfo.h"
#import "NewsCell.h"
#import "AddNewsViewController.h"

@interface NewsViewController (){
    NSArray *dataArr;
}
@property(nonatomic, retain) NSArray *dataArr;

@end

@implementation NewsViewController
@synthesize dataArr,newsType;

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
    switch (newsType) {
        case 0:
            self.title = @"社内新闻";
            break;
        case 1:
            self.title = @"社内通知";
            break;
        case 2:
            self.title = @"社内站";
            break;
            
        default:
            break;
    }
    //[self initData];
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    [self reloadData];
}

-(void)initData{
    if (dataArr) {
        [dataArr release];
        dataArr = nil;
    }
//    UserInfo *curUserInfo = [UserInfo sharedUserInfo];
//    InterfaceService *service = [[InterfaceService alloc]init];
//    self.dataArr = [service loadNewWithType:newsType withCompany:curUserInfo.company];
}

-(void)reloadData{
    [self initData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return dataArr.count;
}

- (NewsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"News";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    return cell;
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
    if ([[segue identifier] isEqualToString:@"AddNews"]) {
        // Get destination view
        AddNewsViewController *vc = [segue destinationViewController];
        // Get button tag number (or do whatever you need to do here, based on your object
        vc.newsType = self.newsType;
    }
}


@end
