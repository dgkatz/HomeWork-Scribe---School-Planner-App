//
//  colorsettingsTableViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/22/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "colorsettingsTableViewController.h"
#import "InfColorPicker.h"
@interface colorsettingsTableViewController ()

@end
NSArray *data;
UIColor *color;
int selectedindex;
NSArray *colorArray;
@implementation colorsettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    data = @[@"Math",@"Science",@"Social Studies",@"English",@"Language"];
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
    if (colorArray == nil) {
        if (indexPath.row == 0) {
            cell.textLabel.textColor = [UIColor colorWithRed:224/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f];
        }
        else if (indexPath.row == 1){
            cell.textLabel.textColor = [UIColor colorWithRed:109/255.0 green:158/255.0 blue:235/255.0 alpha:1.0f];
        }
        else if (indexPath.row == 2){
            cell.textLabel.textColor = [UIColor colorWithRed:106/255.0 green:168/255.0 blue:79/255.0 alpha:1.0f];
        }
        else if (indexPath.row == 3){
            cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:217/255.0 blue:102/255.0 alpha:1.0f];
        }
        else{
            cell.textLabel.textColor = [UIColor colorWithRed:246/255.0 green:178/255.0 blue:107/255.0 alpha:1.0f];
        }

    }
    else{
        cell.textLabel.textColor = [colorArray objectAtIndex:indexPath.row];
    }
    // Configure the cell...
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
