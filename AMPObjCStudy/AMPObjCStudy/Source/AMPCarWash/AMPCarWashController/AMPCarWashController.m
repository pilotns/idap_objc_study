//
//  AMPCarWashController.m
//  AMPObjCStudy
//
//  Created by pilotns on 04.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCarWashController.h"

#import "AMPQueue.h"
#import "AMPDirector.h"
#import "AMPAccountant.h"
#import "AMPWasher.h"
#import "AMPDispatcher.h"
#import "AMPMacros.h"

#import "NSObject+AMPExtensions.h"
#import "NSSet+AMPExtensions.h"

static const NSUInteger AMPDefaultWasherCount       = 20;
static const NSUInteger AMPDefaultAccountantCount   = 10;
static const NSUInteger AMPDefaultDirectorCount     = 1;

@interface AMPCarWashController () <AMPEmployeeObsever>
@property (nonatomic, retain)   AMPDispatcher   *washersDispatcher;
@property (nonatomic, retain)   AMPDispatcher   *accountantsDispatcher;
@property (nonatomic, retain)   AMPDispatcher   *directorDispatcher;

- (id)observersForEmployee:(AMPWorker *)employee;

- (void)prepareObservationsForEmployees:(NSArray *)employees handler:(void (^)(AMPWorker *))handler;
- (void)prepareDispatcher:(AMPDispatcher *)dispatcher withWorkers:(NSArray *)workers;

- (void)prepareHierarchy;

@end

@implementation AMPCarWashController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.washersDispatcher = nil;
    self.accountantsDispatcher = nil;
    self.directorDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.washersDispatcher = [AMPDispatcher object];
    self.accountantsDispatcher = [AMPDispatcher object];
    self.directorDispatcher = [AMPDispatcher object];
    
    [self prepareHierarchy];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)washCars:(NSArray *)cars {
    if (!cars.count) {
        return;
    }
    
    [self.washersDispatcher processObjects:cars];
}

#pragma mark -
#pragma mark Private Methods

- (NSArray *)observersForEmployee:(AMPWorker *)employee {
    if ([employee isKindOfClass:[AMPWasher class]]) {
        return @[self.accountantsDispatcher, self.washersDispatcher];
    }
    
    if ([employee isKindOfClass:[AMPAccountant class]]) {
        return @[self.directorDispatcher, self.accountantsDispatcher];
    }
    
    if ([employee isKindOfClass:[AMPDirector class]]) {
        return @[self.directorDispatcher];
    }
    
    return nil;
}

- (void)prepareObservationsForEmployees:(NSArray *)employees handler:(void (^)(AMPWorker *employee))handler {
    if (!handler) {
        return;
    }
    
    [employees enumerateObjectsUsingBlock:^(id employee, NSUInteger idx, BOOL *stop) {
        handler(employee);
    }];
}

- (void)prepareDispatcher:(AMPDispatcher *)dispatcher withWorkers:(NSArray *)workers {
    [dispatcher addWorkers:workers];
    [self prepareObservationsForEmployees:workers handler:^(AMPWorker *worker) {
        NSArray *observers = [self observersForEmployee:worker];
        for (id observer in observers) {
            [worker addObserver:observer];
        }
    }];
}

- (void)prepareHierarchy {
    NSArray *washers = [AMPWasher objectsWithCount:AMPDefaultWasherCount];
    NSArray *accountants = [AMPAccountant objectsWithCount:AMPDefaultAccountantCount];
    NSArray *directors = [AMPDirector objectsWithCount:AMPDefaultDirectorCount];
    
    [self prepareDispatcher:self.washersDispatcher withWorkers:washers];
    [self prepareDispatcher:self.accountantsDispatcher withWorkers:accountants];
    [self prepareDispatcher:self.directorDispatcher withWorkers:directors];
}

@end
