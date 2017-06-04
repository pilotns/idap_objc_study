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
#import "AMPTimerServiceObject.h"

#import "NSObject+AMPExtensions.h"
#import "NSTimer+AMPExtensions.h"

static const NSUInteger AMPDefaultCarCount = 100;
static const NSUInteger AMPDefaultTimeInterval = 2;
static const NSUInteger AMPDefaultFireCount = 5;

@interface AMPCarWash ()
@property (nonatomic, retain)   NSTimer                 *timer;
@property (nonatomic, retain)   AMPCarWashController    *controller;

@property (nonatomic, assign)   NSUInteger  fireCount;

- (void)washCars:(NSArray *)cars;
- (void)prepareTimer;
- (void)fireTimer:(NSTimer *)timer;

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

- (void)fireTimer:(NSTimer *)timer {
    NSArray *cars = [AMPCar objectsWithCount:AMPDefaultCarCount];
    [self performSelectorInBackground:@selector(washCars:)
                           withObject:cars];
    
    if (AMPDefaultFireCount == (self.fireCount += 1)) {
        self.timer = nil;
    }
}

- (void)prepareTimer {
    self.timer = [NSTimer safeScheduledTimerWithTimeInterval:AMPDefaultTimeInterval
                                                     target:self
                                                   selector:@selector(fireTimer:)
                                                   userInfo:nil
                                                    repeats:YES];
}

@end
