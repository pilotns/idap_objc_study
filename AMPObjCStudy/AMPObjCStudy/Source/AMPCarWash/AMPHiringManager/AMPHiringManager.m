//
//  AMPHiringManager.m
//  AMPObjCStudy
//
//  Created by pilotns on 07.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPHiringManager.h"
#import "AMPAccountant.h"
#import "AMPWasher.h"

#import "NSSet+AMPExtensions.h"

typedef void(^AMPSetupObservationHandler)(id observer);

@interface AMPHiringManager ()
@property (nonatomic, retain)   NSMutableSet    *employees;

- (void)hireEmployee:(id)employee;
- (void)dismissEmployee:(id)employee;

- (void)hireEmployees:(NSArray *)employees;

- (void)prepareObservationForEmployee:(AMPWorker *)employee
                              handler:(AMPSetupObservationHandler)handler;

@end

@implementation AMPHiringManager

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.employees = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.employees = [NSMutableSet set];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)hireEmployees:(NSArray *)employees {
    for (id objects in employees) {
        for (id employee in objects) {
            [self hireEmployee:employee];
        }
    }
}

- (id)employeeWithClass:(Class)class {
    return [[self employeesWithClass:class] anyObject];
}

- (NSSet *)employeesWithClass:(Class)class {
    @synchronized (self) {
        return [self.employees objectsWithClass:class];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)hireEmployee:(id)employee {
    if (!employee) {
        return;
    }
    
    @synchronized (self) {
        [self prepareObservationForEmployee:employee handler:^(id observer) {
            [employee addObserver:observer];
        }];
        
        [self.employees addObject:employee];
    }
}

- (void)dismissEmployee:(id)employee {
    @synchronized (self) {
        [self prepareObservationForEmployee:employee handler:^(id observer) {
            [employee removeObserver:observer];
        }];
        
        [self.employees removeObject:employee];
    }
}

- (void)prepareObservationForEmployee:(AMPWorker *)employee handler:(AMPSetupObservationHandler)handler {
    if (!handler) {
        return;
    }
    
    NSArray *observers = [self.delegate hiringManager:self observersForEmployee:employee];
    for (id observer in observers) {
        handler(observer);
    }
}

@end
