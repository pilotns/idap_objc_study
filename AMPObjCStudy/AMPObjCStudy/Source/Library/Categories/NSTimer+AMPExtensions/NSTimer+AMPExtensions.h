//
//  NSTimer+AMPExtensions.h
//  AMPObjCStudy
//
//  Created by pilotns on 23.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (AMPExtensions)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                    repeats:(BOOL)repeats
                                    handler:(void (^)(NSTimer *timer))handler;

@end
