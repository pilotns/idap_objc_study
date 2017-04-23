//
//  AMPNumberArraySpec.m
//  AMPObjCStudy
//
//  Created by pilotns on 18.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "Kiwi.h"

#import "AMPNumberArray.h"
#import "AMPRangeNumberArray.h"
#import "AMPLinkedListNumberArray.h"
#import "AMPArrayNumberArray.h"

SPEC_BEGIN(AMPNumberArraySpec)

describe(@"AMPNumberArray", ^{
    __block AMPNumberArray *numbers = nil;
    
    afterAll(^{
        numbers = nil;
    });
    
    context(@"when create with +numberArrayWithFirstNumber in range 0 - 1", ^{
        beforeAll(^{
            numbers = [AMPNumberArray numberArrayWithFirstNumber:0 lastNumber:1];
        });
        
        it(@"should be a member of AMPRangeNumberArray", ^{
            [[numbers should] beMemberOfClass:[AMPRangeNumberArray class]];
        });
        
        it(@"should have count of 2", ^{
            [[numbers should] haveCountOf:2];
        });
        
        it(@"should return value equal 0, when ask object at index 0", ^{
            [[numbers[0] should] equal:@0];
        });
        
        it(@"should return value equal 1, when ask object at index 1", ^{
            [[numbers[1] should] equal:@1];
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
    
    describe(@"when create with +numberArrayWithNumbers: with numbers 0, 5", ^{
        beforeAll(^{
            numbers = [AMPNumberArray numberArrayWithNumbers:@0, @5, nil];
        });
        
        it(@"should be a member of AMPLinkedListNumberArray", ^{
            [[numbers should] beMemberOfClass:[AMPLinkedListNumberArray class]];
        });
        
        it(@"should have count of 2", ^{
            [[numbers should] haveCountOf:2];
        });
        
        it(@"should return value equal 0, when ask object at index 0", ^{
            [[numbers[0] should] equal:@(0)];
        });
        
        it(@"should return value equal 1, when ask object at index 1", ^{
            [[numbers[1] should] equal:@(5)];
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
    
    context(@"when create with range array which range 0 - 1 and list array which contain 0 and 5", ^{
        beforeAll(^{
            AMPNumberArray *rangeArray = [AMPNumberArray numberArrayWithFirstNumber:0 lastNumber:1];
            AMPNumberArray *listArray = [AMPNumberArray numberArrayWithNumbers:@0, @5, nil];
            
            numbers = [AMPNumberArray numberArrayWithNumberArrays:@[rangeArray, listArray]];
        });
        
        it(@"should be a member of AMPArrayNumberArray", ^{
            [[numbers should] beMemberOfClass:[AMPArrayNumberArray class]];
        });
        
        it(@"should have count of 4", ^{
            [[numbers should] haveCountOf:4];
        });
        
        it(@"should return value equal 0, when ask object at index 0", ^{
            [[numbers[0] should] equal:@0];
        });
        
        it(@"should return value equal 1, when ask object at index 1", ^{
            [[numbers[1] should] equal:@1];
        });
        
        it(@"should return value equal 0, when ask object at index 2", ^{
            [[numbers[2] should] equal:@0];
        });
        
        it(@"should return value equal 1, when ask object at index 3", ^{
            [[numbers[3] should] equal:@5];
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
    
    context(@"when create with mix of many AMPNumberArray", ^{
        beforeAll(^{
            AMPNumberArray *rangeArray = [AMPNumberArray numberArrayWithFirstNumber:0 lastNumber:1000];
            AMPNumberArray *listArray = [AMPNumberArray numberArrayWithNumbers:@0, @5, @8, @9, @4, @3.5,
                                                                               @0, @5, @8, @9, @4, @3.5,
                                                                               @0, @5, @8, @9, @4, @3.5,
                                                                               @0, @5, @8, @9, @4, @3.5, nil];
            
            static const NSUInteger capacity = 10;
            NSMutableArray *numberArrays = [NSMutableArray arrayWithCapacity:capacity];
            
            for (NSUInteger iterator = 0; iterator < capacity; iterator++) {
                [numberArrays addObject:rangeArray];
                [numberArrays addObject:listArray];
            }
            
            numbers = [AMPNumberArray numberArrayWithNumberArrays:numberArrays];
        });
        
        it(@"should return number equal 3.5 when ask -lastNumber", ^{
            [[[numbers lastNumber] should] equal:@3.5];
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

    
});

SPEC_END
