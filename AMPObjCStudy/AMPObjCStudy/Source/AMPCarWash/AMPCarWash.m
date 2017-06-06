//
//  AMPCarWash.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCarWash.h"

#import "AMPCarWashController.h"
#import "AMPCar.h"

#import "AMPGCDExtensions.h"
#import "AMPMacros.h"

#import "NSObject+AMPExtensions.h"
#import "NSTimer+AMPExtensions.h"

static const NSUInteger AMPDefaultCarCount = 3000;
static const NSUInteger AMPDefaultTimeInterval = 2;
static const NSUInteger AMPDefaultFireCount = 5;

@interface AMPCarWash ()
@property (nonatomic, retain)   AMPCarWashController    *controller;
@property (nonatomic, assign)   NSUInteger              fireCount;

- (void)washCars:(NSArray *)cars;

@end

@implementation AMPCarWash;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.controller = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.controller = [AMPCarWashController object];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)performWork {
    AMPWeakify(self);
    AMPPerformSheduledBlock(AMPDefaultTimeInterval, YES, ^(BOOL *stop){
        AMPStrongify(self);
        NSArray *cars = [AMPCar objectsWithCount:AMPDefaultCarCount];
        [self washCars:cars];
        
        if (AMPDefaultFireCount == (++self.fireCount)) {
            *stop = YES;
        }
    });
}

#pragma mark -
#pragma mark Private Methods

- (void)washCars:(NSArray *)cars {
    [self.controller washCars:cars];
}

@end
