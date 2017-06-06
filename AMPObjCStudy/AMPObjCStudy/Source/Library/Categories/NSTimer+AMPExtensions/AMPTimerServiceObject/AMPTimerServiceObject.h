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
+ (instancetype)objectWithTarget:(id)target selector:(SEL)selector;

- (instancetype)initWithHandler:(AMPTimerFiringHandler)handler;
- (instancetype)initWithTarget:(id)target selector:(SEL)selector;

// this method is intended for subclassing
- (void)fireTimer:(NSTimer *)timer;

@end
