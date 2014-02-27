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
#import "UserInfo.h"
#import "UserInfoDao.h"
#import "InterfaceService.h"
#import "REFrostedViewController.h"
#import "CompanyDao.h"
@interface CompanyViewController (){
    NSArray  *companyArr;
    UITextField *companyTextField;
    CompanyDao *companyDao;
    UISearchBar *searchBar;
}
@property(nonatomic, retain) NSArray  *companyArr;
@property(nonatomic, retain) UITextField *companyTextField;
@property(nonatomic, retain) CompanyDao *companyDao;
@property(nonatomic, retain) UISearchBar *searchBar;

@end

@implementation CompanyViewController
@synthesize companyArr,companyTextField,companyDao,searchBar;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)dealloc{
//    if (companyTextField) {
//        [companyTextField release];
//        companyTextField = nil;
//    }
//    if (companyArr) {
//        [companyArr release];
//        companyArr = nil;
//    }
//    if (companyDao) {
//        [companyDao release];
//        companyDao = nil;
//    }
//    if (searchBar) {
//        [searchBar release];
//        searchBar = nil;
//    }
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UISearchBar * theSearchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-50, 40)] autorelease];
    
    theSearchBar.placeholder = @"请输入单位名";
    
    theSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    theSearchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    theSearchBar.delegate = self;
    
    //theSearchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"All",@"A",@"B",@"C",@"D" ,nil];
    
    theSearchBar.showsScopeBar = YES;
    
    theSearchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    self.searchBar = theSearchBar;
    
    //theSearchBar.showsBookmarkButton = YES;
    
    self.tableView.tableHeaderView = searchBar;
    [theSearchBar release];
    companyDao = [[CompanyDao alloc]init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        InterfaceService *service = [[InterfaceService alloc]init];
        NSArray *arr =  [service getCompanylist];
        [service release];
        if (arr) {
            [companyDao clearCompany];
            for (NSDictionary *companyInfo in arr) {
                Company *company = [[Company alloc]init];
                company.name =[companyInfo objectForKey:@"name"];
                [companyDao insertCompany:company];
                [company release];
            }
            self.companyArr = [companyDao getCompanys];
        }
//        else{
//            NSString *filePath = [Catalog getCompanyFilePath];
//            if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
//                self.companyArr = [NSArray arrayWithContentsOfFile:filePath];
//            }
//            else{
//                self.companyArr =@[@"人民日报社",@"新华通讯社",@"解放军报社",@"光明日报社",@"经济日报社",@"中央人民广播电台",@"中国国际广播电台",@"中央电视台",@"中国日报社",@"科技日报社",@"中国纪检监察报社",@"工人日报社",@"中国青年报社",@"中国妇女报社",@"农民日报社",@"法制日报社",@"中国新闻社",@"《求是》杂志社",@"中国石化报"];
//                [companyArr writeToFile:filePath atomically:YES];
//            }
//        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
    });
}
               

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)addCompany:(id)sender{
    UITextField *tfID=[[UITextField alloc]initWithFrame:CGRectZero];
    [tfID becomeFirstResponder];
    tfID.borderStyle = UITextBorderStyleRoundedRect;
    tfID.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.companyTextField = tfID;
    [tfID release];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加单位" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.companyTextField = [alert textFieldAtIndex:0];
    companyTextField.placeholder = @"单位名称";
    alert.tag=100;
    [alert show];
    [alert release];
    



}

-(IBAction)closeSetting:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{}];
    //[self.frostedViewController hideMenuViewController];
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
    Company *company = [companyArr objectAtIndex:indexPath.row];
    cell.companyLabel.text = company.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Company *company = [companyArr objectAtIndex:indexPath.row];
    if (self.chooseCompany) {
        self.chooseCompany(company.name);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


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

-(void)updateSearchResult{
    [searchBar resignFirstResponder];
    NSString *str = searchBar.text;
    if (companyArr) {
        [companyArr release];
        companyArr = nil;
    }
    if (str.length > 0) {
        self.companyArr = [companyDao searchCompanysWithName:str];
    }
    else{
        self.companyArr = [companyDao getCompanys];
    }
   
    [self.tableView reloadData];
    
}


#pragma mark -
#pragma mark Search Bar Delegate Methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
    [self updateSearchResult];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   [self updateSearchResult];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar
{
    [self.searchBar setText:@""];
    [self updateSearchResult];
  
}
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"UserCenter"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UserCenterViewController *destViewController = segue.destinationViewController;
        Company *company = [companyArr objectAtIndex:indexPath.row];
        NSDictionary *dic = @{@"company":company.name};
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

    UserCenterViewController *destViewController= [self.storyboard instantiateViewControllerWithIdentifier:@"UserCenter"];
    NSDictionary *dic = @{@"company":companyTextField.text};
    [destViewController configureUserInfo:dic];
    [self.navigationController pushViewController:destViewController animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        InterfaceService *service = [[InterfaceService alloc]init];
        BOOL success =  [service uploadCompany:companyTextField.text];
        [service release];
        if (!success) {
            NSLog(@"上传单位失败");
        }
        else {
            [self.tableView reloadData];
        }
        
    });
}

@end
