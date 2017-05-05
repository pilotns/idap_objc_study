//
//  AMPConcreteObservableObject.m
//  AMPObjCStudy
//
//  Created by pilotns on 25.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPConcreteObservableObject.h"

@implementation AMPConcreteObservableObject

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.number = nil;
    
    [super dealloc];
}

- (instancetype)initWithNumber:(NSNumber *)number {
    self = [super init];
    self.number = number;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setNumber:(NSNumber *)number {
    if (_number != number) {
        self.state = AMPNumberWillChangeState;
        
        [_number release];
        _number = [number retain];
        
        self.state = AMPNumberDidChangeState;
    }
}

#pragma mark -
#pragma mark Override Methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case AMPNumberWillChangeState:
            return @selector(observableObjectWillChangeState:);
            
        case AMPNumberDidChangeState:
            return @selector(observableObjectDidChangeState:);
            
        default:
            
            return [super selectorForState:state];
    }
}

@end
