//
//  AMPCarWash.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCarWash.h"

#import "AMPAccountant.h"
#import "AMPDirector.h"
#import "AMPWasher.h"

#import "NSObject+AMPExtensions.h"

static const NSUInteger AMPDefaultWasherCount = 10;

@interface AMPCarWash ()
@property (nonatomic, retain) NSMutableSet      *mutableEmployees;
@property (nonatomic, retain) NSMutableArray    *mutableCarQueue;

- (id)employeeWithClass:(Class)aClass;
- (NSArray *)employeesWithClass:(Class)aClass;

- (id)director;
- (id)accountant;
- (id)washer;

- (void)prepareHierarchy;
- (void)hireEmployees:(NSArray *)employees;
- (AMPCar *)nextCar;

@end

@implementation AMPCarWash;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableCarQueue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableCarQueue = [NSMutableArray array];
    self.mutableEmployees = [NSMutableSet set];
    [self prepareHierarchy];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addCarInQueue:(AMPCar *)car {
    if (car) {
        [self.mutableCarQueue addObject:car];
        [self performWork];
    }
}

- (void)removeCarFromQueue:(AMPCar *)car {
    [self.mutableCarQueue removeObject:car];
}

- (void)hireEmployee:(AMPHuman<AMPMoneyFlow> *)employee {
    if ([employee isKindOfClass:[AMPAccountant class]]) {
        [employee addObserver:[self director]];
    }
    
    if ([employee isKindOfClass:[AMPWasher class]]) {
        [employee addObserver:[self accountant]];
    }
    
    [self.mutableEmployees addObject:employee];
}

- (void)dismissEmployee:(AMPHuman<AMPMoneyFlow> *)employee {
    [self.mutableEmployees removeObject:employee];
}

- (void)performWork {
    NSMutableArray *carQueue = self.mutableCarQueue;
    while (carQueue.count) {
        id car = [self nextCar];
        id washer = [self washer];
        if (washer) {
            [washer performWorkWithObject:car];    
        }
    }
}

#pragma mark -
#pragma mark Private Methods

- (id)employeeWithClass:(Class)aClass {
    return [[self employeesWithClass:aClass] firstObject];
}

- (NSArray *)employeesWithClass:(Class)aClass {
    return [self.mutableEmployees objectsWithClass:aClass];
}

- (id)director {
    return [self employeeWithClass:[AMPDirector class]];
}

- (id)accountant {
    return [self employeeWithClass:[AMPAccountant class]];
}

- (id)washer {
    return [self employeeWithClass:[AMPWasher class]];
}

- (void)prepareHierarchy {
    [self hireEmployee:[AMPDirector object]];
    [self hireEmployee:[AMPAccountant object]];
    [self hireEmployees:[AMPWasher objectsWithCount:AMPDefaultWasherCount]];
}

- (void)hireEmployees:(NSArray *)employees {
    for (id employee in employees) {
        [self hireEmployee:employee];
    }
}

- (AMPCar *)nextCar {
    NSMutableArray *carsQueue = self.mutableCarQueue;
    AMPCar *car = [carsQueue objectAtIndex:0];
    [self removeCarFromQueue:car];
    
    return car;
}

@end
