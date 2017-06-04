//
//  AMPTimerServiceObject.m
//  AMPObjCStudy
//
//  Created by pilotns on 23.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPTimerServiceObject.h"

#import "AMPTimerBlockObject.h"
#import "AMPTimerTargetObject.h"

@implementation AMPTimerServiceObject

#pragma mark -
#pragma mark Class Methods

+ (instancetype)objectWithHandler:(AMPTimerFiringHandler)handler {
    return [[[AMPTimerBlockObject alloc] initWithHandler:handler] autorelease];
}

+ (instancetype)objectWithTarget:(id)target selector:(SEL)selector{
    return [[[AMPTimerTargetObject alloc] initWithTarget:target selector:selector] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithHandler:(AMPTimerFiringHandler)handler {
    [self release];
    
    return [[AMPTimerBlockObject alloc] initWithHandler:handler];
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    [self release];
    
    return [[AMPTimerTargetObject alloc] initWithTarget:target selector:selector];
}

#pragma mark -
#pragma mark Public Methods

- (void)fireTimer:(NSTimer *)timer {
    [self doesNotRecognizeSelector:_cmd];
}

@end
