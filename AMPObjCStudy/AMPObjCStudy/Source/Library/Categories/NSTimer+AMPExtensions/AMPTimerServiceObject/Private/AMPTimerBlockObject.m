//
//  AMPTimerBlockObject.m
//  AMPObjCStudy
//
//  Created by pilotns on 04.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPTimerBlockObject.h"

@interface AMPTimerBlockObject ()
@property (nonatomic, copy) AMPTimerFiringHandler handler;

@end

@implementation AMPTimerBlockObject

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
#pragma mark Publi Methods

- (void)fireTimer:(NSTimer *)timer {
    AMPTimerFiringHandler handler = self.handler;
    if (handler) {
        handler(timer);
    }
}

@end
