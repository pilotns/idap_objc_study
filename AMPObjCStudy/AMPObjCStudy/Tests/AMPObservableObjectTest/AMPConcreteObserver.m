//
//  AMPConcreteObserver.m
//  AMPObjCStudy
//
//  Created by pilotns on 25.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPConcreteObserver.h"

@implementation AMPConcreteObserver

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observableObject = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setObservableObject:(AMPConcreteObservableObject *)observableObject {
    if (_observableObject != observableObject) {
        [_observableObject removeObserver:self];
        [_observableObject release];
        
        _observableObject = observableObject;
        [_observableObject addObserver:self];
    }
}

#pragma mark -
#pragma mark AMPObserver

- (void)observableObjectWillChangeState:(AMPConcreteObservableObject *)observableObject {

}

- (void)observableObjectDidChangeState:(AMPConcreteObservableObject *)observableObject
                              userInfo:(id)userInfo
{

}

@end
