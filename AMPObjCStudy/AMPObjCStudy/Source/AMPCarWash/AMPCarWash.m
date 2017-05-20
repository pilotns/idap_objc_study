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

#import "NSObject+AMPExtensions.h"

static const NSUInteger AMPDefaultCarCount = 30;
static const NSUInteger AMPDefaultTimeInterval = 2;
static const NSUInteger AMPDefaultFireCount = 5;

@interface AMPCarWash ()
@property (nonatomic, assign)   NSTimer                 *timer;
@property (nonatomic, retain)   AMPCarWashController    *controller;

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

- (void)prepareTimer {
    __block NSUInteger count = 0;
    __block typeof(self) weakSelf = self;
    
    void(^block)(NSTimer *) = ^(NSTimer *timer){
        NSArray *cars = [AMPCar objectsWithCount:AMPDefaultCarCount];
        [weakSelf.controller performSelectorInBackground:@selector(washCars:) withObject:cars];
        count++;
        
        if (AMPDefaultFireCount == count) {
            [timer invalidate];
        }
    };
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:AMPDefaultTimeInterval
                                                 repeats:YES
                                                   block:block];
}

@end
