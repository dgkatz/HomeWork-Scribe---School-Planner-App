//
//  dataClass.h
//  HomeWork Scribe
//
//  Created by Family on 3/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataClass : NSObject {
    NSMutableArray *assignmentData_Subject;
    NSMutableArray *assignmentData_Date;
    NSMutableArray *assignmentData_Description;
}
@property(nonatomic,retain)NSMutableArray *assignmentData_Subject;
@property(nonatomic,retain)NSMutableArray *assignmentData_Date;
@property(nonatomic,retain)NSMutableArray *assignmentData_Description;
+(dataClass*)getInstance;
@end
