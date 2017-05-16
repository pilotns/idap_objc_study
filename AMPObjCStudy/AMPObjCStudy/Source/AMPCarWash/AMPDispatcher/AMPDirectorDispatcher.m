//
//  AMPDirectorDispatcher.m
//  AMPObjCStudy
//
//  Created by pilotns on 16.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDirectorDispatcher.h"

#import "AMPAccountant.h"
#import "AMPDirector.h"

@implementation AMPDirectorDispatcher

#pragma mark -
#pragma mark AMPEmployeeObserver

- (void)employeeDidFinishWork:(id<AMPDispatcherWorkingProcess>)employee {
    if (![employee isKindOfClass:[AMPAccountant class]]) {
        return;
    }
    
    [self performWorkingProcessWithObject:employee];
}

- (void)employeeDidBecomeFree:(id)employee {
    if (![employee isKindOfClass:[AMPDirector class]]) {
        return;
    }
    
    [self workerDidBecomeFree:employee];
}

@end
