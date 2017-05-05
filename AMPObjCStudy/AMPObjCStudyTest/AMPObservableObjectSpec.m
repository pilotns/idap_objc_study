//
//  AMPObservableObjectSpec.m
//  AMPObjCStudy
//
//  Created by pilotns on 25.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "Kiwi.h"

#import "AMPConcreteObservableObject.h"
#import "AMPConcreteObserver.h"

SPEC_BEGIN(AMPObservableObjectSpec)

describe(@"AMPConcreteObservableObject", ^{
    __block AMPConcreteObservableObject *observableObject = nil;
    __block AMPConcreteObserver *observer = nil;
    
    beforeAll(^{
        observableObject = [[AMPConcreteObservableObject alloc] initWithNumber:@1];
        observer = [AMPConcreteObserver new];
        
        observer.observableObject = observableObject;
    });

    
    context(@"when seting observableObject to observer.observableObject", ^{
        it(@"should be is observer", ^{
            [[theValue([observableObject isObserver:observer]) should] equal:@YES];
        });
    });
    
    context(@"when set number with @2", ^{
        it(@"should receive -observableObjectWillChangeState: and observableObjectDidChangeState:", ^{
            [[observer should] receive:@selector(observableObjectWillChangeState:)];
            [[observer should] receive:@selector(observableObjectDidChangeState:)];
            
            observableObject.number = @2;
        });
        
        it(@"should not receive -observableObjectWillChangeState: and observableObjectDidChangeState:", ^{
            [[observer shouldNot] receive:@selector(observableObjectWillChangeState:)];
            [[observer shouldNot] receive:@selector(observableObjectDidChangeState:)];
            
            observableObject.number = @2;
        });
    });
});

SPEC_END
