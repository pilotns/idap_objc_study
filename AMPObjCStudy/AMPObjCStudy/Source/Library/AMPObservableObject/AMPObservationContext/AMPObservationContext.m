//
//  AMPObservationContext.m
//  AMPObjCStudy
//
//  Created by pilotns on 28.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservationContext.h"

@interface AMPObservationContext ()
@property (nonatomic, assign)   id                          observer;
@property (nonatomic, assign)   AMPBlockObservableObject    *observableObject;
@property (nonatomic, retain)   NSMutableDictionary         *stateHandlers;

@end

@implementation AMPObservationContext

#pragma mark -
#pragma mark Class Methods

+ (instancetype)contextWithObserver:(id)observer
                   observableObject:(AMPBlockObservableObject *)observableObject
{
    return [[[self alloc] initWithObserver:observer observableObject:observableObject] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.stateHandlers = nil;
    
    [super dealloc];
}

- (instancetype)initWithObserver:(id)observer
                observableObject:(AMPBlockObservableObject *)observableObject
{
    self = [super init];
    self.observer = observer;
    self.observableObject = observableObject;
    self.stateHandlers = [NSMutableDictionary dictionary];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)setHandler:(AMPObservationHandler)handler forState:(NSUInteger)state {    
    [self.stateHandlers setObject:[handler copy] forKey:@(state)];
}

- (void)removeHandlerForState:(NSUInteger)state {
    [self.stateHandlers removeObjectForKey:@(state)];
}

- (AMPObservationHandler)handlerForState:(NSUInteger)state {
    return [self.stateHandlers objectForKey:@(state)];
}

- (void)notifyOfState:(NSUInteger)state userInfo:(id)userInfo {
    AMPObservationHandler handler = self[state];
    if (handler) {
        handler(self.observer, self.observableObject, userInfo);
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self handlerForState:index];
}

- (void)setObject:(id)handler atIndexedSubscript:(NSUInteger)index {
    [self setHandler:handler forState:index];
}

#pragma mark -
#pragma mark Equality

- (NSUInteger)hash {
    return [self.observer hash] ^ [self.observableObject hash];
}

- (BOOL)isEqual:(AMPObservationContext *)context {
    if (!context) {
        return NO;
    }
    
    if (self == context) {
        return YES;
    }
    
    return [self isEqualToObservationContext:context];
}

- (BOOL)isEqualToObservationContext:(AMPObservationContext *)context {
    return self.observer == context.observer
        && self.observableObject == context.observableObject;
}

@end
