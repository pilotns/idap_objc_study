//
//  AMPTimerServiceObject.m
//  AMPObjCStudy
//
//  Created by pilotns on 23.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPTimerServiceObject.h"

@interface AMPTimerServiceObject ()
@property (nonatomic, copy) AMPTimerFiringHandler handler;

@end

@implementation AMPTimerServiceObject

#pragma mark -
#pragma mark Class Methods

+ (instancetype)objectWithHandler:(AMPTimerFiringHandler)handler {
    return [[[self alloc] initWithHandler:handler] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.handler = nil;
    
    [super dealloc];
}

- (instancetype)initWithHandler:(AMPTimerFiringHandler)handler {
    self = [super init];
    self.handler = handler;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)fireTimer:(NSTimer *)timer {
    AMPTimerFiringHandler handler = self.handler;
    if (handler) {
        handler(timer);
    }
}

@end
