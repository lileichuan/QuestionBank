//
//  UserInfoViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-22.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfo.h"
#import "Catalog.h"
#import "CompanyViewController.h"
#import "FeedbackViewController.h"

@interface UserInfoViewController (){
    UserInfo *curUserInfo;
}
@property(nonatomic, retain) UserInfo *curUserInfo;

@end

@implementation UserInfoViewController
@synthesize curUserInfo,photoImageView,infoTableView;
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
     self.title = @"我的信息";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.tableView.backgroundColor = [UIColor clearColor];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefaults objectForKey:@"userID"];
    if (!userID) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有设置个人信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前去设置", nil];
        [alert show];
        [alert release];
    }
    else{
        self.curUserInfo = [UserInfo sharedUserInfo];
    }
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        photoImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
       
        photoImageView.layer.masksToBounds = YES;
        photoImageView.layer.cornerRadius = 50.0;
        photoImageView.layer.borderColor = [UIColor grayColor].CGColor;
        photoImageView.layer.borderWidth = 3.0f;
        photoImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        photoImageView.layer.shouldRasterize = YES;
        photoImageView.clipsToBounds = YES;
        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
//        label.text = @"Roman Efimov";
//        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
//        label.backgroundColor = [UIColor clearColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
//        [label sizeToFit];
//        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:photoImageView];
       // [view addSubview:label];
        
        if (curUserInfo) {
            NSString *fullPhotoPath = [[Catalog getPhotoForlder] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",curUserInfo.userID]];
            if ([[NSFileManager defaultManager]fileExistsAtPath:fullPhotoPath]) {
                photoImageView.image = [UIImage imageWithContentsOfFile:fullPhotoPath];
            }
        }
        else{
            // label.text = @"未设置";
             photoImageView.image = [UIImage imageNamed:@"Photo_Default.png"];
        }
        view;
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCompanyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    switch (indexPath.row) {
        case 0:
        {
            if (!curUserInfo) {
                cell.textLabel.text = cell.textLabel.text = @"未设置用户";;
            }
            else{
                cell.textLabel.text = [NSString stringWithFormat:@"昵称:%@",curUserInfo.name];
            }
        }
           
            break;
//        case 1:
//            cell.textLabel.text = [NSString stringWithFormat:@"女士:%@",curUserInfo.name];
            break;
//        case 2:
//            cell.textLabel.text = [NSString stringWithFormat:@"城市:%@",curUserInfo.name];
//            break;
//        case 3:
//            cell.textLabel.text = [NSString stringWithFormat:@"单位:%@",curUserInfo.name];
//            break;
//        case 4:
//            cell.textLabel.text = [NSString stringWithFormat:@"职位:%@",curUserInfo.name];
            break;
        case 1:{
            if (!curUserInfo) {
                cell.textLabel.text = @"未设置单位";
            }
            else{
                 cell.textLabel.text = [NSString stringWithFormat:@"单位:%@",curUserInfo.company];
            }
           
        }
            break;
        case 2:
            cell.textLabel.text = @"联系我们";
            break;
        case 3:
            cell.textLabel.text = @"问题反馈";
            break;
        default:
            break;
    }
//    NSArray *titles = @[@"单位",@"社内通知",@"报道安排",@"电话表",@"同事圈"];
//    NSArray *imageNames = @[@"company_news.png",@"company_infomation.png",@"schedule.png",@"telephone.png",@"works.png"];
//    cell.textLabel.text = titles[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:imageNames[indexPath.row]];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {

        case 2:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jizhehome.com/"]];
        }
            break;
        case 3:{
            FeedbackViewController *viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"feedbackController"];
            [self.navigationController pushViewController:viewcontroller animated:YES];
        }
           
            break;
        default:
            break;
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(void)loadRegisterView{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUserInfo) name:@"FinishRegist" object:nil];
    CompanyViewController *companyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"register"];
    [self presentViewController:companyViewController animated:YES completion:NULL];
}

-(void)updateUserInfo{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"FinishRegist" object:nil];
    curUserInfo = [UserInfo sharedUserInfo];
    [self.tableView reloadData];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self loadRegisterView];
    }
    else{
        [self.tabBarController setSelectedIndex:0];
    }
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"didSelectViewController");
}
@end
