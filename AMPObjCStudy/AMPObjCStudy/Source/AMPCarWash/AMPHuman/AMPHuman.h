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
    AMPEmployeeDidBecomeBusy,
    AMPEmployeeDidFinishWork
};

@protocol AMPEmployeeObsever <NSObject>

@optional
- (void)employeeDidBecomeBusy:(id<AMPMoneyFlow>)employee;
- (void)employeeDidFinishWork:(id<AMPMoneyFlow>)employee;

@end

@interface AMPHuman : AMPObservableObject <AMPMoneyFlow, AMPEmployeeObsever>
@property (nonatomic, readonly) NSString    *name;

- (void)performWorkWithObject:(id<AMPMoneyFlow>)object;

// this method is intended for subсassing, do not call it directly
- (void)handlingObject:(id<AMPMoneyFlow>)object;

@end
