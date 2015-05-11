//
//  dataClass.m
//  HomeWork Scribe
//
//  Created by Family on 3/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "dataClass.h"

@implementation dataClass
@synthesize assignmentData_Subject;
@synthesize assignmentData_Date;
@synthesize assignmentData_Description;
@synthesize description1;
@synthesize subject;
@synthesize date;
@synthesize description1Edit;
@synthesize subjectEdit;
@synthesize dateEdit;
@synthesize success;
@synthesize note;
@synthesize defaultColor;

static dataClass *instance = nil;

+(dataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [dataClass new];
        }
    }
    return instance;
}
@end
