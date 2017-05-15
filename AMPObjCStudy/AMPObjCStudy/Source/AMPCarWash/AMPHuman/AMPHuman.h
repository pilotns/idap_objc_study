//
//  AMPHuman.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

#import "AMPMoneyFlow.h"

@class AMPQueue;

typedef NS_ENUM(NSUInteger, AMPWasherState) {
    AMPEmployeeDidBecomeFree,
    AMPEmployeeDidBecomeBusy,
    AMPEmployeeDidFinishWork
};

@protocol AMPEmployeeObsever <NSObject>

@optional
- (void)employeeDidBecomeFree:(id<AMPMoneyFlow>)employee;
- (void)employeeDidBecomeBusy:(id<AMPMoneyFlow>)employee;
- (void)employeeDidFinishWork:(id<AMPMoneyFlow>)employee;

@end

@interface AMPHuman : AMPObservableObject <AMPMoneyFlow, AMPEmployeeObsever>
@property (nonatomic, readonly) NSString    *name;
@property (nonatomic, readonly) AMPQueue    *queue;

- (void)performWorkWithObject:(id<AMPMoneyFlow>)object;

// this method is intended for subclassing, do not call it directly
- (void)handleObject:(id<AMPMoneyFlow>)object;

// this method is intended for subclassing, do not call it directly
- (void)finishProcessingObject:(id<AMPMoneyFlow>)object;

// this method is intended for subclassing, do not call it directly
- (void)finishProcessing;

@end
