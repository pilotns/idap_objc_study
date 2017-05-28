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

#import "NSObject+AMPExtensions.h"
#import "NSSet+AMPExtensions.h"

static const NSUInteger AMPDefaultWasherCount       = 20;
static const NSUInteger AMPDefaultAccountantCount   = 10;
static const NSUInteger AMPDefaultDirectorCount     = 1;

@interface AMPCarWashController () <AMPEmployeeObsever>
@property (nonatomic, retain)   AMPDispatcher   *washersDispatcher;
@property (nonatomic, retain)   AMPDispatcher   *accountantsDispancher;
@property (nonatomic, retain)   AMPDispatcher   *directorDispatcher;

- (NSArray *)observersForEmployee:(AMPWorker *)employee;
- (void)prepareObservationForEmployees:(NSArray *)employees handler:(void (^)(AMPWorker *))handler;

- (void)prepareHierarchy;

@end

@implementation AMPCarWashController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.washersDispatcher = nil;
    self.accountantsDispancher = nil;
    self.directorDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.washersDispatcher = [AMPDispatcher object];
    self.accountantsDispancher = [AMPDispatcher object];
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

- (id)observersForEmployee:(NSArray *)employee {
    if ([employee isKindOfClass:[AMPWasher class]]) {
        return @[self.accountantsDispancher];
    }
    
    if ([employee isKindOfClass:[AMPAccountant class]]) {
        return @[self.directorDispatcher];
    }
    
    return nil;
}

- (void)prepareObservationForEmployees:(NSArray *)employees handler:(void (^)(AMPWorker *employee))handler {
    if (!handler) {
        return;
    }
    
    [employees enumerateObjectsUsingBlock:^(id employee, NSUInteger idx, BOOL *stop) {
        handler(employee);
    }];
}

- (void)prepareHierarchy {
    NSArray *washers = [AMPWasher objectsWithCount:AMPDefaultWasherCount];
    NSArray *accountants = [AMPAccountant objectsWithCount:AMPDefaultAccountantCount];
    NSArray *directors = [AMPDirector objectsWithCount:AMPDefaultDirectorCount];
    
    [self.washersDispatcher addWorkers:washers];
    [self prepareObservationForEmployees:washers handler:^(AMPWorker *employee) {
        [employee addObserver:self.accountantsDispancher];
    }];
    
    [self.accountantsDispancher addWorkers:accountants];
    [self prepareObservationForEmployees:accountants handler:^(AMPWorker *employee) {
        [employee addObserver:self.directorDispatcher];
    }];
    
    [self.directorDispatcher addWorkers:directors];
}

@end
