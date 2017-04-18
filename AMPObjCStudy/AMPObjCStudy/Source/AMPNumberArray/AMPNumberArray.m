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

@implementation AMPNumberArray

#pragma mark -
#pragma mark - Class Methods

+ (instancetype)numberArrayWithRange:(NSUInteger)firstNumber lastNumber:(NSUInteger)lastNumber {
    return [[[self alloc] initWithRange:firstNumber lastNumber:lastNumber] autorelease];
}

+ (instancetype)numberArrayWithNumbers:(NSUInteger *)numbers count:(NSUInteger)count {
    return [[[self alloc] initWithNumbers:numbers count:count] autorelease];
}

+ (instancetype)numberArrayWithNumberArrays:(NSArray *)numberArrays {
    return [[[self alloc] initWithNumberArrays:numberArrays] autorelease];
}

#pragma mark -
#pragma mark - Initializations and Deallocations

- (instancetype)initWithRange:(NSUInteger)firstNumber lastNumber:(NSUInteger)lastNumber {
    return [[AMPRangeNumberArray alloc] initWithRange:firstNumber lastNumber:lastNumber];
}

- (instancetype)initWithNumbers:(NSUInteger *)numbers count:(NSUInteger)count {
    return [[AMPLinkedListNumberArray alloc] initWithNumbers:numbers count:count];
}

- (instancetype)initWithNumberArrays:(NSArray *)numberArrays {
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
    return [self numberAtIndex:[self count] - 1];
}

- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self numberAtIndex:index];
}

#pragma mark -
#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])buffer
                                    count:(NSUInteger)length
{
    state->mutationsPtr = (unsigned long *)self;
    NSUInteger currentLength = MIN(state->state + length - state->extra[2], [self count]);
    currentLength -= state->state;
    for (NSUInteger iterator = 0; iterator < currentLength; iterator++) {
        buffer[iterator + state->extra[2]] = self[state->state + iterator];
    }
    state->itemsPtr = buffer;
    state->state += currentLength;
    return currentLength;
}

@end
