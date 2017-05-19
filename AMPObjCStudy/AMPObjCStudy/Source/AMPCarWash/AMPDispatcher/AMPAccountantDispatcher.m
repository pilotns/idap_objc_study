//
//  AMPAccountantDispatcher.m
//  AMPObjCStudy
//
//  Created by pilotns on 16.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPAccountantDispatcher.h"

#import "AMPWasher.h"
#import "AMPAccountant.h"
#import "AMPQueue.h"

@implementation AMPAccountantDispatcher

#pragma mark -
#pragma mark AMPEmployeeObserver

- (void)employeeDidFinishWork:(id<AMPDispatcherWorkingProcess>)employee {
    if (![employee isKindOfClass:[AMPWasher class]]) {
        return;
    }
    
    [self performWorkingProcessWithObject:employee];
}

- (void)employeeDidBecomeFree:(id)employee {
    if (![employee isKindOfClass:[AMPAccountant class]]) {
        return;
    }
    
    [self workerDidBecomeFree:employee];
}

@end
