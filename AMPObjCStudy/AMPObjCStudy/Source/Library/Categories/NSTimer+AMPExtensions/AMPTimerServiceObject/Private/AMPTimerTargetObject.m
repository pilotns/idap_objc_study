//
//  AMPTimerTargetObject.m
//  AMPObjCStudy
//
//  Created by pilotns on 04.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPTimerTargetObject.h"

@interface AMPTimerTargetObject ()
@property (nonatomic, assign)   id  target;
@property (nonatomic, assign)   SEL selector;

@end

@implementation AMPTimerTargetObject

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    self = [super init];
    self.target = target;
    self.selector = selector;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)fireTimer:(NSTimer *)timer {
    id target = self.target;
    SEL selector = self.selector;
    
    if ([target respondsToSelector:selector]) {
        [target performSelector:selector withObject:timer];
    }
}

@end
