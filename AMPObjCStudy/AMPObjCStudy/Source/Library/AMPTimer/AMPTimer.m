//
//  AMPTimer.m
//  AMPObjCStudy
//
//  Created by pilotns on 28.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPTimer.h"

#import "AMPGCDExtensions.h"
#import "AMPMacros.h"

@interface AMPTimer ()
@property (nonatomic, assign)   NSUInteger      timeInteraval;
@property (nonatomic, assign)   BOOL            repeats;
@property (nonatomic, copy)     AMPTimerHandler handler;

@property (nonatomic, retain)   dispatch_group_t    group;

@property (nonatomic, assign, getter=isValid)   BOOL    valid;

- (void)fire;

@end

@implementation AMPTimer

#pragma mark -
#pragma mark Class Methods

+ (instancetype)timerWithTimeInterval:(NSUInteger)timeInterval
                              repeats:(BOOL)repeats
                              handler:(AMPTimerHandler)handler
{
    return [[[self alloc] initWithTimeInterval:timeInterval
                                       repeats:repeats
                                       handler:handler] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.handler = nil;
    self.group = nil;
    
    [super dealloc];
}

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (instancetype)initWithTimeInterval:(NSUInteger)timeInterval
                             repeats:(BOOL)repeats
                             handler:(AMPTimerHandler)handler
{
    self = [super init];
    self.timeInteraval = timeInterval;
    self.repeats = repeats;
    self.handler = handler;
    self.group = dispatch_group_create();
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setHandler:(AMPTimerHandler)handler {
    if (_handler != handler) {
        Block_release(_handler);
        
        if (handler) {
            _handler = Block_copy(handler);
            self.valid = YES;
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)resume {
    [self fire];
}

- (void)invalidate {
    self.valid = NO;
}

#pragma mark -
#pragma mark Private Methods

- (void)fire {
    AMPTimerHandler handler = self.handler;
    if (!handler) {
        return;
    }
    
    if (self.isValid) {
        AMPWeakify(self);
        dispatch_group_t group = self.group;
        dispatch_group_enter(group);
        AMPDispatchAfterDelayOnQueue(AMPBackgroundQueue(), self.timeInteraval, ^{
            AMPStrongify(self);
            handler(self);
            dispatch_group_leave(group);
            
            dispatch_group_notify(group, AMPBackgroundQueue(), ^{
                AMPStrongify(self);
                if (self.repeats) {
                    [self fire];
                }
            });
        });
    }
}

@end
