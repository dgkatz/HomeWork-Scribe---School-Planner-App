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
@interface UpcomingController ()

@end

NSMutableArray *upAssignments;
NSMutableArray *assignments;
NSArray *sortedArray;
@implementation UpcomingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Upcoming Assignments";
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    assignments = [[NSMutableArray alloc]init];
    int date= [[NSDate date] timeIntervalSince1970] + 172800;
    NSString *query= [NSString stringWithFormat: @"SELECT * FROM assignmentData WHERE due_date<%d",date];
    NSLog(@"%@",query);
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];
    upAssignments= [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"number of assignments %lu", (unsigned long)[upAssignments count]);
    for (int i=0; i<[upAssignments count]; i++) {
        Assignment *assignment=[Assignment new];
        assignment.due_date=[[upAssignments objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"due_date"]];
        assignment.subject=[[upAssignments objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"subject"]];
        assignment.description=[[upAssignments objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"description"]];
        [assignments addObject:assignment];
    }
    sortedArray=[[NSArray alloc]initWithArray:[Assignment getSortedList:assignments]];
    for(int i=0;i<[sortedArray count];i++){
        Assignment *as=[sortedArray objectAtIndex:i];
        NSLog(@"Sorted Assignment: %@ %@ %@",as.subject, as.description, as.due_date);
    }

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    int index=indexPath.row;
    if (indexPath.row < [sortedArray count]) {
        Assignment *as=[sortedArray objectAtIndex:index];
        cell.textLabel.text=as.subject;
        cell.detailTextLabel.text=as.description;
    }
    if ([cell.textLabel.text isEqualToString:@"Math"]) {
        cell.textLabel.textColor = [UIColor colorWithRed:224/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f];
    }
    else if ([cell.textLabel.text isEqualToString:@"Science"]){
        cell.textLabel.textColor = [UIColor colorWithRed:109/255.0 green:158/255.0 blue:235/255.0 alpha:1.0f];
    }
    else if ([cell.textLabel.text isEqualToString:@"Social Studies"]){
        cell.textLabel.textColor = [UIColor colorWithRed:106/255.0 green:168/255.0 blue:79/255.0 alpha:1.0f];
    }
    else if ([cell.textLabel.text isEqualToString:@"English"]){
        cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:217/255.0 blue:102/255.0 alpha:1.0f];
    }
    else {
        cell.textLabel.textColor = [UIColor colorWithRed:246/255.0 green:178/255.0 blue:107/255.0 alpha:1.0f];
    }

    return cell;
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
        
        obj.description1 = cell.detailTextLabel.text;
        obj.subject = cell.textLabel.text;
        obj.date = theDate;
    }
}


@end
