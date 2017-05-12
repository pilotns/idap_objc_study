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

#import "NSObject+AMPExtensions.h"
#import "NSSet+AMPExtensions.h"

static const NSUInteger AMPDefaultWasherCount = 10;

@interface AMPCarWashController () <AMPEmployeeObsever, AMPHiringManagerDelegate>
@property (nonatomic, retain)   AMPHiringManager    *hiringManager;

@property (nonatomic, retain)   AMPQueue    *carQueue;
@property (nonatomic, retain)   AMPQueue    *washerQueue;

- (Class)observerClassForEmployee:(AMPHuman *)employee;

- (void)prepareWasherQueue;
- (void)prepareHierarchy;
- (void)performWork;

- (id)dequeueCar;

@end

@implementation AMPCarWashController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.hiringManager = nil;
    self.carQueue = nil;
    self.washerQueue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.hiringManager = [AMPHiringManager object];
    self.washerQueue = [AMPQueue object];
    self.carQueue = [AMPQueue object];
    
    [self prepareHierarchy];
    [self prepareWasherQueue];
    
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

- (void)washCar:(AMPCar *)car {
    if (!car) {
        return;
    }
    
    [self.carQueue pushObject:car];
    [self performWork];
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

- (void)prepareWasherQueue {
    NSSet *washers = [self.hiringManager employeesWithClass:[AMPWasher class]];
    for (AMPWasher *washer in washers) {
        [self.washerQueue pushObject:washer];
    }
}

- (void)prepareHierarchy {
    NSArray *shift = @[@[[AMPDirector object], [AMPAccountant object]],
                       [AMPWasher objectsWithCount:AMPDefaultWasherCount]];
    
    [self.hiringManager hireEmployees:shift];
}

- (void)performWork {
    AMPWasher *washer = [self.washerQueue pop];
    if (washer) {
        id car = [self dequeueCar];
        [washer performWorkWithObject:car];
    }
}

- (id)dequeueCar {
    return [self.carQueue pop];
}

#pragma mark -
#pragma mark AMPHiringManagerDelegate

- (NSArray *)hiringManager:(AMPHiringManager *)manager observersForEmployee:(AMPHuman *)employee {
    AMPHuman *observer = [manager employeeWithClass:[self observerClassForEmployee:employee]];
    
    if (observer) {
        return [employee isKindOfClass:[AMPWasher class]] ? @[self, observer] : @[observer];
    }
    
    return nil;
}

#pragma mark -
#pragma mark AMPEmployeeObserver

- (void)employeeDidBecomeFree:(AMPHuman<AMPMoneyFlow> *)employee {
    id car = [self.carQueue pop];
    if (car) {
        [employee performWorkWithObject:car];
    } else {
        [self.washerQueue pushObject:employee];
    }
}

@end
