//
//  AddViewController.m
//  HomeWork Scribe
//
//  Created by Family on 3/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "AddViewController.h"
#import <XLFormTextView.h>
#import <XLFormDescriptor.h>
#import <XLFormRowDescriptor.h>
#import <XLFormSectionDescriptor.h>
#import <XLForm.h>
#import "SWRevealViewController.h"
#import "dataClass.h"
@interface AddViewController ()

@end
XLFormDescriptor * form;

@implementation AddViewController
- (IBAction)addAssignmnet:(id)sender {
    dataClass *obj = [dataClass getInstance];
    NSDictionary * values=[form formValues];
    if ([[values objectForKey:@"Description"]displayText]!=nil) {
        
        NSString *Subject = [[values objectForKey:@"SubjectPicker"] displayText];
        NSString *Description = [[values objectForKey:@"Description"] displayText];
        NSDate *date = [[values objectForKey:@"picker"]valueData];
        [obj.assignmentData_Subject addObject:Subject];
        [obj.assignmentData_Description addObject:Description];
        [obj.assignmentData_Date addObject:date];
        int d = [date timeIntervalSince1970];
        NSLog(@"subject: %@ description: %@ date: %@",Subject,Description,date);
        NSString *query = [NSString stringWithFormat:@"insert into assignmentData values(null, '%@', '%@', %d)", Description, Subject, d];
        NSLog(@"query fot database ---> %@",query);
        
        // Execute the query.
        [self.dbManager executeQuery:query];

    }

else{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add Description" message:@"description can't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];
        [self.dbManager executeQuery:@"create table if not exists assignmentData(hwID integer primary key, description text, subject text, due_date integer)"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:115/255.0 green:170/255.0 blue:217/255.0 alpha:1.0f];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    // Do any additional setup after loading the view.
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptorWithTitle:nil];
    
    // First section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];

    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];

    
    // Subject
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"SubjectPicker" rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"Subject"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Math"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Science"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Social Studies"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Language"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"English"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Math"];
    [section addFormRow:row];

    
    // Second Section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Description" rowType:XLFormRowDescriptorTypeText title:@"Description"];
    [section addFormRow:row];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"picker" rowType:XLFormRowDescriptorTypeDate title:@"Due Date"];
    row.value = [NSDate new];
    [row.cellConfigAtConfigure setObject:[NSDate new] forKey:@"minimumDate"];
    [row.cellConfigAtConfigure setObject:[NSDate dateWithTimeIntervalSinceNow:INFINITY] forKey:@"maximumDate"];
    [section addFormRow:row];

  
    
  
    self.form = form;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
