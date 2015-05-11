//
//  dataClass.h
//  HomeWork Scribe
//
//  Created by Family on 3/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface dataClass : NSObject {
    NSMutableArray *assignmentData_Subject;
    NSMutableArray *assignmentData_Date;
    NSMutableArray *assignmentData_Description;
    NSString *description1;
    NSString *date;
    NSString *subject;
    NSString *description1Edit;
    NSString *dateEdit;
    NSString *subjectEdit;
    NSString *note;
    BOOL success;
    UIColor *defaultColor;

}
@property(nonatomic,retain)NSMutableArray *assignmentData_Subject;
@property(nonatomic,retain)NSMutableArray *assignmentData_Date;
@property(nonatomic,retain)NSMutableArray *assignmentData_Description;
@property(strong)NSString *description1;
@property(strong)NSString *date;
@property(strong)NSString *subject;
@property(strong)NSString *description1Edit;
@property(strong)NSString *dateEdit;
@property(strong)NSString *subjectEdit;
@property(strong)NSString *note;;
@property(strong)UIColor *defaultColor;
@property BOOL success;
+(dataClass*)getInstance;
@end
