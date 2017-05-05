//
//  AMPObservableObject.m
//  AMPObjCStudy
//
//  Created by pilotns on 25.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

@interface AMPObservableObject ()
@property (nonatomic, retain)   NSHashTable     *mutableObservers;

- (void)notifyOfStateWithSelector:(SEL)aSelector;

@end

@implementation AMPObservableObject

@dynamic observers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableObservers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableObservers = [NSHashTable weakObjectsHashTable];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observers {
    @synchronized (self) {
        return [self.mutableObservers setRepresentation];
    }
}

- (void)setState:(NSUInteger)state {
    @synchronized (self) {
        if (_state != state) {
            _state = state;
            
            [self notifyOfStateWithSelector:[self selectorForState:state]];
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)addObserver:(id)observer {
    @synchronized (self) {
        [self.mutableObservers addObject:observer];
    }
}

- (void)removeObserver:(id)observer {
    @synchronized (self) {
        [self.mutableObservers removeObject:observer];
    }
}

- (BOOL)isObserver:(id)observer {
    @synchronized (self) {
        return [self.mutableObservers containsObject:observer];
    }
}

- (SEL)selectorForState:(NSUInteger)state {
    [self doesNotRecognizeSelector:_cmd];
    
    return NULL;
}

#pragma mark -
#pragma mark Private Methods

- (void)notifyOfStateWithSelector:(SEL)aSelector {
    for (id observer in self.mutableObservers) {
        if ([observer respondsToSelector:aSelector]) {
            [observer performSelectorOnMainThread:aSelector withObject:self waitUntilDone:NO];
        }
    }
}

@end
