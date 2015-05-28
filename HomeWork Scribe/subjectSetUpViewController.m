//
//  subjectSetUpViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/4/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "subjectSetUpViewController.h"
#import "customSubjectPickerTableViewController.h"
#import "selectdateSmallViewController.h"
#import "SWRevealViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
@interface subjectSetUpViewController ()
@end
PDTSimpleCalendarViewController *calendarViewController;

@implementation subjectSetUpViewController
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    UIView *view = (UIView *)[self.view viewWithTag:123];
    [view removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subjectTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    //The event handling method
      self.navigationController.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
    self.subjects = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"chosenSubjects"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.subjectTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.subjects = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"chosenSubjects"]];
    //nslog(@"the subjects at number of rows in section %@",self.subjects);

    if (section == 0) {
        return [self.subjects count];
    }
    else if (section == 1){
        return 2;
    }
    else
        return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.subjects = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"chosenSubjects"]];
    //nslog(@"Array at cellforroatindexpath %@",self.subjects);
    UITableViewCell *cell;
    if (indexPath.section == 0) {
       cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"   %@",[self.subjects objectAtIndex:indexPath.row]];
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"identifier3" forIndexPath:indexPath];
            UIButton *button = (UIButton *)[cell.contentView viewWithTag:2];
            [button addTarget:self action:@selector(chooseFromProvidedSubjects) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"identifier2" forIndexPath:indexPath];
        UIButton *button = (UIButton *)[cell.contentView viewWithTag:1];
        [button addTarget:self action:@selector(addcustomsubject) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return cell;
}

-(void)chooseFromProvidedSubjects{
    customSubjectPickerTableViewController *VC = (customSubjectPickerTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"pciker"];
    [self.navigationController pushViewController:VC animated:YES];
}



-(void)addcustomsubject{
    UIAlertView *addSubjectAlert = [[UIAlertView alloc]initWithTitle:@"Add a custom subject" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    addSubjectAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [addSubjectAlert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    UITextField *tf = (UITextField *)[alertView textFieldAtIndex:0];
    if (buttonIndex == 1) {
        NSString *stringtoadd = tf.text;
        NSMutableArray *retreivedSavedArray = [[[NSUserDefaults standardUserDefaults]objectForKey:@"chosenSubjects"] mutableCopy];
        [retreivedSavedArray addObject:stringtoadd];
        [[NSUserDefaults standardUserDefaults]setObject:retreivedSavedArray forKey:@"chosenSubjects"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.subjectTableView reloadData];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }
    else{
        return 63;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return YES;
    }
    else{
        return NO;
    }
}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *stringToDelete = cell.textLabel.text;
    //nslog(@"string to delete %@",stringToDelete);
    NSMutableArray *savedArray = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"chosenSubjects"]];
    [savedArray removeObjectAtIndex:indexPath.row];
    //nslog(@"Array at delte %@",savedArray);
    [[NSUserDefaults standardUserDefaults]setObject:savedArray forKey:@"chosenSubjects"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    // Delete row using the cool literal version of [NSArray arrayWithObject:indexPath]
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView reloadData];
    
}
    
}
- (IBAction)doneClicked:(id)sender {
    NSString * result = [[self.subjects valueForKey:@"description"] componentsJoinedByString:@","];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Initialize subjects"     // Event category (required)
                                                          action:@"Initialize subjects"  // Event action (required)
                                                           label:result          // Event label
                                                           value:nil] build]];
    [[NSUserDefaults standardUserDefaults]setObject:self.subjects forKey:@"usersSubjects"];
    
    NSArray *colorArray = [[NSArray alloc]initWithObjects:[UIColor colorWithRed:224/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f],[UIColor colorWithRed:109/255.0 green:158/255.0 blue:235/255.0 alpha:1.0f],[UIColor colorWithRed:106/255.0 green:168/255.0 blue:79/255.0 alpha:1.0f],[UIColor colorWithRed:255/255.0 green:217/255.0 blue:102/255.0 alpha:1.0f],[UIColor colorWithRed:246/255.0 green:178/255.0 blue:107/255.0 alpha:1.0f],[UIColor colorWithRed:204/255.0 green:65/255.0 blue:37/255.0 alpha:1.0] ,[UIColor colorWithRed:118/255.0 green:165/255.0 blue:175/255.0 alpha:1.0f],[UIColor colorWithRed:142/255.0 green:124/255.0 blue:195/255.0 alpha:1.0f],[UIColor colorWithRed:194/255.0 green:123/255.0 blue:160/255.0 alpha:1.0f],nil];
    NSMutableArray *sortedColorArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [self.subjects count]; i ++) {
        int randint = arc4random_uniform((int)[colorArray count]);
        UIColor *randColor = [colorArray objectAtIndex:randint];
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:randColor];
        [sortedColorArray addObject:colorData];
    }
    [[NSUserDefaults standardUserDefaults]setObject:sortedColorArray forKey:@"usersColors"];
    //nslog(@"Array of sibjects when done clicked %@",self.subjects);
    [[NSUserDefaults standardUserDefaults]synchronize];
    SWRevealViewController *VC = (SWRevealViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"begin"];
    [self presentViewController:VC animated:YES completion:nil];
    /*
    calendarViewController= [[PDTSimpleCalendarViewController alloc] init];
    [calendarViewController setDelegate:self];
    [[PDTSimpleCalendarViewCell appearance] setCircleTodayColor:[UIColor orangeColor]];
    [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor:[UIColor grayColor]];
    [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:[UIColor orangeColor]];
    //calendarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    calendarViewController.view.frame = CGRectMake(self.view.frame.size.width/2 -125, self.view.frame.size.height/2-125, 250, 250);
    calendarViewController.view.tag = 123;
    //[calendarView addSubview:calendarViewController.view];
    calendarViewController.view.layer.masksToBounds = NO;
    calendarViewController.view.layer.cornerRadius = 8; // if you like rounded corners
    calendarViewController.view.layer.shadowOffset = CGSizeMake(0, 0);
    calendarViewController.view.layer.shadowRadius = 200;
    calendarViewController.view.layer.shadowOpacity = 0.5;
    calendarViewController.view.userInteractionEnabled = TRUE;

    [self.view addSubview:calendarViewController.view];
     */
}

-(void) disableRecursivelyAllSubviews:(UIView *) theView
{
    theView.userInteractionEnabled = NO;
    for(UIView* subview in [theView subviews])
    {
        [self disableRecursivelyAllSubviews:subview];
    }
}

-(void) disableAllSubviewsOf:(UIView *) theView
{
    for(UIView* subview in [theView subviews])
    {
        [self disableRecursivelyAllSubviews:subview];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
