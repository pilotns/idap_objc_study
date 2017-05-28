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
#import "AMPMacros.h"

#import "NSObject+AMPExtensions.h"
#import "NSTimer+AMPExtensions.h"

static const NSUInteger AMPDefaultCarCount = 30;
static const NSUInteger AMPDefaultTimeInterval = 2;
static const NSUInteger AMPDefaultFireCount = 5;

@interface AMPCarWash ()
@property (nonatomic, assign)   NSTimer                 *timer;
@property (nonatomic, retain)   AMPCarWashController    *controller;

@property (nonatomic, assign)   NSUInteger  fireCount;

- (void)washCars:(NSArray *)cars;
- (void)prepareTimer;

@end

@implementation AMPCarWash;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.controller = nil;
    self.timer = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.controller = [AMPCarWashController object];
    [self prepareTimer];
    
    return self;
}

- (void)setTimer:(NSTimer *)timer {
    if (_timer != timer) {
        [_timer invalidate];
        _timer = timer;
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)washCars:(NSArray *)cars {
    [self.controller washCars:cars];
}

- (void)prepareTimer {
    AMPWeakify(self);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:AMPDefaultTimeInterval
                                                 repeats:YES
                                                 handler:^(NSTimer *timer)
    {
        AMPStrongify(self)
        NSArray *cars = [AMPCar objectsWithCount:AMPDefaultCarCount];
        [self performSelectorInBackground:@selector(washCars:)
                               withObject:cars];
        
        if (AMPDefaultFireCount == (self.fireCount += 1)) {
            self.timer = nil;
        }
    }];
}

@end
