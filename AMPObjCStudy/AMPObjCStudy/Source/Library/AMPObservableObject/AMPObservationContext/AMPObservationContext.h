//
//  AMPObservationContext.h
//  AMPObjCStudy
//
//  Created by pilotns on 28.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPPrivate.h"

@class AMPBlockObservableObject;

@interface AMPObservationContext : NSObject
@property (nonatomic, readonly) id                          observer;
@property (nonatomic, readonly) AMPBlockObservableObject    *observableObject;

+ (instancetype)contextWithObserver:(id)observer
                   observableObject:(AMPBlockObservableObject *)observableObject;

- (instancetype)initWithObserver:(id)observer
                observableObject:(AMPBlockObservableObject *)observableObject;

- (void)setHandler:(AMPObservationHandler)handler forState:(NSUInteger)state;
- (void)removeHandlerForState:(NSUInteger)state;
- (AMPObservationHandler)handlerForState:(NSUInteger)state;
- (void)notifyOfState:(NSUInteger)state userInfo:(id)userInfo;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)handler atIndexedSubscript:(NSUInteger)index;

- (BOOL)isEqualToObservationContext:(AMPObservationContext *)context;

@end
