//
//  AMPTimerServiceObject.m
//  AMPObjCStudy
//
//  Created by pilotns on 23.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPTimerServiceObject.h"

@implementation AMPTimerServiceObject

- (void)fireTimer:(NSTimer *)timer {
    void (^handler)(NSTimer *) = timer.userInfo[kAMPTimerHandlerKey];
    if (handler) {
        handler(timer);
    }
}

@end
