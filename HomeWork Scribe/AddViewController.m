//
//  AddViewController.m
//  HomeWork Scribe
//
//  Created by Family on 3/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "AddViewController.h"
#import "allTableViewController.h"
#import <XLFormTextView.h>
#import <XLFormDescriptor.h>
#import "XLFormImageSelectorCell.h"
#import <XLFormRowDescriptor.h>
#import <XLFormSectionDescriptor.h>
#import <XLForm.h>
#import "SWRevealViewController.h"
#import "dataClass.h"
#import "XLFormImageSelectorCell.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
@interface AddViewController ()

@end
XLFormDescriptor * form;

@implementation AddViewController
-(void)viewDidAppear:(BOOL)animated{
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Add Assignments Screen"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *const XLFormRowDescriptorTypeImage = @"Test";
    self.navigationController.toolbar.hidden = YES;
    [[XLFormViewController cellClassesForRowDescriptorTypes] setObject:[XLFormImageSelectorCell class] forKey:@"Test"];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    self.tableView.backgroundColor = [UIColor colorWithRed:255/255.0 green:151/255.0 blue:0/255.0 alpha:1.0f];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"homeworkdb.sql"];
        [self.dbManager executeQuery:@"create table if not exists assignmentData(hwID integer primary key, description text, subject text, due_date integer, image text)"];
    
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

    [section addFormRow: row];
    
    self.form = form;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    allTableViewController *VC = (allTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"all"];
    
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs insertObject:VC atIndex:[vcs count]-1];
    [self.navigationController setViewControllers:vcs animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"present"]) {
        dataClass *obj = [dataClass getInstance];
        NSDictionary * values=[form formValues];
        //nslog(@"%@",[form formValues]);
        if ([[values objectForKey:@"Description"]displayText]!=nil) {
            NSString *Subject = [[values objectForKey:@"SubjectPicker"] displayText];
            NSString *Description = [[values objectForKey:@"Description"] displayText];
            NSDate *date = [[values objectForKey:@"picker"]valueData];
            //UIImage *img = [[values objectForKey:@"image"]valueData];
            UIImage *img=[form formRowWithTag:@"image"].value;
            //nslog(@"The value of valuedata = %@",img);
            if ([values objectForKey:@"image"] == NULL) {
                //nslog(@"Error: No image selected");
            }
            //else{
                //img = [values objectForKey:@"image"];
             //   img = [UIImage imageWithCGImage:(__bridge CGImageRef)([values objectForKey:@"image"])];
            //}
            NSString *base64ImgString;
            if (img) {
                NSData *dataFromImg = UIImagePNGRepresentation(img);
                base64ImgString = [dataFromImg base64EncodedStringWithOptions:kNilOptions];
            }
            else{
                //nslog(@"base 64 string is null");
                base64ImgString = NULL;
            }
            ////nslog(@"the image : %@",img);
            
            //UInt8 *rawData = [dataFromImg bytes];
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
            NSString *query = [NSString stringWithFormat:@"insert into assignmentData values(null, '%@', '%@', %d ,'%@')", Description, Subject, d,base64ImgString];
            ////nslog(@"query fot database ---> %@",query);
            
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
