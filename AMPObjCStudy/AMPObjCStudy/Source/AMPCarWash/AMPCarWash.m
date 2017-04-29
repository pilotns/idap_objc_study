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
#import "NSSet+AMPExtensions.h"

static const NSUInteger AMPDefaultWasherCount = 10;

@interface AMPCarWash ()
@property (nonatomic, retain) NSMutableSet      *mutableEmployees;
@property (nonatomic, retain) NSMutableArray    *mutableCarQueue;

- (void)removeCarFromQueue:(AMPCar *)car;
- (void)hireEmployee:(AMPHuman<AMPMoneyFlow> *)employee;
- (void)dismissEmployee:(AMPHuman<AMPMoneyFlow> *)employee;
- (void)performWork;

- (id)employeeWithClass:(Class)aClass;
- (NSSet *)employeesWithClass:(Class)aClass;

- (id)director;
- (id)accountant;
- (id)washer;

- (void)prepareHierarchy;
- (void)hireEmployees:(NSArray *)employees;
- (AMPCar *)dequeueCar;

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

- (void)washCar:(AMPCar *)car {
    if (car) {
        [self.mutableCarQueue addObject:car];
        [self performWork];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)removeCarFromQueue:(AMPCar *)car {
    [self.mutableCarQueue removeObject:car];
}

- (Class)observerClassForEmployee:(AMPHuman *)employee {
    if ([employee isKindOfClass:[AMPAccountant class]]) {
        return [AMPDirector class];
    }
    
    if ([employee isKindOfClass:[AMPWasher class]]) {
        return [AMPAccountant class];
    }
    
    return Nil;
}

- (AMPHuman *)observerForEmployee:(AMPHuman *)employee {
    return [self employeeWithClass:[self observerClassForEmployee:employee]];
}

- (void)hireEmployee:(AMPHuman<AMPMoneyFlow> *)employee {
    AMPHuman *observer = [self observerForEmployee:employee];
    [employee addObserver:observer];
    
    [self.mutableEmployees addObject:employee];
}

- (void)dismissEmployee:(AMPHuman<AMPMoneyFlow> *)employee {
    [self.mutableEmployees removeObject:employee];
}

- (void)performWork {
    NSMutableArray *carQueue = self.mutableCarQueue;
    while (carQueue.count) {
        id car = [self dequeueCar];
        id washer = [self washer];
        if (washer) {
            [washer performWorkWithObject:car];
        }
    }
}

- (id)employeeWithClass:(Class)aClass {
    return [[self employeesWithClass:aClass] anyObject];
}

- (NSSet *)employeesWithClass:(Class)aClass {
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
    
    NSArray *shift = @[@[[AMPDirector object]], @[[AMPAccountant object]],
                           [AMPWasher objectsWithCount:AMPDefaultWasherCount]];
    
    for (NSArray *employees in shift) {
        [self hireEmployees:employees];
    }
}

- (void)hireEmployees:(NSArray *)employees {
    for (id employee in employees) {
        [self hireEmployee:employee];
    }
}

- (AMPCar *)dequeueCar {
    NSMutableArray *carsQueue = self.mutableCarQueue;
    AMPCar *car = [carsQueue objectAtIndex:0];
    [self removeCarFromQueue:car];
    
    return [[car retain] autorelease];
}

@end
