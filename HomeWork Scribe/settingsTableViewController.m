//
//  settingsTableViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/22/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "settingsTableViewController.h"
#import "allTableViewController.h"
#import "SDiPhoneVersion.h"
#import <Social/Social.h>
@interface settingsTableViewController ()

@end
NSArray *menu;
@implementation settingsTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];
    menu = @[@"first",@"second",@"sixth",@"third",@"seventh",@"fifth",@"fourth"];
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = YES;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    int romNum;
    if (section == 0) {
        romNum = 1;
    }
    else if (section == 1){
        romNum = 2;
    }
    else if(section == 2){
        romNum = 1;
    }
    else{
        romNum = 3;
    }
    return romNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    if (indexPath.section == 0) {
        cellIdentifier = [menu objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cellIdentifier = @"second";

        }
        else{
            cellIdentifier = @"sixth";
        }
    }
    else if (indexPath.section == 2){
        cellIdentifier = @"third";
    }
    else{
        if (indexPath.row == 0) {
            cellIdentifier = @"seventh";
        }
        else if (indexPath.row == 1){
            cellIdentifier = @"fifth";
        }
        else{
            cellIdentifier = @"fourth";
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        UIAlertView *deleteAlert = [[UIAlertView alloc]initWithTitle:@"Delete All Assignment Data" message:@"Are you sure you want to delete all your data?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        [deleteAlert dismissWithClickedButtonIndex:1 animated:YES];
        [deleteAlert show];
    }
    else if (indexPath.section == 3){
        if (indexPath.row == 2) {
            NSString *device = [SDiPhoneVersion deviceName];
            NSString *df = [[UIDevice currentDevice] systemVersion];
            NSString *emailTitle = @"HomeWork Scribe Feedback";
            NSString *messageBody = [NSString stringWithFormat:@"\n\n\n\n\n----------------------------\nDevice Details:\n Platform: %@\n%@\nApp Version: 1.32",df,device];
            NSArray *toRecipents = [NSArray arrayWithObject:@"info@strattonapps.com"];
            
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:messageBody isHTML:NO];
            [mc setToRecipients:toRecipents];
            
            // Present mail view controller on screen
            mc.navigationBar.tintColor = [UIColor whiteColor];
            
            [self presentViewController:mc animated:YES completion:NULL];
        }
        else if (indexPath.row == 1){
            
            NSString *emailTitle = @"HomeWork Scribe App";
            NSString *messageBody = [NSString stringWithFormat:@"\n\n\n I thought you might enjoy the HomeWork Scribe App. Check it out at:<a href='https://itunes.apple.com/us/app/homework-scribe/id989963468?ls=1&mt=8'>HomeWork Scribe</a> HomeWork Scribe makes it easy to add, and keep track of homework assignments. All you have to do is add the assignment and your done."];
            NSArray *toRecipents = [NSArray arrayWithObject:@""];
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:messageBody isHTML:NO];
            [mc setToRecipients:toRecipents];
            
            // Present mail view controller on screen
            mc.navigationBar.tintColor = [UIColor whiteColor];
            
            [self presentViewController:mc animated:YES completion:NULL];
            
        }
        else{
            NSLog(@"share fb clciked");
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                NSLog(@"can use facebook");
                NSLog(@"fb registered");
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [controller setInitialText:@"Check out the HomeWork Scribe app"];
                [controller addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/homework-scribe/id989963468?mt=8"]];
                [controller addImage:[UIImage imageNamed:@"icon180g.png"]];
                [self presentViewController:controller animated:YES completion:Nil];
                
            }
            else{
                NSLog(@"cant use facebook");
                UIAlertView *faceBookAlert = [[UIAlertView alloc]initWithTitle:@"No FaceBook account" message:@"Got to your phones settings to add a facebook account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [faceBookAlert show];
            }
        }
    }
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    if (result == MFMailComposeResultCancelled) {
        
    }
    else if (result == MFMailComposeResultSaved){
        
    }
    else if (result == MFMailComposeResultSent){
        
    }
    else{
        
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *deleteQuery= [NSString stringWithFormat: @"DELETE FROM assignmentData"];
        //NSLog(@"%@",deleteQuery);
        [self.dbManager executeQuery:deleteQuery];
    }
}


- (IBAction)back:(id)sender {
    allTableViewController *VC = (allTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"all"];
    
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs insertObject:VC atIndex:[vcs count]-1];
    [self.navigationController setViewControllers:vcs animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
    /*
     CATransition *animation = [CATransition animation];
     [[self navigationController] pushViewController:VC animated:NO];
     [animation setDuration:0.45];
     [animation setType:kCATransitionPush];
     [animation setSubtype:kCATransitionFromRight];
     [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
     [[VC.view layer] addAnimation:animation forKey:@"SwitchToView1"];
     */
    //[self navigationController:self.navigationController animationControllerForOperation:UINavigationControllerOperationPush fromViewController:VC1 toViewController:VC];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
