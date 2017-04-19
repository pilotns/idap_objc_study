//
//  AMPNumberArraySpec.m
//  AMPObjCStudy
//
//  Created by pilotns on 18.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "Kiwi.h"
#import "AMPNumberArray.h"

SPEC_BEGIN(AMPNumberArraySpec)

describe(@"AMPRangeNumberArray", ^{
    describe(@"when created in range 0 - 1", ^{
        __block AMPNumberArray *rangeNumberArray = nil;
        
        beforeAll(^{
            rangeNumberArray = [AMPNumberArray numberArrayWithFirstNumber:0 lastNumber:1];
        });
        
        afterAll(^{
            rangeNumberArray = nil;
        });
        
        it(@"should have count of 2", ^{
            [[rangeNumberArray should] haveCountOf:2];
        });
        
        it(@"should return value equal 0, when ask object at index 0", ^{
            [[rangeNumberArray[0] should] equal:@(0)];
        });
        
        it(@"should return value equal 1, when ask object at index 1", ^{
            [[rangeNumberArray[1] should] equal:@(1)];
        });
        
        describe(@"when iterate in for in loop", ^{
            theBlock(^{
                __block NSUInteger iterator = 0;
                for (NSNumber *number in rangeNumberArray) {
                    it(@"should equal to rangeNumberArray[iterator]", ^{
                        [[number should] equal:rangeNumberArray[iterator]];
                        iterator++;
                    });
                    
                    it(@"should have count equal to iterator", ^{
                        [[rangeNumberArray should] haveCountOf:iterator];
                    });
                }
            });
        });
    });
});

describe(@"AMPLinkedListNumberArray", ^{
    describe(@"when created with numbers 0, 5", ^{
        __block AMPNumberArray *listNumberArray = nil;
        
        beforeAll(^{
            listNumberArray = [AMPNumberArray numberArrayWithNumbers:@(0), @(5), nil];
        });
        
        afterAll(^{
            listNumberArray = nil;
        });
        
        it(@"should have count of 2", ^{
            [[listNumberArray should] haveCountOf:2];
        });
        
        it(@"should return value equal 0, when ask object at index 0", ^{
            [[listNumberArray[0] should] equal:@(0)];
        });
        
        it(@"should return value equal 1, when ask object at index 1", ^{
            [[listNumberArray[1] should] equal:@(5)];
        });
        
        describe(@"when iterate in for in loop", ^{
            theBlock(^{
                __block NSUInteger iterator = 0;
                for (NSNumber *number in listNumberArray) {
                    it(@"should equal to rangeNumberArray[iterator]", ^{
                        [[number should] equal:listNumberArray[iterator]];
                        iterator++;
                    });
                    
                    it(@"should have count equal to iterator", ^{
                        [[listNumberArray should] haveCountOf:iterator];
                    });
                }
            });
        });
    });
});


describe(@"AMPRangeNumberArray", ^{
    describe(@"when created with range array which range 0 - 1 and list array which contain 0 and 5", ^{
        __block AMPNumberArray *arrayOfNumberArrays = nil;
        
        beforeAll(^{
            AMPNumberArray *rangeArray = [AMPNumberArray numberArrayWithFirstNumber:0 lastNumber:1];
            AMPNumberArray *listArray = [AMPNumberArray numberArrayWithNumbers:@(0), @(5), nil];
            
            arrayOfNumberArrays = [AMPNumberArray numberArrayWithNumberArrays:@[rangeArray, listArray]];
        });
        
        afterAll(^{
            arrayOfNumberArrays = nil;
        });
        
        it(@"should have count of 4", ^{
            [[arrayOfNumberArrays should] haveCountOf:4];
        });
        
        it(@"should return value equal 0, when ask object at index 0", ^{
            [[arrayOfNumberArrays[0] should] equal:@(0)];
        });
        
        it(@"should return value equal 1, when ask object at index 1", ^{
            [[arrayOfNumberArrays[1] should] equal:@(1)];
        });
        
        it(@"should return value equal 0, when ask object at index 2", ^{
            [[arrayOfNumberArrays[2] should] equal:@(0)];
        });
        
        it(@"should return value equal 1, when ask object at index 3", ^{
            [[arrayOfNumberArrays[3] should] equal:@(5)];
        });
        
        describe(@"when iterate in for in loop", ^{
            theBlock(^{
                __block NSUInteger iterator = 0;
                for (NSNumber *number in arrayOfNumberArrays) {
                    it(@"should equal to rangeNumberArray[iterator]", ^{
                        [[number should] equal:arrayOfNumberArrays[iterator]];
                        iterator++;
                    });
                    
                    it(@"should have count equal to iterator", ^{
                        [[arrayOfNumberArrays should] haveCountOf:iterator];
                    });
                }
            });
        });
    });
});

SPEC_END
