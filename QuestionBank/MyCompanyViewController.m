//
//  MyCompanyViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-20.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "MyCompanyViewController.h"
#import "MyCompanyCell.h"
#import "PhoneViewController.h"
#import "CompanyViewController.h"
#import "NewsViewController.h"
@interface MyCompanyViewController ()

@end

@implementation MyCompanyViewController
@synthesize curUserInfo;
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
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    
//    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.tableHeaderView = ({
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//        imageView.image = [UIImage imageNamed:@"avatar.jpg"];
//        imageView.layer.masksToBounds = YES;
//        imageView.layer.cornerRadius = 50.0;
//        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        imageView.layer.borderWidth = 3.0f;
//        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        imageView.layer.shouldRasterize = YES;
//        imageView.clipsToBounds = YES;
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
//        label.text = @"Roman Efimov";
//        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
//        label.backgroundColor = [UIColor clearColor];
//        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
//        [label sizeToFit];
//        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//        
//        [view addSubview:imageView];
//        [view addSubview:label];
//        view;
//    });
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefaults objectForKey:@"userID"];
    if (!userID) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有设置个人信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前去设置", nil];
        [alert show];
        [alert release];
    }
    else{
        self.curUserInfo = [UserInfo sharedUserInfo];
        self.title = curUserInfo.company;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"Friends Online";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}
 */

/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}
 */

- (MyCompanyCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCompanyCell";
    
    MyCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MyCompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *titles = @[@"社内新闻",@"社内通知",@"报道安排",@"电话表",@"同事圈"];
    NSArray *imageNames = @[@"company_news.png",@"company_infomation.png",@"schedule.png",@"telephone.png",@"works.png"];
    cell.name.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageNames[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


//    if (indexPath.section == 0) {
//        NSArray *titles = @[@"Home", @"Profile", @"Chats"];
//        cell.textLabel.text = titles[indexPath.row];
//    } else {
//        NSArray *titles = @[@"John Appleseed", @"John Doe", @"Test User"];
//        cell.textLabel.text = titles[indexPath.row];
//    }
//    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id viewController = nil;
    switch (indexPath.row) {
        case 0:
        case 1:
        case 2:{
             viewController = (NewsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"NewsController"];
            [viewController setNewsType:indexPath.row];
        }
            break;
        case 3:
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PhoneController"];
            break;
        default:
            break;
    }
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    //[self.frostedViewController hideMenuViewController];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
     CompanyViewController *viewcontroller  = [self.storyboard instantiateViewControllerWithIdentifier:@"userCenterController"];
        [self presentViewController:viewcontroller animated:YES completion:nil];
    }
}

@end
