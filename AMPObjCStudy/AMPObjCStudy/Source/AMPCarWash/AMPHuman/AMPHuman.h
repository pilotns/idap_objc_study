//
//  AMPHuman.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

#import "AMPMoneyFlow.h"

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

- (void)performWorkWithObject:(id<AMPMoneyFlow>)object;

// this method will be executed in background
- (void)handlingObject:(id<AMPMoneyFlow>)object;

@end
