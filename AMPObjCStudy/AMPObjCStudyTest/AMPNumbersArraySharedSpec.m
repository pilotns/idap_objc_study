//
//  AMPNumbersArraySharedSpec.m
//  AMPObjCStudy
//
//  Created by pilotns on 26.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "Kiwi.h"

#import "AMPNumberArray.h"

SHARED_EXAMPLES_BEGIN(AMPNumberArraySharedSpec)

sharedExamplesFor(@"AMPNumberArray", ^(NSDictionary *data) {
    
    AMPNumberArray *numbers = data[@"object"];
    Class aClass = data[@"class"];
    
    it(@"should be a member of AMPRangeNumberArray", ^{
        [[numbers should] beMemberOfClass:aClass];
    });
    
    it(@"should have count of 2", ^{
        [[numbers should] haveCountOf:6];
    });
    
    it(@"should return value equal 0, when ask object at index 0", ^{
        [[numbers[0] should] equal:@0];
    });
    
    it(@"should return value equal 1, when ask object at index 1", ^{
        [[numbers[1] should] equal:@1];
    });
    
    it(@"should return value equal 1, when ask object at index 1", ^{
        [[numbers[2] should] equal:@2];
    });
    
    it(@"should return value equal 1, when ask object at index 1", ^{
        [[numbers[3] should] equal:@3];
    });
    
    it(@"should return value equal 1, when ask object at index 1", ^{
        [[numbers[4] should] equal:@4];
    });
    
    it(@"should return value equal 1, when ask object at index 1", ^{
        [[numbers[5] should] equal:@5];
    });
    
    context(@"should not raise when iterate in for in loop", ^{
        [[theBlock(^{
            __block NSUInteger iterator = 0;
            for (NSNumber *number in numbers) {
                it(@"should equal to rangeNumberArray[iterator]", ^{
                    [[number should] equal:numbers[iterator]];
                    iterator++;
                });
                
                it(@"should have count equal to iterator", ^{
                    [[numbers should] haveCountOf:iterator];
                });
            }
        }) shouldNot] raise];
    });
    
});

SHARED_EXAMPLES_END
