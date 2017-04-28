//
//  AMPBlockObservableObject.m
//  AMPObjCStudy
//
//  Created by pilotns on 28.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPBlockObservableObject.h"

#import "AMPObservationContext.h"

@interface AMPBlockObservableObject ()
@property (nonatomic, retain)   NSMutableSet  *observayionContexts;

- (AMPObservationContext *)contextForObserver:(id)observer;
- (void)notifyOfStateChangeWithUserInfo:(id)userInfo;

@end

@implementation AMPBlockObservableObject

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observayionContexts = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.observayionContexts = [NSMutableSet set];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(NSUInteger)state {
    [self setState:state userInfo:nil];
}

- (void)setState:(NSUInteger)state userInfo:(id)userInfo {
    if (_state != state) {
        _state = state;
        
        [self notifyOfStateChangeWithUserInfo:userInfo];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)addObserver:(id)observer forState:(NSUInteger)state withHandler:(AMPObservationHandler)handler {
    if (!handler) {
        return;
    }

    AMPObservationContext *context = [self contextForObserver:observer];
    context[state] = handler;
    
    [self.observayionContexts addObject:context];
}

- (void)removeObserver:(id)observer {
    AMPObservationContext *context = [self contextForObserver:observer];
    if (context) {
        [self.observayionContexts removeObject:context];
    }
}

- (void)removeObserver:(id)observer forState:(NSUInteger)state {
    AMPObservationContext *context = [self contextForObserver:observer];
    if (context) {
        [context removeHandlerForState:state];
    }
}

#pragma mark -
#pragma mark Private Methods

- (AMPObservationContext *)contextForObserver:(id)observer {
    for (AMPObservationContext *context in self.observayionContexts) {
        if (context.observer == observer) {
            return context;
        }
    }
    
    return nil;
}

- (void)notifyOfStateChangeWithUserInfo:(id)userInfo {
    for (AMPObservationContext *context in self.observayionContexts) {
        [context notifyOfState:self.state userInfo:userInfo];
    }
}

@end
