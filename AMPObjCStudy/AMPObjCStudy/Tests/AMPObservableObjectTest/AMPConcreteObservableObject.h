//
//  AMPConcreteObservableObject.h
//  AMPObjCStudy
//
//  Created by pilotns on 25.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

typedef NS_ENUM(NSUInteger, AMPNumberState) {
    AMPNumberWillChangeState,
    AMPNumberDidChangeState
};

@class AMPConcreteObservableObject;

@protocol AMPObserver <NSObject>

- (void)observableObjectWillChangeState:(AMPConcreteObservableObject *)observableObject;
- (void)observableObjectDidChangeState:(AMPConcreteObservableObject *)observableObject;

@end

@interface AMPConcreteObservableObject : AMPObservableObject
@property (nonatomic, retain) NSNumber *number;

- (instancetype)initWithNumber:(NSNumber *)number;

@end
