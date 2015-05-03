//
//  allTableViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 3/15/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "allTableViewController.h"
#import "dataClass.h"
#import "SWRevealViewController.h"
#import "AddViewController.h"
#import "detailViewController.h"
#import "CWStatusBarNotification.h"
@interface allTableViewController ()
@property (nonatomic, strong) JFMinimalNotification* minimalNotification;
@property (strong,nonatomic) detailViewController *expander;
@property (nonatomic) CGRect chosenCellFrame;

@end
int selected;
NSMutableArray *results;
NSArray *scienceResults;
NSArray *socialResults;
NSArray *englishResults;
NSArray *languageResuts;
NSArray *subjects;
NSMutableArray *theCounts;
NSMutableArray *counts;
NSTimer *timer;
@implementation allTableViewController


- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:    (FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
        [UIView animateWithDuration:.25 delay:0.0 options:0
                         animations:^{
                             self.shadowView.alpha = 0.0;
                         }
                         completion:^(BOOL finished){
                             if (finished) {
                                 [self.shadowView removeFromSuperview];
                                 // Do your method here after your animation.
                             }
                         }];
    } else {
        self.view.userInteractionEnabled = NO;
        self.shadowView = [[UIView alloc]initWithFrame:self.navigationController.view.frame];
        self.shadowView.backgroundColor = [UIColor blackColor];
        self.shadowView.alpha = 0.0f;
        [UIView animateWithDuration:.25 delay:0.0 options:0
                         animations:^{
                             self.shadowView.alpha = .3;
                         }
                         completion:nil];
        [self.shadowView addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        [self.shadowView addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
        SWRevealViewController *revealController = [self revealViewController];
        UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
        [self.shadowView addGestureRecognizer:tap];
        [self.navigationController.view addSubview:self.shadowView];
        }
}
- (IBAction)addAssignmentSegue:(id)sender {
    AddViewController *VC = (AddViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"add"];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:    (FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    theCounts = [[NSMutableArray alloc]init];
    NSLog(@"LAUNCHED");
    subjects=@[@"Math", @"Science", @"Social Studies", @"English", @"Language"];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];
    NSLog(@"created database magaer");
    [self.dbManager executeQuery:@"create table if not exists assignmentData(hwID integer primary key, description text, subject text, due_date integer)"];
    NSLog(@"executed query");
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    NSLog(@"added gesture");
    
    NSString *jb = @"Math";
    NSString *query = [NSString stringWithFormat:@"select * from assignmentData where subject = '%@'", jb];
    NSLog(@"query is %@",query);
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showNotification) userInfo:nil repeats:NO];
}

-(void)showNotification{
    dataClass *obj = [dataClass getInstance];
    if (obj.success == YES) {
        obj.success = NO;
        CWStatusBarNotification *notification = [CWStatusBarNotification new];
        notification.notificationLabelBackgroundColor = [UIColor groupTableViewBackgroundColor];
        notification.notificationLabelTextColor = [UIColor orangeColor];
        notification.notificationLabelFont = [UIFont fontWithName:@"System-Light" size:20];
        notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
        [notification displayNotificationWithMessage:@"You Completed an Assignment!" forDuration:1.0f];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    self.revealViewController.delegate = self;
    [self.tableView reloadData];
}

-(NSMutableArray*) selectFromDb:(NSString *) subject{
    NSString *query = [NSString stringWithFormat:@"select * from assignmentData where subject = '%@'", subject];
    NSMutableArray *returnArray=[[[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]] mutableCopy];
    NSLog(@"Array retreived");
    return returnArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [subjects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"number of rows in section called");
    // Return the number of rows in the section.
    int num = 0;
    counts=[[NSMutableArray alloc] init];
    results=[[NSMutableArray alloc] init];

    for (int i=0; i<[subjects count]; i++) {
        [results removeAllObjects];
        results=[self selectFromDb:[subjects objectAtIndex:i]];
        int count=[results count];
        NSNumber *val = [NSNumber numberWithInteger:count];
        NSLog(@"%@ Count %@", [subjects objectAtIndex:i],val);
        [counts addObject:val];
    }
    if (section == 0) {
        num=[[counts objectAtIndex:0] integerValue];
        [theCounts addObject:[NSNumber numberWithInt:num]];
        NSLog(@"%d",num);
    }
    if (section == 1) {
        num=[[counts objectAtIndex:1] integerValue];
        [theCounts addObject:[NSNumber numberWithInt:num]];
        NSLog(@"%d",num);
    }
    if (section == 2) {
        num=[[counts objectAtIndex:2] integerValue];
        [theCounts addObject:[NSNumber numberWithInt:num]];
        NSLog(@"%d",num);
    }
    if (section == 3) {
        num=[[counts objectAtIndex:3] integerValue];
        [theCounts addObject:[NSNumber numberWithInt:num]];
        NSLog(@"%d",num);
    }
    if (section == 4) {
        num=[[counts objectAtIndex:4] integerValue];
        [theCounts addObject:[NSNumber numberWithInt:num]];
        NSLog(@"%d",num);
}
   
    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    // Configure the cell...
    
    int cellIndex=indexPath.row;
    for (int i=0; i<5; i++) {
        if(indexPath.section==i){
            [results removeAllObjects];
            NSString *subject=[subjects objectAtIndex:i];
            results=[self selectFromDb:subject];
            NSString *desc = [[results objectAtIndex:cellIndex] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"description"]];
            UILabel *label = (UILabel *)[cell.contentView viewWithTag:10];
            label.text=desc;
            if (i == 0) {
                label.textColor = [UIColor colorWithRed:224/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f];
            }
            else if (i == 1){
                label.textColor = [UIColor colorWithRed:109/255.0 green:158/255.0 blue:235/255.0 alpha:1.0f];
            }
            else if (i == 2){
                label.textColor = [UIColor colorWithRed:106/255.0 green:168/255.0 blue:79/255.0 alpha:1.0f];
            }
            else if (i == 3){
                label.textColor = [UIColor colorWithRed:255/255.0 green:217/255.0 blue:102/255.0 alpha:1.0f];
            }
            else{
                label.textColor = [UIColor colorWithRed:246/255.0 green:178/255.0 blue:107/255.0 alpha:1.0f];
            }
            NSLog(@"%@",desc);
            NSNumber *timestamp = [[results objectAtIndex:cellIndex] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"due_date"]];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSString *theDate = [dateFormat stringFromDate:date];
            UILabel *labelDetail = (UILabel *)[cell.contentView viewWithTag:11];
            labelDetail.text = [NSString stringWithFormat:@"%@",theDate];
            NSLog(@"%@",desc);
            NSLog(@"%@",timestamp);
        }

    }
    NSLog(@"Cell Created");
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    results=[[NSMutableArray alloc] init];
    results=[self selectFromDb:[subjects objectAtIndex:section]];
    NSString *title = @"";
    if (results.count) {
        title = [subjects objectAtIndex:section];
    }
    return title;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:10];
    NSString *deleteQuery= [NSString stringWithFormat: @"DELETE FROM assignmentData WHERE description='%@'",label.text];
    NSLog(@"%@",deleteQuery);
    [self.dbManager executeQuery:deleteQuery];
    
    // Delete row using the cool literal version of [NSArray arrayWithObject:indexPath]
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [timer invalidate];
    [self viewDidAppear:YES];
    
}
    
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int returnint;
    if (indexPath.row == selected) {
        returnint = 100;
    }
    else{
        returnint = 44;
    }
    return returnint;
}
 */
#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showthedetail"]) {
        dataClass *obj = [dataClass getInstance];
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];

        UILabel *label = (UILabel *)[cell.contentView viewWithTag:10];
        UILabel *labelDetail = (UILabel *)[cell.contentView viewWithTag:11];
        obj.description1 = label.text;
        obj.subject = [self tableView:self.tableView titleForHeaderInSection:selectedIndexPath.section];
        obj.date = labelDetail.text;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
