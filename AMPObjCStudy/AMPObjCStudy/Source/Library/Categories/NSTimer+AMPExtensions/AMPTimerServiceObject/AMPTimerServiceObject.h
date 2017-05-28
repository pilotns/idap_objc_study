//
//  AMPTimerServiceObject.h
//  AMPObjCStudy
//
//  Created by pilotns on 23.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AMPTimerFiringHandler)(NSTimer *) ;

@interface AMPTimerServiceObject : NSObject

+ (instancetype)objectWithHandler:(AMPTimerFiringHandler)handler;

- (instancetype)initWithHandler:(AMPTimerFiringHandler)handler;

- (void)fireTimer:(NSTimer *)timer;

@end
