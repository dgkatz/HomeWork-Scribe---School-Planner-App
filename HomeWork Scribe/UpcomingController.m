//
//  UpcomingController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/23/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "UpcomingController.h"
#import "Assignment.h"
#import "SWRevealViewController.h"
#import "dataClass.h"
#import "allTableViewController.h"
#import "KxMenu.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
@interface UpcomingController ()

@end

NSMutableArray *upAssignments;
NSMutableArray *assignments;
NSArray *sortedArray;
NSArray *subjects;
NSString *setting;
@implementation UpcomingController

-(void)viewDidAppear:(BOOL)animated{
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Upcoming Assignments Screen"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    subjects=[[NSUserDefaults standardUserDefaults] objectForKey:@"usersSubjects"];
    if (self.navigationItem.title == nil) {
        self.navigationItem.title = @"Upcoming Assignments";
        setting = @"upcoming";
    }
    
    assignments = [[NSMutableArray alloc]init];
    int currentdate= [[NSDate date] timeIntervalSince1970];
    NSString *query;
    if ([setting isEqualToString:@"upcoming"]) {
        int date = [[NSDate date] timeIntervalSince1970] + 172800;
        query = [NSString stringWithFormat: @"SELECT * FROM assignmentData WHERE due_date BETWEEN %d AND %d",currentdate , date];
    }
    else if ([setting isEqualToString: @"overdue"]){
        query = [NSString stringWithFormat: @"SELECT * FROM assignmentData WHERE due_date<%d",currentdate];
    }
    
    //nslog(@"%@",query);
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];
    upAssignments= [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    //nslog(@"number of assignments %lu", (unsigned long)[upAssignments count]);
    for (int i=0; i<[upAssignments count]; i++) {
        Assignment *assignment=[Assignment new];
        assignment.due_date=[[upAssignments objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"due_date"]];
        assignment.subject=[[upAssignments objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"subject"]];
        assignment.description=[[upAssignments objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"description"]];
        assignment.ID=[[upAssignments objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"hwID"]];
        [assignments addObject:assignment];
    }
    sortedArray=[[NSArray alloc]initWithArray:[Assignment getSortedList:assignments]];
    for(int i=0;i<[sortedArray count];i++){
        Assignment *as=[sortedArray objectAtIndex:i];
        //nslog(@"Sorted Assignment: %@ %@ %@",as.subject, as.description, as.due_date);
    }

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [upAssignments count];
}

- (IBAction)back:(id)sender {
    allTableViewController *VC = (allTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"all"];
    
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs insertObject:VC atIndex:[vcs count]-1];
    [self.navigationController setViewControllers:vcs animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    int index= (int)indexPath.row;
    NSString *theID;
    NSString *theDesc;
    if (indexPath.row < [sortedArray count]) {
        Assignment *as=[sortedArray objectAtIndex:index];
        cell.textLabel.text=as.subject;
        cell.detailTextLabel.text=as.description;
        theDesc = as.description;
        theID = [NSString stringWithFormat:@"%@",as.ID];
        
    }
    int indexNum = (int)[subjects indexOfObject:cell.textLabel.text];
    NSArray *colors =[[NSUserDefaults standardUserDefaults] objectForKey:@"usersColors"];
    NSData *colorData = [colors objectAtIndex:indexNum];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    cell.textLabel.textColor = color;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",cell.detailTextLabel.text,theID];
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithString:cell.detailTextLabel.text];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor clearColor]
                 range:NSMakeRange([theDesc length], [theID length] + 1)];
    [cell.detailTextLabel setAttributedText: text];
    return cell;
}
- (IBAction)organize:(id)sender {
    NSArray *menuItems =
    @[
      
        [KxMenuItem menuItem:@"Upcoming"
                     image:NULL
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"Overdue"
                     image:NULL
                    target:self
                    action:@selector(pushMenuItem:)],
      ];
    UIBarButtonItem *viewButton = sender;
    UIView *view = [viewButton valueForKey:@"view"];
    CGRect frame  =view.frame;
    CGFloat x = frame.origin.x;
    CGFloat y = 70;
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    y = y - 20;
    CGRect newrect = CGRectMake(x, y, width, height);
    [KxMenu showMenuInView:self.view fromRect:newrect menuItems:menuItems];
}

-(void)pushMenuItem:(id)sender{
    KxMenuItem *first = sender;
    NSString *str = first.title;
    if ([str isEqualToString:@"Upcoming"]) {
        //nslog(@"Upcoming Chosen");
        self.navigationItem.title = @"Upcoming Assignments";
        setting = @"upcoming";
    }
    else if ([str isEqualToString:@"Overdue"]){
        //nslog(@"Overdue chosen");
        self.navigationItem.title = @"Overdue Assignments";
        setting = @"overdue";
    }
    [self viewDidLoad];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"fromUpcomingToDetail"]) {
        dataClass *obj = [dataClass getInstance];
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
        NSNumber *timestamp = [[upAssignments objectAtIndex:selectedIndexPath.row] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"due_date"]];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *theDate = [dateFormat stringFromDate:date];
        NSArray *colorArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"usersColors"];
        obj.description1 = cell.detailTextLabel.text;
        obj.subject = cell.textLabel.text;
        obj.date = theDate;
        NSArray* foo = [cell.detailTextLabel.text componentsSeparatedByString: @"-"];
        NSString* theIDstring = [foo objectAtIndex: 1];
        obj.ID = theIDstring;
        
        NSString *query = [NSString stringWithFormat:@"select * from assignmentData where hwID = '%@'", obj.ID];
        
        NSMutableArray *returnArray=[[[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]] mutableCopy];
        NSArray *arr;
        if ([returnArray count] > 0) {
            arr = [returnArray objectAtIndex:0];
            
        }
        if (arr.count>4) {
            NSString *retreivedBase64ImgString = [arr objectAtIndex:4];
            obj.imgData = [[NSData alloc] initWithBase64EncodedString:retreivedBase64ImgString options:kNilOptions];
        }

        
        
        int indexNum = (int)[subjects indexOfObject:cell.textLabel.text];
        NSData *colorData = [colorArray objectAtIndex:indexNum];
        obj.defaultColor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    }
}


@end
