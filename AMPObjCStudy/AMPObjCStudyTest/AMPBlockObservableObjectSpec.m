//
//  AMPBlockObservableObjectSpec.m
//  AMPObjCStudy
//
//  Created by pilotns on 28.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "Kiwi.h"

#import "AMPNumber.h"
#import "AMPNumberObserver.h"

SPEC_BEGIN(AMPBlockObservableObjectSpec)

describe(@"AMPBlockObservableObject", ^{
    __block AMPNumber *number = nil;
    __block AMPNumberObserver *numberObserver = nil;
    __block NSUInteger state = NSUIntegerMax;
    
    beforeAll(^{
        number = [AMPNumber new];
        numberObserver = [AMPNumberObserver new];
        
        numberObserver.number = number;
    });
    
    beforeEach(^{
        number.state = NSUIntegerMax;
        state = NSUIntegerMax;
    });
    
    context(@"when set number nil -> @1 ", ^{
        it(@"should receive -numberWillChangeWithUserInfo:", ^{
            number.number = nil;
            [[numberObserver should] receive:@selector(numberWillChangeWithUserInfo:)];
            number.number = @1;
        });
        
        it(@"should receive -numberDidChangeWithUserInfo:", ^{
            number.number = nil;
            [[numberObserver should] receive:@selector(numberDidChangeWithUserInfo:)];
            number.number = @1;
        });
    });
    
    context(@"when set number @1 -> @1 ", ^{
        it(@"should not receive -numberWillChangeWithUserInfo:", ^{
            number.number = @1;
            [[numberObserver shouldNot] receive:@selector(numberWillChangeWithUserInfo:)];
            number.number = @1;
        });
        
        it(@"should not receive -numberDidChangeWithUserInfo:", ^{
            number.number = @1;
            [[numberObserver shouldNot] receive:@selector(numberDidChangeWithUserInfo:)];
            number.number = @1;
        });
    });
    
    context(@"when set number @1 -> nil ", ^{
        it(@"should receive -numberWillChangeWithUserInfo:", ^{
            number.number = @1;
            [[numberObserver should] receive:@selector(numberWillChangeWithUserInfo:)];
            number.number = nil;
        });
        
        it(@"should receive -numberDidChangeWithUserInfo:", ^{
            number.number = @1;
            [[numberObserver should] receive:@selector(numberDidChangeWithUserInfo:)];
            number.number = nil;
        });
    });
});

SPEC_END
