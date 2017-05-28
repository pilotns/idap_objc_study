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
    
    return [self scheduledTimerWithTimeInterval:timeInterval
                                         target:[AMPTimerServiceObject objectWithHandler:handler]
                                       selector:@selector(fireTimer:)
                                       userInfo:nil
                                        repeats:repeats];
}

@end
