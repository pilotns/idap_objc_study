//
//  AMPNumberArray.m
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPNumberArray.h"

#import "AMPRangeNumberArray.h"
#import "AMPLinkedListNumberArray.h"
#import "AMPArrayNumberArray.h"

@interface AMPNumberArray ()

+ (NSMutableArray *)arrayOfNumbersWithVaList:(va_list)list;

@end

@implementation AMPNumberArray

@dynamic count;

#pragma mark -
#pragma mark - Class Methods

+ (instancetype)numberArrayWithFirstNumber:(NSUInteger)firstNumber lastNumber:(NSUInteger)lastNumber {
    return [[[self alloc] initWithFirstNumber:firstNumber lastNumber:lastNumber] autorelease];
}

+ (instancetype)numberArrayWithNumbers:(NSNumber *)firstNumber, ... {
    va_list numbers;
    va_start(numbers, firstNumber);
    NSMutableArray *numbersArray = [self arrayOfNumbersWithVaList:numbers];
    [numbersArray insertObject:firstNumber atIndex:0];
    va_end(numbers);
    
    return [[[AMPLinkedListNumberArray alloc] initWithArray:numbersArray] autorelease];
}

+ (instancetype)numberArrayWithNumberArrays:(NSArray *)numberArrays {
    return [[[self alloc] initWithNumberArrays:numberArrays] autorelease];
}

#pragma mark -
#pragma mark - Initializations and Deallocations

- (instancetype)initWithFirstNumber:(NSUInteger)firstNumber lastNumber:(NSUInteger)lastNumber {
    [self release];
    
    return [[AMPRangeNumberArray alloc] initWithFirstNumber:firstNumber lastNumber:lastNumber];
}

- (instancetype)initWithNumbers:(NSNumber *)firstNumber, ... {
    [self release];
    
    va_list numbers;
    va_start(numbers, firstNumber);
    NSMutableArray *numbersArray = [[self class] arrayOfNumbersWithVaList:numbers];
    [numbersArray insertObject:firstNumber atIndex:0];
    va_end(numbers);
    
    return [[AMPLinkedListNumberArray alloc] initWithArray:numbersArray];
}

- (instancetype)initWithNumberArrays:(NSArray *)numberArrays {
    [self release];
    
    return [[AMPArrayNumberArray alloc] initWithNumberArrays:numberArrays];
}

#pragma mark -
#pragma mark - Public Methods

- (NSNumber *)numberAtIndex:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSNumber *)firstNumber {
    return [self numberAtIndex:0];
}

- (NSNumber *)lastNumber {
    return [self numberAtIndex:self.count - 1];
}

- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self numberAtIndex:index];
}

#pragma mark -
#pragma mark - Private Methods

+ (NSMutableArray *)arrayOfNumbersWithVaList:(va_list)list {
    NSMutableArray *numbers = [NSMutableArray array];
    NSNumber *number = nil;
    while (nil != (number = va_arg(list, NSNumber *))) {
        [numbers addObject:number];
    }
    
    return numbers;
}

#pragma mark -
#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])buffer
                                    count:(NSUInteger)length
{
    state->mutationsPtr = (unsigned long *)self;
    NSUInteger currentLength = MIN(state->state + length - state->extra[2], self.count);
    currentLength -= state->state;
    for (NSUInteger iterator = 0; iterator < currentLength; iterator++) {
        buffer[iterator + state->extra[2]] = self[state->state + iterator];
    }
    state->itemsPtr = buffer;
    state->state += currentLength;
    return currentLength;
}

@end
