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
#import "detailImageViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "LCZoomTransition.h"
#import <BFPaperButton/BFPaperButton.h>
#import <UIColor+BFPaperColors.h>
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
@interface detailViewController ()
@end
NSArray *menu;
UIColor *defaultcolor;
UIImage *imag;
@implementation detailViewController

-(void)viewDidAppear:(BOOL)animated{
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Detail Screen"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

}
-(void)viewDidDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
}
- (IBAction)assignmentCompleted:(id)sender {
    dataClass *obj = [dataClass getInstance];
    NSString *deleteQuery= [NSString stringWithFormat: @"DELETE FROM assignmentData WHERE description='%@'",obj.description1];
    [self.dbManager executeQuery:deleteQuery];
    obj.success = YES;
    SWRevealViewController *purchaseContr = (SWRevealViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"begin"];
    //menu is only an example
    [self presentViewController:purchaseContr animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [UIView animateWithDuration:.2 delay:0.0 options:0
                     animations:^{
                         self.navigationController.navigationBar.alpha = .5;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
                             self.navigationController.navigationBar.shadowImage = [UIImage new];
                             self.navigationController.navigationBar.translucent = YES;
                             self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
                             self.navigationController.navigationBar.alpha = 1;

                             // Do your method here after your animation.
                         }
     
    }];
    dataClass *obj = [dataClass getInstance];
    defaultcolor = obj.defaultColor;
    //nslog(@"default color = %@",defaultcolor);
    [self.assingmentcomButton setBackgroundColor:defaultcolor];

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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.assignmentTableView.frame = self.navigationController.view.frame;
    self.navigationController.toolbar.hidden = YES;
    dataClass *obj = [dataClass getInstance];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:nil
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(backClicked)];
    backButton.tintColor = [UIColor whiteColor];
    backButton.image = [UIImage imageNamed:@"back.png"];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Edit"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(editheAssignment)];
    flipButton.tintColor = [UIColor whiteColor];

    UIBarButtonItem *flipButton2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    flipButton2.tintColor = [UIColor whiteColor];
    NSArray *items = @[flipButton
                       ,flipButton2];
    self.navigationItem.rightBarButtonItems = items;
    self.assignmentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.title = @"Assignment Details";
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];

    
    menu = @[@"first",@"second",@"third"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)confirmButtonClicked{
    MFMailComposeViewController *mc= [[MFMailComposeViewController alloc]init];
    mc.mailComposeDelegate = self;
    NSString *subject = @"HomeWork Scribe app";
    NSString *body = [NSString stringWithFormat:@"Check out HomeWork Scribe in the App Store : %@",[NSURL URLWithString:@"https://itunes.apple.com/us/app/homework-scribe/id989963468?ls=1&mt=8"]];
    UIImage *icon = [UIImage imageNamed:@"Icon180g.png"];
    [mc addAttachmentData:UIImagePNGRepresentation(icon) mimeType:@"image/png" fileName:@"icon.png"];
    [mc setSubject:subject];
    [mc setMessageBody:body isHTML:NO];
    [mc setToRecipients:@[]];
    mc.navigationBar.tintColor = [UIColor whiteColor];
    [self presentViewController:mc animated:YES completion:NULL];
}
-(void)cancelButtonClicked{
    
}
-(void)share{
    BOOL shareEnableded = [[NSUserDefaults standardUserDefaults]boolForKey:@"UnlockSharing"];
    if (shareEnableded == NO) {
        MDAlertView *share = [[MDAlertView alloc]initWithTitle:@"Feature not available" message:@"To unlcok sharing assignment feature, share the app with a friend first" image:nil delegate:self cancelButtonTitle:@"later" confirmButtonTitle:@"Share!"];
        [share show];
    }
    else{
        UIActionSheet *shareActionSheet = [[UIActionSheet alloc]initWithTitle:@"Choose how to share assignment" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email",@"Text", nil];
        //[shareActionSheet showInView:[UIApplication sharedApplication].keyWindow];
        [shareActionSheet showInView:self.view];
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        dataClass *obj = [dataClass getInstance];
        MFMailComposeViewController *mc= [[MFMailComposeViewController alloc]init];
        mc.mailComposeDelegate = self;
        NSString *subject = [NSString stringWithFormat:@"Assignment due for %@",obj.subject];
        NSString *body = [NSString stringWithFormat:@"There is an assignment due for %@: %@ , due %@",obj.subject,obj.description1,obj.date];
        UIImageView *cellImage = (UIImageView *)[self.assignmentTableView viewWithTag:12345];
        [mc addAttachmentData:UIImagePNGRepresentation(cellImage.image) mimeType:@"image/png" fileName:@"icon.png"];
        [mc setSubject:subject];
        [mc setMessageBody:body isHTML:NO];
        [mc setToRecipients:@[]];
        mc.navigationBar.tintColor = [UIColor whiteColor];
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else if (buttonIndex == 1){
        dataClass *obj = [dataClass getInstance];
        MFMessageComposeViewController *mc= [[MFMessageComposeViewController alloc]init];
        mc.messageComposeDelegate = self;
        //NSString *subject = [NSString stringWithFormat:@"Assignment due for %@",obj.subject];
        NSString *body = [NSString stringWithFormat:@"There is an assignment due for %@: %@ , due %@",obj.subject,obj.description1,obj.date];
        UIImageView *cellImage = (UIImageView *)[self.assignmentTableView viewWithTag:12345];
        [mc addAttachmentData:UIImagePNGRepresentation(cellImage.image) typeIdentifier:@"image/png" filename:@"icon.png"];
        [mc setBody:body];
        [mc setRecipients:@[]];
        mc.navigationBar.tintColor = [UIColor whiteColor];
        [self presentViewController:mc animated:YES completion:NULL];
    }
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        MFMailComposeViewController *mc= [[MFMailComposeViewController alloc]init];
        mc.mailComposeDelegate = self;
        NSString *subject = @"HomeWork Scribe app";
        NSString *body = [NSString stringWithFormat:@"Check out HomeWork Scribe in the App Store : %@",[NSURL URLWithString:@"https://itunes.apple.com/us/app/homework-scribe/id989963468?ls=1&mt=8"]];
        UIImage *icon = [UIImage imageNamed:@"Icon180g.png"];
        [mc addAttachmentData:UIImagePNGRepresentation(icon) mimeType:@"image/png" fileName:@"icon.png"];
        [mc setSubject:subject];
        [mc setMessageBody:body isHTML:NO];
        [mc setToRecipients:@[]];
        mc.navigationBar.tintColor = [UIColor whiteColor];
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    if (result == MessageComposeResultCancelled) {
        
    }
    else if (result == MessageComposeResultFailed){
        
    }
    else if (result == MFMailComposeResultSaved){
        
    }
    else if (result == MessageComposeResultSent){
        
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result == MFMailComposeResultCancelled) {
        
    }
    else if (result == MFMailComposeResultFailed){
        
    }
    else if (result == MFMailComposeResultSaved){
        
    }
    else if (result == MFMailComposeResultSent){
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"UnlockSharing"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)backClicked
{
    [self.navigationController popViewControllerAnimated:YES];
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
    headerView.backgroundColor = defaultcolor;
        if ([SDiPhoneVersion deviceSize] == iPhone47inch) {
        //[duedateLabel setFont:[UIFont fontWithName:@"System-Light" size:27.0f]];
        //[subjectLabel setFont:[UIFont fontWithName:@"System-Light" size:64.0f]];
        //duedateLabel.font = [UIFont fontWithName:@"System-Light" size:27.0f];
        //subjectLabel.font = [UIFont fontWithName:@"System-Light" size:64.0f];
    }

    dataClass *obj = [dataClass getInstance];
    UIImageView *cellImage = (UIImageView *)[headerView.contentView viewWithTag:12345];
    if (obj.imgData) {
        NSData *data = obj.imgData;
        UIImage *image =[UIImage imageWithData: data];
        imag = image;
        //UIImage
        //image = [UIImage imageNamed:@"375X140Alt.png"];
        //NSData *dataFromImage = UIImagePNGRepresentation(image);
        //UIImage *imageFromData = [UIImage imageWithData:dataFromImage];
        //[UIImage imageWithData:[NSData dataWithData:[arr objectAtIndex:4]]];
        cellImage.image = image;
        cellImage.alpha = .7;
        UILabel *duedateLabel = (UILabel *)[headerView viewWithTag:20];
        duedateLabel.adjustsFontSizeToFitWidth = YES;
        UILabel *subjectLabel = (UILabel *)[headerView viewWithTag:19];
        subjectLabel.adjustsFontSizeToFitWidth = YES;
        UIButton *imageSelect = (UIButton *)[headerView viewWithTag:1000000];
        [imageSelect addTarget:self action:@selector(expandImage) forControlEvents:UIControlEventTouchUpInside];
        duedateLabel.text = [NSString stringWithFormat:@"Due %@",obj.date];
        subjectLabel.text = obj.subject;

    }
    else{
        headerView.backgroundColor = defaultcolor;
        UILabel *duedateLabel = (UILabel *)[headerView viewWithTag:20];
        duedateLabel.adjustsFontSizeToFitWidth = YES;
        UILabel *subjectLabel = (UILabel *)[headerView viewWithTag:19];
        subjectLabel.adjustsFontSizeToFitWidth = YES;
        duedateLabel.text = [NSString stringWithFormat:@"Due %@",obj.date];
        subjectLabel.text = obj.subject;
    }
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

-(void)expandImage{
    dataClass *obj = [dataClass getInstance];
    obj.chosenAssignmentImage = imag;
   detailImageViewController *purchaseContr = (detailImageViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"imagedetail"];
    [self.navigationController pushViewController:purchaseContr animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    dataClass *obj = [dataClass getInstance];
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
        NSArray* foo = [obj.description1 componentsSeparatedByString: @"-"];
        NSString* theID = [foo objectAtIndex: 0];
        label.text = theID;
        label.textColor = defaultcolor;
        
    }
    else if (indexPath.row == 1){
        UILabel *notifLabel = (UILabel *)[cell.contentView viewWithTag:3];
        notifLabel.text = [NSString stringWithFormat:@"Notification set for: %@",obj.NotifSetting];
        notifLabel.textColor = defaultcolor;
    }
    else{
        BFPaperButton *deleteButton = [[BFPaperButton alloc]initWithRaised:YES];
        deleteButton = (BFPaperButton *)[cell.contentView viewWithTag:100];
        [deleteButton addTarget:self action:@selector(buttonClciked) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.backgroundColor = defaultcolor;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int height;
    
    if (indexPath.row == 0) {
        if ( IDIOM == IPAD ) {
            height = 140;
        }
        else{
            height = 110;
        }
    }
    else{
        if ( IDIOM == IPAD ) {
            height = 70;
        }
        else{
            height = 44;
        }
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
    else if ([SDiPhoneVersion deviceSize] == iPhone55inch){
        returnHeight = 400;
    }
    else{
        returnHeight = 400;
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
    //nslog(@"%@",deleteQuery);
    [self.dbManager executeQuery:deleteQuery];
    SWRevealViewController *purchaseContr = (SWRevealViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"begin"];
    //menu is only an example
    [self presentViewController:purchaseContr animated:YES completion:nil];
}
- (void)notifSwitchValueChange:(id)sender
{
    dataClass *obj = [dataClass getInstance];
    BOOL state = [sender isOn];
    NSString *deleteQuery= [NSString stringWithFormat: @"DELETE FROM assignmentData WHERE hwID='%@'",obj.ID];
    //nslog(@"%@",deleteQuery);
    [self.dbManager executeQuery:deleteQuery];
    
    NSString *query = [NSString stringWithFormat:@"insert into assignmentData values('%@','%@','%@',%d,'%@','%@',%d)",obj.ID, obj.description1, obj.subject, obj.timestamp,[obj.imgData base64EncodedStringWithOptions:kNilOptions],obj.NotifSetting,state];
    ////nslog(@"query fot database ---> %@",query);
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    NSString *rez = state == YES ? @"YES" : @"NO";
    //nslog(@"%@",rez);
    if ([rez isEqualToString:@"YES"]) {
        NSString *dateString = obj.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSDate *dateFromString = [[NSDate alloc] init];
        // voila!
        dateFromString = [dateFormatter dateFromString:dateString];
        int unix = (int)[dateFromString timeIntervalSince1970];
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate
                                      dateWithTimeIntervalSinceNow:unix];//86400
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
