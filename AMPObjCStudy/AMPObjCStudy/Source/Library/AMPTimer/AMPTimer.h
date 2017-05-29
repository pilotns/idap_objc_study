//
//  AMPTimer.h
//  AMPObjCStudy
//
//  Created by pilotns on 28.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPTimer;

typedef void(^AMPTimerHandler)(AMPTimer *timer);

@interface AMPTimer : NSObject

+ (instancetype)timerWithTimeInterval:(NSUInteger)timeInterval
                              repeats:(BOOL)repeats
                              handler:(AMPTimerHandler)handler;

- (instancetype)initWithTimeInterval:(NSUInteger)timeInterval
                             repeats:(BOOL)repeats
                             handler:(AMPTimerHandler)handler;

- (void)resume;
- (void)invalidate;

@end
