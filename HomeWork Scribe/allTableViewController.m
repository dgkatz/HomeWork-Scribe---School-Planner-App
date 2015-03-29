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
@interface allTableViewController ()

@end

NSMutableArray *results;
NSArray *scienceResults;
NSArray *socialResults;
NSArray *englishResults;
NSArray *languageResuts;
NSArray *subjects;
NSMutableArray *counts;

@implementation allTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    subjects=@[@"Math", @"Science", @"Social Studies", @"English", @"Language"];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];
    [self.dbManager executeQuery:@"create table if not exists assignmentData(hwID integer primary key, description text, subject text, due_date integer)"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:115/255.0 green:170/255.0 blue:217/255.0 alpha:1.0f];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    NSString *jb = @"Math";
    NSString *query = [NSString stringWithFormat:@"select * from assignmentData where subject = '%@'", jb];
    NSLog(@"%@",query);
    
    // Load the relevant data.
       // Set the loaded data to the textfields.
        // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    }
    if (section == 1) {
        num=[[counts objectAtIndex:1] integerValue];
    }
    if (section == 2) {
        num=[[counts objectAtIndex:2] integerValue];
    }
    if (section == 3) {
        num=[[counts objectAtIndex:3] integerValue];
    }
    if (section == 4) {
        num=[[counts objectAtIndex:4] integerValue];
    }
   
    return num;
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
            cell.textLabel.text=desc;
            NSLog(@"%@",desc);
            NSNumber *timestamp = [[results objectAtIndex:cellIndex] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"due_date"]];
            NSLog(@"%@",desc);
            NSLog(@"%@",timestamp);
        }

    }
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title;
    if (section == 0) {
        title = @"Math";
    }
    else if (section == 1){
        title = @"Science";
    }
    else{
        title = @"Other";
    }
    return title;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {[tableView setEditing:YES animated:YES]; }

// Override to support editing the table view.

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *label=cell.textLabel.text;
    NSString *deleteQuery= [NSString stringWithFormat: @"DELETE FROM assignmentData WHERE description='%@'",label];
    NSLog(@"%@",deleteQuery);
    [self.dbManager executeQuery:deleteQuery];
    
    // Delete row using the cool literal version of [NSArray arrayWithObject:indexPath]
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self viewDidLoad];
    
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
