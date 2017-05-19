//
//  AMPWasherDispatcher.m
//  AMPObjCStudy
//
//  Created by pilotns on 16.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPWasherDispatcher.h"

#import "AMPQueue.h"
#import "AMPWasher.h"

@implementation AMPWasherDispatcher

#pragma mark -
#pragma mark AMPEmployeeObserver

- (void)employeeDidBecomeFree:(id)employee {
    if (![employee isKindOfClass:[AMPWasher class]]) {
        return;
    }
    
    [self workerDidBecomeFree:employee];
}

@end
