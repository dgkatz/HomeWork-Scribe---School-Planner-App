//
//  detailViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/22/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "detailViewController.h"
#import "dataClass.h"
#import "SWRevealViewController.h"
#import "editAssignmentViewController.h"
#import "SDiPhoneVersion.h"
@interface detailViewController ()

@end
NSArray *menu;
UIColor *defaultcolor;
@implementation detailViewController

- (IBAction)assignmentCompleted:(id)sender {
    dataClass *obj = [dataClass getInstance];
    NSString *deleteQuery= [NSString stringWithFormat: @"DELETE FROM assignmentData WHERE description='%@'",obj.description1];
    [self.dbManager executeQuery:deleteQuery];
    obj.success = YES;
    SWRevealViewController *purchaseContr = (SWRevealViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"begin"];
    //menu is only an example
    [self presentViewController:purchaseContr animated:YES completion:nil];
}
-(void)editheAssignment{
    static NSString *CellIdentifier = @"header";
    UITableViewCell *headerView = [self.assignmentTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UILabel *duedateLabel = (UILabel *)[headerView.contentView viewWithTag:20];
    UILabel *subjectLabel = (UILabel *)[headerView.contentView viewWithTag:19];
    dataClass *obj = [dataClass getInstance];
    obj.subjectEdit = subjectLabel.text;
    obj.description1Edit = obj.description1;
    obj.dateEdit = duedateLabel.text;
    editAssignmentViewController *purchaseContr = (editAssignmentViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"editViewConrtller"];
    [self.navigationController pushViewController:purchaseContr animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataClass *obj = [dataClass getInstance];
    if ([obj.subject isEqualToString:@"Math"]) {
        defaultcolor = [UIColor colorWithRed:224/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f];
    }
    else if ([obj.subject isEqualToString:@"Science"]){
        defaultcolor = [UIColor colorWithRed:109/255.0 green:158/255.0 blue:235/255.0 alpha:1.0f];
    }
    else if ([obj.subject isEqualToString:@"Social Studies"]){
        defaultcolor = [UIColor colorWithRed:106/255.0 green:168/255.0 blue:79/255.0 alpha:1.0f];
    }
    else if ([obj.subject isEqualToString:@"English"]){
        defaultcolor = [UIColor colorWithRed:255/255.0 green:217/255.0 blue:102/255.0 alpha:1.0f];
    }
    else {
        defaultcolor = [UIColor colorWithRed:246/255.0 green:178/255.0 blue:107/255.0 alpha:1.0f];
    }
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Edit"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(editheAssignment)];
    flipButton.tintColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = flipButton;
    self.assignmentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];

    
    menu = @[@"first",@"second",@"third"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.assingmentcomButton.backgroundColor = defaultcolor;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
   return [menu count];
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *CellIdentifier = @"header";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UILabel *duedateLabel = (UILabel *)[headerView.contentView viewWithTag:20];
    duedateLabel.adjustsFontSizeToFitWidth = YES;
    UILabel *subjectLabel = (UILabel *)[headerView.contentView viewWithTag:19];
    subjectLabel.adjustsFontSizeToFitWidth = YES;
    if ([SDiPhoneVersion deviceSize] == iPhone47inch) {
        //[duedateLabel setFont:[UIFont fontWithName:@"System-Light" size:27.0f]];
        //[subjectLabel setFont:[UIFont fontWithName:@"System-Light" size:64.0f]];
        //duedateLabel.font = [UIFont fontWithName:@"System-Light" size:27.0f];
        //subjectLabel.font = [UIFont fontWithName:@"System-Light" size:64.0f];
    }

    dataClass *obj = [dataClass getInstance];
    duedateLabel.text = [NSString stringWithFormat:@"Due %@",obj.date];
    subjectLabel.text = obj.subject;
    if ([obj.subject isEqualToString:@"Math"]) {
        subjectLabel.backgroundColor = [UIColor colorWithRed:224/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f];
        defaultcolor = [UIColor colorWithRed:224/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f];
    }
    else if ([obj.subject isEqualToString:@"Science"]){
        subjectLabel.backgroundColor = [UIColor colorWithRed:109/255.0 green:158/255.0 blue:235/255.0 alpha:1.0f];
        defaultcolor = [UIColor colorWithRed:109/255.0 green:158/255.0 blue:235/255.0 alpha:1.0f];
    }
    else if ([obj.subject isEqualToString:@"Social Studies"]){
        subjectLabel.backgroundColor = [UIColor colorWithRed:106/255.0 green:168/255.0 blue:79/255.0 alpha:1.0f];
        defaultcolor = [UIColor colorWithRed:106/255.0 green:168/255.0 blue:79/255.0 alpha:1.0f];
    }
    else if ([obj.subject isEqualToString:@"English"]){
        subjectLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:217/255.0 blue:102/255.0 alpha:1.0f];
        defaultcolor = [UIColor colorWithRed:255/255.0 green:217/255.0 blue:102/255.0 alpha:1.0f];
    }
    else {
        subjectLabel.backgroundColor = [UIColor colorWithRed:246/255.0 green:178/255.0 blue:107/255.0 alpha:1.0f];
        defaultcolor = [UIColor colorWithRed:246/255.0 green:178/255.0 blue:107/255.0 alpha:1.0f];
    }
    headerView.backgroundColor = defaultcolor;
    if (section == 0) {
        if (headerView == nil){
            [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
        }
        
    }
    else{
        headerView = nil;
    }
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    dataClass *obj = [dataClass getInstance];
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
        label.text = obj.description1;
        label.textColor = defaultcolor;

    }
    else if (indexPath.row == 1){
        UISwitch *switchnotif = (UISwitch *)[cell.contentView viewWithTag:2];
        [switchnotif addTarget:self action:@selector(notifSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
        switchnotif.onTintColor = defaultcolor;
        UILabel *notifLabel = (UILabel *)[cell.contentView viewWithTag:3];
        notifLabel.textColor = defaultcolor;
    }
    else{
        UIButton *deleteButton = (UIButton *)[cell.contentView viewWithTag:100];
        [deleteButton addTarget:self action:@selector(buttonClciked) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.backgroundColor = defaultcolor;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int height;
    
    if (indexPath.row == 0) {
        height = 110;
    }
    else{
        height = 44;
    }
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    int returnHeight;
    if ([SDiPhoneVersion deviceSize] == iPhone35inch) {
        returnHeight = 175;
    }
    else if ([SDiPhoneVersion deviceSize] == iPhone4inch){
        returnHeight = 260;
    }
    else if ([SDiPhoneVersion deviceSize] == iPhone47inch){
        returnHeight = 320;
    }
    else{
        returnHeight = 220;
    }
    return returnHeight;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)buttonClciked{
    dataClass *obj = [dataClass getInstance];
    NSString *deleteQuery= [NSString stringWithFormat: @"DELETE FROM assignmentData WHERE description='%@'",obj.description1];
    NSLog(@"%@",deleteQuery);
    [self.dbManager executeQuery:deleteQuery];
    SWRevealViewController *purchaseContr = (SWRevealViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"begin"];
    //menu is only an example
    [self presentViewController:purchaseContr animated:YES completion:nil];
}
- (void)notifSwitchValueChange:(id)sender
{
    dataClass *obj = [dataClass getInstance];
    BOOL state = [sender isOn];
    NSString *rez = state == YES ? @"YES" : @"NO";
    NSLog(@"%@",rez);
    if ([rez isEqualToString:@"YES"]) {        
        
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate
                                      dateWithTimeIntervalSinceNow:2];//86400
        localNotification.repeatInterval = 0;
        localNotification.alertBody = [NSString stringWithFormat:@"You have an assignment due for %@: %@",obj.subject,obj.description1];
        localNotification.alertAction = @"Show me the item";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:localNotification];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:[NSString stringWithFormat:@"%@",obj.description1]];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else{
        if ([[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@",obj.description1]]) {
            NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@",obj.description1]];
            UILocalNotification *localNotif = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [[UIApplication sharedApplication] cancelLocalNotification:localNotif];

        }
    }
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

@end
