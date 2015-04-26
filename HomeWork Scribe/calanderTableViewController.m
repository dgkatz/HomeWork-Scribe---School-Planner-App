//
//  calanderTableViewController.m
//  HomeWork Scribe
//
//  Created by Family on 3/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//
#import "calanderTableViewController.h"
#import "SWRevealViewController.h"
#import "dataClass.h"
#import "Assignment.h"
@interface calanderTableViewController ()
@end
NSString *selectedDate;
NSString *newDate;
UILabel *noAssignmentsLabel;
NSMutableArray *assignments;
NSMutableArray *assignmentsForDay;
NSMutableArray *initialArray;
PDTSimpleCalendarViewController *calendarViewController;
@implementation calanderTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    noAssignmentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width/2 - 150, self.tableView.frame.size.height/2, 300, 40)];
    noAssignmentsLabel.text = @"You have no assignments for this day";
    noAssignmentsLabel.textAlignment = NSTextAlignmentCenter;
    noAssignmentsLabel.textColor = [UIColor darkGrayColor];
    noAssignmentsLabel.font = [UIFont fontWithName:@"System-Light" size:17];
    initialArray = [[NSMutableArray alloc]init];
    assignments=[[NSMutableArray alloc]init];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
     calendarViewController= [[PDTSimpleCalendarViewController alloc] init];
    //This is the default behavior, will display a full year starting the first of the current month
    [calendarViewController setDelegate:self];
    [[PDTSimpleCalendarViewCell appearance] setCircleTodayColor:[UIColor grayColor]];
    [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor:[UIColor orangeColor]];
    [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:[UIColor orangeColor]];
    NSString *query = [NSString stringWithFormat:@"select * from assignmentData"];
    NSMutableArray *results=[[[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]] mutableCopy];
    for (int i=0; i<[results count]; i++) {
        Assignment *assignment=[Assignment new];
        assignment.due_date=[[results objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"due_date"]];
        assignment.subject=[[results objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"subject"]];
        assignment.description=[[results objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"description"]];
        [assignments addObject:assignment];
    }
    NSArray *sortedArray=[[NSArray alloc]initWithArray:[Assignment getSortedList:assignments]];
    for(int i=0;i<[sortedArray count];i++){
        Assignment *as=[sortedArray objectAtIndex:i];
        NSLog(@"Sorted Assignment: %@ %@ %@",as.subject, as.description, as.due_date);
    }
    
    if ([assignmentsForDay count] == 0) {
        NSLog(@"empty");
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        newDate = [dateFormat stringFromDate:[NSDate date]];
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
        NSDate *finalDate = [dateFormat2 dateFromString:newDate];
        int timestamp = [finalDate timeIntervalSince1970];
        NSLog(@"the timestamp %d",timestamp);
        NSString *query= [NSString stringWithFormat:@"SELECT * FROM assignmentData WHERE due_date=%d",timestamp];
        NSLog(@" %@ ", query);
        assignmentsForDay=[[NSMutableArray alloc]initWithArray:[self.dbManager loadDataFromDB:query]];
        [self.tableView reloadData];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

               
-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [assignmentsForDay count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int cellIndex = (int)indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    NSString *subject = [[assignmentsForDay objectAtIndex:cellIndex] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"subject"]];
    NSString *desc=[[assignmentsForDay objectAtIndex:cellIndex] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"description"]];


    cell.textLabel.text = subject;
    cell.detailTextLabel.text = desc;
    if ([subject isEqualToString:@"Math"]) {
        cell.textLabel.textColor = [UIColor colorWithRed:224/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f];
    }
    else if ([subject isEqualToString:@"Science"]){
        cell.textLabel.textColor = [UIColor colorWithRed:109/255.0 green:158/255.0 blue:235/255.0 alpha:1.0f];
    }
    else if ([subject isEqualToString:@"Social Studies"]){
        cell.textLabel.textColor = [UIColor colorWithRed:106/255.0 green:168/255.0 blue:79/255.0 alpha:1.0f];
    }
    else if ([subject isEqualToString:@"English"]){
        cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:217/255.0 blue:102/255.0 alpha:1.0f];
    }
    else {
        cell.textLabel.textColor = [UIColor colorWithRed:246/255.0 green:178/255.0 blue:107/255.0 alpha:1.0f];
    }
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
       UIView *view = calendarViewController.view;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.view.frame.size.height/2 + 5;
}
-(BOOL)simpleCalendarViewCell:(PDTSimpleCalendarViewCell *)cell shouldUseCustomColorsForDate:(NSDate *)date{
    
        cell.textTodayColor = [UIColor greenColor];

    
    return YES;
}
- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date
{
    NSLog(@"Date Selected : %@",date);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    newDate = [dateFormat stringFromDate:date];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
    NSDate *finalDate = [dateFormat2 dateFromString:newDate];
    int timestamp = [finalDate timeIntervalSince1970];
    NSLog(@"the timestamp %d",timestamp);
    NSString *query= [NSString stringWithFormat:@"SELECT * FROM assignmentData WHERE due_date=%d",timestamp];
    NSLog(@" %@ ", query);
    assignmentsForDay=[[NSMutableArray alloc]initWithArray:[self.dbManager loadDataFromDB:query]];
    if([assignmentsForDay count]>0){
        NSLog(@"assignment for day %@ %@ %@", [[assignmentsForDay objectAtIndex:0] objectAtIndex:0], [[assignmentsForDay objectAtIndex:0] objectAtIndex:1], [[assignmentsForDay objectAtIndex:0] objectAtIndex:2]);
        [noAssignmentsLabel removeFromSuperview];
        [self.tableView sendSubviewToBack:noAssignmentsLabel];
    }
    else{
        [self.tableView addSubview:noAssignmentsLabel];
        [self.tableView bringSubviewToFront:noAssignmentsLabel];
    }
    NSLog(@"Date Selected with Locale %@", [date descriptionWithLocale:[NSLocale systemLocale]]);
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"thesegue"]) {
        dataClass *obj = [dataClass getInstance];
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
        obj.description1 = cell.detailTextLabel.text;
        obj.subject = cell.textLabel.text;
        obj.date = newDate;
    }

}

@end
