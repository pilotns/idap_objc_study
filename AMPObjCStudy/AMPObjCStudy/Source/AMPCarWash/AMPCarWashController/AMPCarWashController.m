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

#import "NSObject+AMPExtensions.h"
#import "NSSet+AMPExtensions.h"

#define AMPPerformWash(washer, car) \
    if (!##car) { \
        return; \
    } \
    \
    [washer performWorkWithObject:car];

extern
NSArray* AMPObjectsWithClassInCollection(Class class, id<NSFastEnumeration> collection);

static const NSUInteger AMPDefaultWasherCount = 10;

@interface AMPCarWashController () <AMPEmployeeObsever>
@property (nonatomic, retain)   NSMutableSet    *employees;

- (Class)observerClassForEmployee:(AMPHuman *)employee;
- (AMPHuman *)observerForEmployee:(AMPHuman *)employee;

- (void)hireEmployee:(id)employee;
- (void)dismissEmployee:(id)employee;

- (void)hireEmployees:(NSArray *)employees;

- (id)employeeWithClass:(Class)class;
- (NSSet *)employeesWithClass:(Class)class;
- (NSSet *)freeEmployeesWithClass:(Class)class;

- (id)dequeueCar;
- (void)prepareHierarchy;
- (void)performWork;

@end

@implementation AMPCarWashController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.employees = nil;
    self.carQueue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.employees = [NSMutableSet set];
    self.carQueue = [AMPQueue object];
    [self prepareHierarchy];
    
    return self;
}

#pragma mark -
#pragma mark AMPEmployeeObserver

- (void)employeeDidBecomeFree:(AMPHuman<AMPMoneyFlow> *)employee {
    id car = [self.carQueue pop];
    if (car) {
        [employee performWorkWithObject:car];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)washCar:(AMPCar *)car {
    if (!car) {
        return;
    }
    
    [self.carQueue pushObject:car];
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

- (AMPHuman *)observerForEmployee:(AMPHuman *)employee {
    return [self employeeWithClass:[self observerClassForEmployee:employee]];
}

- (void)hireEmployee:(id)employee {
    if (!employee) {
        return;
    }
    
    @synchronized (self) {
        AMPHuman *observer = [self observerForEmployee:employee];
        if (observer) {
            [employee addObserver:observer];
        }
        
        if ([employee isKindOfClass:[AMPWasher class]]) {
            [employee addObserver:self];
        }
        
        [self.employees addObject:employee];
    }
}

- (void)dismissEmployee:(id)employee {
    @synchronized (self) {
        [self.employees removeObject:employee];
    }
}

- (void)hireEmployees:(NSArray *)employees {
    for (id employee in employees) {
        [self hireEmployee:employee];
    }
}

- (id)employeeWithClass:(Class)class {
    return [[self employeesWithClass:class] anyObject];
}

- (NSSet *)employeesWithClass:(Class)class {
    @synchronized (self) {
        return [NSSet setWithArray:AMPObjectsWithClassInCollection(class, self.employees)];
    }
}

- (NSSet *)freeEmployeesWithClass:(Class)class {
    return [[self employeesWithClass:class] objectsPassingTest:^BOOL(AMPHuman *employee, BOOL *stop) {
        return employee.state == AMPEmployeeDidBecomeFree;
    }];
}

- (id)dequeueCar {
    return [self.carQueue pop];
}

- (void)prepareHierarchy {
    NSArray *shift = @[@[[AMPDirector object], [AMPAccountant object]],
                           [AMPWasher objectsWithCount:AMPDefaultWasherCount]];
    
    for (NSArray *employees in shift) {
        [self hireEmployees:employees];
    }
}

- (void)performWork {
    NSSet *washers = [self freeEmployeesWithClass:[AMPWasher class]];
    for (AMPWasher *washer in washers) {
        id car = [self dequeueCar];
        if (!car) {
            break;
        }
        
        [washer performWorkWithObject:car];
    }
}

@end
