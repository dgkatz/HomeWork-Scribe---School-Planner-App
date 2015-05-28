//
//  colorsettingsTableViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/22/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "colorsettingsTableViewController.h"
#import "InfColorPicker.h"
#import "dataClass.h"
@interface colorsettingsTableViewController ()

@end
NSArray *data;
UIColor *color;
int selectedindex;
NSArray *colorArray;
NSMutableArray *subjects;
int selectedHeightIndex;
@implementation colorsettingsTableViewController

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedHeightIndex = 20;
    subjects=[[[NSUserDefaults standardUserDefaults] objectForKey:@"usersSubjects"] mutableCopy];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    data = [[NSUserDefaults standardUserDefaults] objectForKey:@"usersSubjects"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    int indexNum = (int)[data indexOfObject:cell.textLabel.text];
    NSArray *colors =[[NSUserDefaults standardUserDefaults] objectForKey:@"usersColors"];
    NSData *colorData = [colors objectAtIndex:indexNum];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    cell.textLabel.textColor = color;    // Configure the cell...
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *selectedSubject;
    selectedSubject = [subjects objectAtIndex:indexPath.row];
    [subjects removeObject:[NSString stringWithFormat:@"%@",selectedSubject]];
    [[NSUserDefaults standardUserDefaults]setObject:subjects forKey:@"usersSubjects"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self viewDidLoad];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
            return 44;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"subjectDetail"]) {
        UITableViewCell *cell = (UITableViewCell*)sender;
        dataClass *obj = [dataClass getInstance];
        obj.defaultColor = cell.textLabel.textColor;
        obj.subject = cell.textLabel.text;


    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
