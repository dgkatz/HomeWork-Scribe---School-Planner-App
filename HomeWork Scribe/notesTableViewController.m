//
//  notesTableViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/24/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "notesTableViewController.h"
#import "SWRevealViewController.h"
#import "dataClass.h"
#import "allTableViewController.h"
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
@interface notesTableViewController ()

@end
NSMutableArray *data;
NSArray *subjects;
@implementation notesTableViewController
BOOL editmode;
- (void)viewDidLoad {
    [super viewDidLoad];
    subjects=[[NSUserDefaults standardUserDefaults] objectForKey:@"usersSubjects"];
    data = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"saved"]];
    //NSLog(@"before delete : %@",data);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)back:(id)sender {
    allTableViewController *VC = (allTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"all"];
    
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs insertObject:VC atIndex:[vcs count]-1];
    [self.navigationController setViewControllers:vcs animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Notes Screen"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [subjects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    int returnnum;
    returnnum = (int)[[[NSUserDefaults standardUserDefaults]objectForKey:[subjects objectAtIndex:section]] count];
    return returnnum;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [[[NSUserDefaults standardUserDefaults]objectForKey:[subjects objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];

    cell.textLabel.textColor = [UIColor orangeColor];
    // Configure the cell...
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [subjects objectAtIndex:section];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


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
- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *selectedSubject;
    selectedSubject = [subjects objectAtIndex:indexPath.section];
    NSMutableArray *savedValues = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@",selectedSubject]]];
    NSString *label=cell.textLabel.text;
    [savedValues removeObject:[NSString stringWithFormat:@"%@",label]];
    [[NSUserDefaults standardUserDefaults]setObject:savedValues forKey:selectedSubject];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self viewDidLoad];
    
}
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showNote"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
        NSString *titleForHeader = [self tableView:self.tableView titleForHeaderInSection:selectedIndexPath.section];
        dataClass *obj = [dataClass getInstance];
        obj.note = cell.textLabel.text;
        editmode = YES;
        [[NSUserDefaults standardUserDefaults]setBool:editmode forKey:@"editmode"];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",titleForHeader] forKey:@"subject"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}


@end
