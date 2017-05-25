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

static const NSUInteger AMPDefaultCarCount = 30;
static const NSUInteger AMPDefaultTimeInterval = 2;
static const NSUInteger AMPDefaultFireCount = 5;

@interface AMPCarWash ()
@property (nonatomic, retain)   AMPCarWashController    *controller;
@property (nonatomic, retain)   dispatch_source_t       timer;

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

- (void)setTimer:(dispatch_source_t)timer {
    if (_timer != timer) {
        if (_timer) {
            dispatch_source_cancel(_timer);
            dispatch_release(timer);
        }
        
        _timer = timer;
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)prepareTimer {
    AMPWeakify(self);
    self.timer = AMPCreateDispatchTimerOnQueue(AMPGetGlobalBackgroundQueue(), AMPDefaultTimeInterval, ^{
        AMPStrongify(self);
        NSArray *cars = [AMPCar objectsWithCount:AMPDefaultCarCount];
        [self.controller washCars:cars];
    });
//    __block NSUInteger fireCount = 0;
//    __block typeof(self) weakSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:AMPDefaultTimeInterval
//                                                 repeats:YES
//                                                 handler:^(NSTimer *timer)
//    {
//        __strong typeof(self) strongSelf = weakSelf;
//        if (!strongSelf) {
//            return;
//        }
//        
//        NSArray *cars = [AMPCar objectsWithCount:AMPDefaultCarCount];
//        [strongSelf.controller performSelectorInBackground:@selector(washCars:)
//                                                withObject:cars];
//        fireCount++;
//        if (AMPDefaultFireCount == fireCount) {
//            strongSelf.timer = nil;
//        }
//    }];
}

@end
