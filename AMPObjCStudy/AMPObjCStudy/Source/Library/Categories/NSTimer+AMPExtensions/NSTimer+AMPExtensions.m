//
//  NSTimer+AMPExtensions.m
//  AMPObjCStudy
//
//  Created by pilotns on 23.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSTimer+AMPExtensions.h"

#import "AMPTimerServiceObject.h"

#import "NSObject+AMPExtensions.h"

@implementation NSTimer (AMPExtensions)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                    repeats:(BOOL)repeats
                                    handler:(void (^)(NSTimer *timer))handler;
{
    if (!handler) {
        return nil;
    }
    
    AMPTimerServiceObject *t = [AMPTimerServiceObject objectWithHandler:handler];
    
    return [self scheduledTimerWithTimeInterval:timeInterval
                                         target:t
                                       selector:@selector(fireTimer:)
                                       userInfo:nil
                                        repeats:repeats];
}

+ (NSTimer *)safeScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                        target:(id)target
                                      selector:(SEL)selector
                                      userInfo:(id)userInfo
                                       repeats:(BOOL)repeats
{
    AMPTimerServiceObject *t = [AMPTimerServiceObject objectWithTarget:target selector:selector];
    
    return [self scheduledTimerWithTimeInterval:timeInterval
                                         target:t
                                       selector:@selector(fireTimer:)
                                       userInfo:userInfo
                                        repeats:repeats];
}

@end
