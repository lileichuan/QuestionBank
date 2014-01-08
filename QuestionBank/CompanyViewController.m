//
//  CompanyViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-6.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "CompanyViewController.h"
#import "CompanyCell.h"
#import "UserCenterViewController.h"
#import "Catalog.h"
@interface CompanyViewController (){
    NSArray  *companyArr;
    UITextField *companyTextField;
}
@property(nonatomic, retain)NSArray  *companyArr;
@property(nonatomic, retain) UITextField *companyTextField;
@end

@implementation CompanyViewController
@synthesize companyArr,companyTextField;
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
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    if (companyTextField) {
        [companyTextField release];
    }
    if (companyArr) {
        [companyArr release];
    }
    [super dealloc];
}

-(IBAction)addCompany:(id)sender{
    UITextField *tfID=[[UITextField alloc]initWithFrame:CGRectZero];
    [tfID becomeFirstResponder];
    tfID.borderStyle = UITextBorderStyleRoundedRect;
    tfID.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.companyTextField = tfID;
    [tfID release];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置用户信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.companyTextField = [alert textFieldAtIndex:0];
    companyTextField.placeholder = @"所在单位";
    alert.tag=100;
    [alert show];
    [alert release];

}

-(void)initData{
    NSString *filePath = [Catalog getCompanyFilePath];
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        self.companyArr = [NSArray arrayWithContentsOfFile:filePath];
    }
    else{
        self.companyArr =@[@"人民日报社",@"新华通讯社",@"解放军报社",@"光明日报社",@"经济日报社",@"中央人民广播电台",@"中国国际广播电台",@"中央电视台",@"中国日报社",@"科技日报社",@"中国纪检监察报社",@"工人日报社",@"中国青年报社",@"中国妇女报社",@"农民日报社",@"法制日报社",@"中国新闻社",@"《求是》杂志社",@"中国石化报"];
        [companyArr writeToFile:filePath atomically:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return companyArr.count;
}

- (CompanyCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"company";
    CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    NSString *company = [companyArr objectAtIndex:indexPath.row];
    cell.companyLabel.text = company;
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
    if ([segue.identifier isEqualToString:@"UserCenter"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UserCenterViewController *destViewController = segue.destinationViewController;
        NSDictionary *dic = @{@"company":[companyArr objectAtIndex:indexPath.row]};
        [destViewController configureUserInfo:dic];
    }
    else if([segue.identifier isEqualToString:@"AddCompany"]){
        UserCenterViewController *destViewController = segue.destinationViewController;
        NSDictionary *dic = @{@"company":companyTextField.text};
        [destViewController configureUserInfo:dic];
    }
}

#pragma mark
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100) {
        switch (buttonIndex) {
            case 1:
            {
                [self enterUserCenterViewController];
                
            }
                break;
                
            default:
                break;
        }
    }
    
}

-(void)enterUserCenterViewController{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.companyArr];
    [arr addObject:companyTextField.text];
    NSString *filePath = [Catalog getCompanyFilePath];
    [arr writeToFile:filePath atomically:YES];
    [self initData];
    [self.tableView reloadData];
    UserCenterViewController *destViewController= [self.storyboard instantiateViewControllerWithIdentifier:@"UserCenter"];
    NSDictionary *dic = @{@"company":companyTextField.text};
    [destViewController configureUserInfo:dic];
    [self.navigationController pushViewController:destViewController animated:YES];
}

@end
