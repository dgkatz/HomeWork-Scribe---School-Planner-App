//
//  editAssignmentViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/22/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "editAssignmentViewController.h"
#import "AddViewController.h"
#import "allTableViewController.h"
#import <XLFormTextView.h>
#import <XLFormDescriptor.h>
#import <XLFormRowDescriptor.h>
#import <XLFormSectionDescriptor.h>
#import <XLForm.h>
#import "SWRevealViewController.h"
#import "dataClass.h"
#import "XLFormImageSelectorCell.h"
@interface editAssignmentViewController ()

@end
XLFormDescriptor * form;
@implementation editAssignmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *const XLFormRowDescriptorTypeImage = @"Test";
    [[XLFormViewController cellClassesForRowDescriptorTypes] setObject:[XLFormImageSelectorCell class] forKey:@"Test"];
    dataClass *obj = [dataClass getInstance];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];
    /*
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    */
    form = [XLFormDescriptor formDescriptorWithTitle:nil];
    /*
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
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:obj.subjectEdit];
    [section addFormRow:row];
    
    
    // Second Section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Description" rowType:XLFormRowDescriptorTypeText title:@"Description"];
    row.value = obj.description1Edit;
    [section addFormRow:row];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"picker" rowType:XLFormRowDescriptorTypeDate title:@"Due Date"];
    if (obj.dateEdit == nil) {
        row.value = [NSDate new];
    }
    else{
        row.value = obj.dateEdit;
    }
    row.value = [NSDate new];
    [row.cellConfigAtConfigure setObject:[NSDate new] forKey:@"minimumDate"];
    [row.cellConfigAtConfigure setObject:[NSDate dateWithTimeIntervalSinceNow:INFINITY] forKey:@"maximumDate"];
    [section addFormRow:row];
    self.form = form;
    */
    
    
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
    NSArray *savedSubjects= [[NSUserDefaults standardUserDefaults]objectForKey:@"usersSubjects"];
    ////nslog(@"subjects have length: %lu", (unsigned long)[savedSubjects count]);
    NSMutableArray *options= [[NSMutableArray alloc] init];
    for (int i=0; i<[savedSubjects count]; i++) {
        XLFormOptionsObject *obj=[XLFormOptionsObject formOptionsObjectWithValue:@(i) displayText:[savedSubjects objectAtIndex:i]];
        [options addObject:obj];
        
        //nslog(@"form options: %@ ", obj.displayText);
    }
    
    row.selectorOptions=options;
    /**
     row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Math"],
     [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Science"],
     [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Social Studies"],
     [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Language"],
     [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"English"]
     ];
     **/
    
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Math"];
    //    [row.cellConfigAtConfigure setObject:[UIColor colorWithRed:255/255.0 green:151/255.0 blue:0/255.0 alpha:1.0f] forKey:@"backgroundColor"];
    //    [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textLabel.color"];
    //    [row.cellConfig setObject:[UIColor whiteColor] forKey:@"detailTextLabel.color"];
    [section addFormRow:row];
    
    // Second Section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Description" rowType:XLFormRowDescriptorTypeText title:@"Description"];
    //    [row.cellConfigAtConfigure setObject:[UIColor colorWithRed:255/255.0 green:151/255.0 blue:0/255.0 alpha:1.0f] forKey:@"backgroundColor"];
    //    [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textLabel.color"];
    //    [row.cellConfig setObject:[UIColor whiteColor] forKey:@"detailTextLabel.color"];
    row.value = obj.description1Edit;
    [section addFormRow:row];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"picker" rowType:XLFormRowDescriptorTypeDate title:@"Due Date"];
    row.value = [NSDate new];
    //    [row.cellConfigAtConfigure setObject:[NSDate new] forKey:@"minimumDate"];
    //    [row.cellConfigAtConfigure setObject:[NSDate dateWithTimeIntervalSinceNow:INFINITY] forKey:@"maximumDate"];
    //    [row.cellConfigAtConfigure setObject:[UIColor colorWithRed:255/255.0 green:151/255.0 blue:0/255.0 alpha:1.0f] forKey:@"backgroundColor"];
    //    [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textLabel.color"];
    //    [row.cellConfig setObject:[UIColor whiteColor] forKey:@"detailTextLabel.color"];
    [section addFormRow:row];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"image" rowType:XLFormRowDescriptorTypeImage title:@"  Image Note"];
    row.value = obj.chosenAssignmentImage;
    [section addFormRow: row];
    
    self.form = form;
    
    
    
    
    

    // Do any additional setup after loading the view.
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    UIColor *customTitleColor = [UIColor greenColor];
    for (UIView *subview in actionSheet.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            
            [button setTitleColor:customTitleColor forState:UIControlStateHighlighted];
            [button setTitleColor:customTitleColor forState:UIControlStateNormal];
            [button setTitleColor:customTitleColor forState:UIControlStateSelected];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"doneEditing"]) {
        dataClass *obj = [dataClass getInstance];
        NSDictionary * values=[form formValues];
        if ([[values objectForKey:@"Description"]displayText]!=nil) {
            NSString *deleteQuery= [NSString stringWithFormat: @"DELETE FROM assignmentData WHERE description='%@'",obj.description1Edit];
            //nslog(@"%@",deleteQuery);
            [self.dbManager executeQuery:deleteQuery];
            NSString *Subject = [[values objectForKey:@"SubjectPicker"] displayText];
            NSString *Description = [[values objectForKey:@"Description"] displayText];
            NSDate *date = [[values objectForKey:@"picker"]valueData];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSString *newDate = [dateFormat stringFromDate:date];
            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
            [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
            NSDate *finalDate = [dateFormat2 dateFromString:newDate];
            [obj.assignmentData_Subject addObject:Subject];
            [obj.assignmentData_Description addObject:Description];
            [obj.assignmentData_Date addObject:finalDate];
            int d = [finalDate timeIntervalSince1970];
            //nslog(@"this is the date in add asignment%d",d);
            //nslog(@"subject: %@ description: %@ date: %@",Subject,Description,date);
            NSString *query = [NSString stringWithFormat:@"insert into assignmentData values(null, '%@', '%@', %d)", Description, Subject, d];
            //nslog(@"query fot database ---> %@",query);
            
            // Execute the query.
            [self.dbManager executeQuery:query];
            //allTableViewController *VC = (allTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"all"];
            //[self.navigationController presentViewController:VC animated:YES completion:nil];
            
        }
        
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add Description" message:@"description can't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
}
@end
