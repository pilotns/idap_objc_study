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
    __strong __block AMPNumberArray *numbers = nil;
    
    afterAll(^{
        numbers = nil;
    });
    
    context(@"when create with +numberArrayWithFirstNumber in range 0 - 5", ^{
        numbers = [AMPNumberArray numberArrayWithFirstNumber:0 lastNumber:5];
        
        itBehavesLike(@"AMPNumberArray", @{@"object" : numbers, @"class" : [AMPRangeNumberArray class]});
        
    });
        
    context(@"when create with +numberArrayWithNumbers: with numbers 0, 1, 2, 3, 4, 5", ^{
        numbers = [AMPNumberArray numberArrayWithNumbers:@0, @1, @2, @3, @4, @5, nil];
        
        itBehavesLike(@"AMPNumberArray", @{@"object" : numbers, @"class" : [AMPLinkedListNumberArray class]});
    });
    
    context(@"when create with range array which range 0 - 2 and list array which contain 3, 4, 5", ^{
        AMPNumberArray *rangeArray = [AMPNumberArray numberArrayWithFirstNumber:0 lastNumber:2];
        AMPNumberArray *listArray = [AMPNumberArray numberArrayWithNumbers:@3, @4, @5, nil];
            
        numbers = [AMPNumberArray numberArrayWithNumberArrays:@[rangeArray, listArray]];
        
        itBehavesLike(@"AMPNumberArray", @{@"object" : numbers, @"class" : [AMPArrayNumberArray class]});
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
