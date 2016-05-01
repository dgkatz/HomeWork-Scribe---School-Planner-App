//
//  allTableViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 3/15/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#import "allTableViewController.h"
#import "dataClass.h"
#import "SWRevealViewController.h"
#import "AddViewController.h"
#import "detailViewController.h"
#import "CWStatusBarNotification.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "OZLExpandableTableView.h"
#import "LCZoomTransition.h"
#import <BFPaperTableViewCell/BFPaperTableViewCell.h>
#import <BFPaperButton/BFPaperButton.h>
#import <UIColor+BFPaperColors.h>
#import "MDButton.h"
@interface allTableViewController ()
@property (nonatomic, strong) JFMinimalNotification* minimalNotification;
@property (strong,nonatomic) detailViewController *expander;
@property (nonatomic) CGRect chosenCellFrame;

@end
int selected;
MDButton *addButtonCircle;
UILabel *buttonLabel;
NSMutableArray *results;
UIView *selectionLine;
NSArray *scienceResults;
NSArray *socialResults;
NSArray *englishResults;
NSArray *languageResuts;
NSArray *subjects;
NSMutableArray *theCounts;
NSMutableArray *counts;
NSTimer *timer;
int selectedButton;
NSMutableArray *assignmentImageData;
UILabel *noAssignmentsLabel;
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
- (void)addAssignmentSegue{
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

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

-(void)showUpcomingAssignemtns{
    
}

-(void)viewDidAppear:(BOOL)animated{
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName
           value:@"My Assignments Screen"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    
    self.revealViewController.delegate = self;
    [self.tableView reloadData];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = addButtonCircle.frame;
    frame.origin.y = scrollView.contentOffset.y + self.tableView.frame.size.height - 28 - addButtonCircle.frame.size.height;
    addButtonCircle.frame = frame;
    
    [self.view bringSubviewToFront:addButtonCircle];
    
    CGRect frame2 = buttonLabel.frame;
    frame2.origin.y = scrollView.contentOffset.y + self.tableView.frame.size.height - buttonLabel.frame.size.height - 10;
    buttonLabel.frame = frame2;
    
    [self.view bringSubviewToFront:buttonLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.layer.masksToBounds = NO;
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    self.navigationController.navigationBar.layer.shadowOpacity = 0.3;
    addButtonCircle = [[MDButton alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width - 80, self.tableView.frame.size.height - 150, 56, 56) type:2 rippleColor:[UIColor darkGrayColor]];
    [addButtonCircle setBackgroundColor:[UIColor orangeColor]];
    //addButtonCircle.cornerRadius = addButtonCircle.frame.size.width / 2;
    //addButtonCircle.rippleFromTapLocation = YES;
    [addButtonCircle addTarget:self action:@selector(addAssignmentSegue) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:addButtonCircle];
    buttonLabel = [[UILabel alloc]initWithFrame:CGRectMake(addButtonCircle.frame.origin.x - 20, addButtonCircle.frame.origin.y - 21, addButtonCircle.frame.size.width + 40, addButtonCircle.frame.size.height + 40)];
    buttonLabel.text = @"+";
    buttonLabel.font = [UIFont systemFontOfSize:28];
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    buttonLabel.textColor = [UIColor whiteColor];
    [self.tableView addSubview:buttonLabel];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:151/255.0 blue:0/255.0 alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    noAssignmentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width/2 - 150, self.tableView.frame.size.height/2 - 100, 300, 60)];
    noAssignmentsLabel.text = @"You currently have no assignments, click the + button to add one";
    noAssignmentsLabel.textAlignment = NSTextAlignmentCenter;
    noAssignmentsLabel.textColor = [UIColor darkGrayColor];
    noAssignmentsLabel.font = [UIFont fontWithName:@"System-Light" size:17];
    noAssignmentsLabel.numberOfLines = 0;
    noAssignmentsLabel.textColor = [UIColor orangeColor];
    theCounts = [[NSMutableArray alloc]init];
    //nslog(@"LAUNCHED");
    //self.navigationController.toolbar.delegate = self;
    //UIToolbar *toolBar = self.navigationController.toolbar;
    //toolBar.delegate = self;
    subjects=[[NSUserDefaults standardUserDefaults] objectForKey:@"usersSubjects"];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];
    //nslog(@"created database magaer");
    //[self.dbManager executeQuery:@"drop table if exists assignmentData"];
    [self.dbManager executeQuery:@"create table if not exists assignmentData(hwID integer primary key, description text, subject text, due_date integer, image text, notification text)"];
    //nslog(@"executed query");
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    //nslog(@"added gesture");
    [self.dbManager executeQuery:@"SELECT image from assignmentData"];
    if (SQLITE_ERROR){
        [self.dbManager executeQuery:@"ALTER TABLE assignmentData ADD COLUMN image text"];
        //nslog(@"Missing image column, so create one");
    }
    [self.dbManager executeQuery:@"SELECT notification from assignmentData"];
    if (SQLITE_ERROR){
        [self.dbManager executeQuery:@"ALTER TABLE assignmentData ADD COLUMN notification text"];
        //nslog(@"Missing image column, so create one");
    }
    [self.dbManager executeQuery:@"SELECT notificationIsOn from assignmentData"];
    if (SQLITE_ERROR){
        [self.dbManager executeQuery:@"ALTER TABLE assignmentData ADD COLUMN notificationIsOn integer"];
        //nslog(@"Missing image column, so create one");
    }


    
    NSString *jb = @"Math";
    NSString *query = [NSString stringWithFormat:@"select * from assignmentData where subject = '%@'", jb];
    //nslog(@"query is %@",query);
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

-(NSMutableArray*) selectFromDb:(NSString *) subject{
    NSString *query = [NSString stringWithFormat:@"select * from assignmentData where subject = '%@'", subject];
    NSMutableArray *returnArray=[[[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]] mutableCopy];
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
    //nslog(@"number of rows in section called");
    // Return the number of rows in the section.
    int num = 0;
    counts=[[NSMutableArray alloc] init];
    results=[[NSMutableArray alloc] init];

    for (int i=0; i<[subjects count]; i++) {
        [results removeAllObjects];
        results=[self selectFromDb:[subjects objectAtIndex:i]];
        int count=[results count];
        NSNumber *val = [NSNumber numberWithInteger:count];
        //nslog(@"%@ Count %@", [subjects objectAtIndex:i],val);
        [counts addObject:val];
    }

    num=[[counts objectAtIndex:section] integerValue];
   
    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( IDIOM == IPAD ) {
        return 80;
    }
    else{
        return 60;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];

    // Configure the cell...
    assignmentImageData = [[NSMutableArray alloc]init];
    int cellIndex= (int)indexPath.row;
    for (int i=0; i<[subjects count]; i++) {
        if(indexPath.section==i){
            [results removeAllObjects];
            NSString *subject=[subjects objectAtIndex:i];
            results=[self selectFromDb:subject];
            NSString *desc = [[results objectAtIndex:cellIndex] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"description"]];
            NSNumber *Id=[[results objectAtIndex:cellIndex] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"hwID"]];
            UILabel *IdLabel = (UILabel *)[cell.contentView viewWithTag:999];
            IdLabel.text= [NSString stringWithFormat:@"%@",Id];
            IdLabel.textColor = [UIColor clearColor];
            UILabel *label = (UILabel *)[cell.contentView viewWithTag:10];
            label.text=desc;
            NSArray *colors =[[NSUserDefaults standardUserDefaults] objectForKey:@"usersColors"];
            NSData *colorData = [colors objectAtIndex:i];
            UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
            label.textColor = color;
            //nslog(@"%@",desc);
            NSNumber *timestamp = [[results objectAtIndex:cellIndex] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"due_date"]];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MMM"];
            NSString *theDate = [dateFormat stringFromDate:date];
            NSArray *comp = [theDate componentsSeparatedByString:@"-"];
            UILabel *labelDetail = (UILabel *)[cell.contentView viewWithTag:11];
            labelDetail.text = [NSString stringWithFormat:@"%@ %@",[comp objectAtIndex:1],[comp objectAtIndex:0]];
            //nslog(@"%@",desc);
            //nslog(@"%@",timestamp);
        }

    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    results=[[NSMutableArray alloc] init];
    results=[self selectFromDb:[subjects objectAtIndex:section]];
    NSString *title = @"";
    if (results.count) {
        title = [subjects objectAtIndex:section];
        UILabel *label = (UILabel *)[self.tableView viewWithTag:1234];
        [label removeFromSuperview];
    }
    NSString *allQuery= [NSString stringWithFormat:@"SELECT * FROM assignmentData"];
    NSMutableArray *allReturnedAssignments =[[NSMutableArray alloc]initWithArray:[self.dbManager loadDataFromDB:allQuery]];
    if ([allReturnedAssignments count] == 0) {
        [self.view addSubview:noAssignmentsLabel];
    }
    else{
        [noAssignmentsLabel removeFromSuperview];
        [self.tableView sendSubviewToBack:noAssignmentsLabel];
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
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    if ([segue.identifier isEqualToString:@"showthedetail"]) {
        // pass the custom transition to the destination controller
        // so it can use it when setting up its gesture recognizers
        //[[segue destinationViewController] addGestureRecognizer:self.transition];
        dataClass *obj = [dataClass getInstance];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
        NSArray *colorArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"usersColors"];
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:10];
        UILabel *labelDetail = (UILabel *)[cell.contentView viewWithTag:11];
        UILabel *IdLabel=(UILabel *)[cell.contentView viewWithTag:999];
        obj.description1 = label.text;
        obj.subject = [self tableView:self.tableView titleForHeaderInSection:selectedIndexPath.section];
        //nslog(@"the subject chosen is %@",obj.subject);
        obj.date = labelDetail.text;
        NSData *colorData = [colorArray objectAtIndex:selectedIndexPath.section];
        obj.defaultColor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        obj.ID=IdLabel.text;
        
        NSString *query = [NSString stringWithFormat:@"select * from assignmentData where hwID = '%@'", obj.ID];
        //nslog(@"ID query is: %@", query);
        NSMutableArray *returnArray=[[[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]] mutableCopy];
        NSArray *arr = [returnArray objectAtIndex:0];
        NSLog(@"da count bro %d",[arr count]);
        if (arr.count>4) {
            NSString *retreivedBase64ImgString = [arr objectAtIndex:4];
            NSString *returnedNotif = [arr objectAtIndex:5];
            obj.NotifSetting = returnedNotif;
            obj.imgData = [[NSData alloc] initWithBase64EncodedString:retreivedBase64ImgString options:kNilOptions];
            obj.timestamp = (int)[arr objectAtIndex:3];
            if (arr.count == 7) {
                obj.notifIsOn = (int)[arr objectAtIndex:6];
            }
        }
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
