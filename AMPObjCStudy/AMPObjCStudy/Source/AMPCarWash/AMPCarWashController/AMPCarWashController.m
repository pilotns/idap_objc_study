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
#import "NSArray+AMPExtensions.h"

typedef NSArray *(^AMPEmployeeGenerator)(Class class, NSUInteger count, id observer);

static const NSUInteger AMPDefaultWasherCount       = 20;
static const NSUInteger AMPDefaultAccountantCount   = 10;
static const NSUInteger AMPDefaultDirectorCount     = 1;

@interface AMPCarWashController () <AMPEmployeeObsever>
@property (nonatomic, retain)   AMPDispatcher   *washersDispatcher;
@property (nonatomic, retain)   AMPDispatcher   *accountantsDispatcher;
@property (nonatomic, retain)   AMPDispatcher   *directorsDispatcher;

- (void)prepareHierarchy;

@end

@implementation AMPCarWashController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.washersDispatcher = nil;
    self.accountantsDispatcher = nil;
    self.directorsDispatcher = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.washersDispatcher = [AMPDispatcher object];
    self.accountantsDispatcher = [AMPDispatcher object];
    self.directorsDispatcher = [AMPDispatcher object];
    
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

- (void)prepareHierarchy {
    AMPEmployeeGenerator generator = ^NSArray *(Class class, NSUInteger count, id observer){
        return [NSArray objectsWithCount:count factoryBlock:^id{
            id employee = [class object];
            [employee addObserver:observer];
            
            return employee;
        }];
    };
    
    AMPDispatcher *accountantsDispatcher = self.accountantsDispatcher;
    AMPDispatcher *directorsDispatcher = self.directorsDispatcher;
    
    NSArray *washers = generator([AMPWasher class], AMPDefaultWasherCount, accountantsDispatcher);
    NSArray *accountants = generator([AMPAccountant class], AMPDefaultAccountantCount, directorsDispatcher);
    NSArray *directors = generator([AMPDirector class], AMPDefaultDirectorCount, nil);
    
    [self.washersDispatcher addWorkers:washers];
    [accountantsDispatcher addWorkers:accountants];
    [directorsDispatcher addWorkers:directors];
}

@end
