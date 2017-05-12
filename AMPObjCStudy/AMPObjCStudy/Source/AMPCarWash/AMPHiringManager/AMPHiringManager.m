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

@interface AMPHiringManager ()
@property (nonatomic, retain)   NSMutableSet    *employees;

- (void)hireEmployee:(id)employee;
- (void)dismissEmployee:(id)employee;

- (void)hireEmployees:(NSArray *)employees;

- (void)prepareObservationForEmployee:(AMPHuman *)employee selector:(SEL)selector;

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
        [self prepareObservationForEmployee:employee selector:@selector(addObserver:)];
        [self.employees addObject:employee];
    }
}

- (void)dismissEmployee:(id)employee {
    @synchronized (self) {
        [self prepareObservationForEmployee:employee selector:@selector(addObserver:)];
        [self.employees removeObject:employee];
    }
}

- (void)prepareObservationForEmployee:(AMPHuman *)employee selector:(SEL)selector {
    NSArray *observers = [self.delegate hiringManager:self observersForEmployee:employee];
    for (id observer in observers) {
        [employee performSelector:selector withObject:observer];
    }
}


@end
