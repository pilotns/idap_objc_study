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
#import "AMPHiringManager.h"
#import "AMPWasherDispatcher.h"
#import "AMPAccountantDispatcher.h"
#import "AMPDirectorDispatcher.h"

#import "NSObject+AMPExtensions.h"
#import "NSSet+AMPExtensions.h"

static const NSUInteger AMPDefaultWasherCount = 20;
static const NSUInteger AMPDefaultAccountantCount = 10;

@interface AMPCarWashController () <AMPEmployeeObsever, AMPHiringManagerDelegate>
@property (nonatomic, retain)   AMPHiringManager    *hiringManager;

@property (nonatomic, retain)   AMPWasherDispatcher     *washersDispatcher;
@property (nonatomic, retain)   AMPAccountantDispatcher *accountantsDispancher;
@property (nonatomic, retain)   AMPDirectorDispatcher   *directorDispatcher;

- (Class)observerClassForEmployee:(AMPHuman *)employee;
- (NSArray *)observersForEmployee:(AMPHuman *)employee;

- (void)prepareDispatchers;
- (void)prepareHierarchy;

@end

@implementation AMPCarWashController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.hiringManager = nil;
    self.washersDispatcher = nil;
    self.accountantsDispancher = nil;
    self.directorDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.hiringManager = [AMPHiringManager object];
    self.washersDispatcher = [AMPWasherDispatcher object];
    self.accountantsDispancher = [AMPAccountantDispatcher object];
    self.directorDispatcher = [AMPDirectorDispatcher object];
    
    [self prepareHierarchy];
    [self prepareDispatchers];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setHiringManager:(AMPHiringManager *)hiringManager {
    if (_hiringManager != hiringManager) {
        _hiringManager.delegate = nil;
        [_hiringManager release];
        
        _hiringManager = [hiringManager retain];
        _hiringManager.delegate = self;
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)washCars:(NSArray *)cars {
    if (!cars.count) {
        return;
    }
    
    [self.washersDispatcher addObjectsForProcessing:cars];
}

#pragma mark -
#pragma mark Private Methods

- (Class)observerClassForEmployee:(AMPHuman *)employee {
    if ([employee isKindOfClass:[AMPAccountant class]]) {
        return [AMPDirector class];
    }
    
    if ([employee isKindOfClass:[AMPWasher class]]) {
        return [AMPAccountant class];
    }
    
    return Nil;
}

- (id)observersForEmployee:(NSArray *)employee {
    if ([employee isKindOfClass:[AMPWasher class]]) {
        return @[self.washersDispatcher, self.accountantsDispancher];
    }
    
    if ([employee isKindOfClass:[AMPAccountant class]]) {
        return @[self.accountantsDispancher, self.directorDispatcher];
    }
    
    if ([employee isKindOfClass:[AMPDirector class]]) {
        return @[self.directorDispatcher];
    }
    
    return nil;
}

- (void)prepareDispatchers {
    NSSet *washers = [self.hiringManager employeesWithClass:[AMPWasher class]];
    NSSet *accountants = [self.hiringManager employeesWithClass:[AMPAccountant class]];
    NSSet *directors = [self.hiringManager employeesWithClass:[AMPDirector class]];
    
    [self.washersDispatcher addWorkers:washers];
    [self.accountantsDispancher addWorkers:accountants];
    [self.directorDispatcher addWorkers:directors];
}

- (void)prepareHierarchy {
    NSArray *shift = @[@[[AMPDirector object]],
                         [AMPAccountant objectsWithCount:AMPDefaultAccountantCount],
                         [AMPWasher objectsWithCount:AMPDefaultWasherCount]];
    
    [self.hiringManager hireEmployees:shift];
}

#pragma mark -
#pragma mark AMPHiringManagerDelegate

- (NSArray *)hiringManager:(AMPHiringManager *)manager observersForEmployee:(AMPHuman *)employee {
    return [self observersForEmployee:employee];
}

@end
