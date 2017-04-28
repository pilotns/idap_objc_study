//
//  AMPBlockObservableObject.h
//  AMPObjCStudy
//
//  Created by pilotns on 28.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

#import "AMPPrivate.h"

@interface AMPBlockObservableObject : NSObject
@property (nonatomic, assign) NSUInteger  state;

- (void)addObserver:(id)observer forState:(NSUInteger)state withHandler:(AMPObservationHandler)handler;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer forState:(NSUInteger)state;

- (void)setState:(NSUInteger)state userInfo:(id)userInfo;

@end
