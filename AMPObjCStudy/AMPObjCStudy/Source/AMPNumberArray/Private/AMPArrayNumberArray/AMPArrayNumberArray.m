//
//  AMPArrayNumberArray.m
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayNumberArray.h"

#import "AMPLinkedList.h"
#import "AMPRangeNumberArray.h"
#import "AMPLinkedListNumberArray.h"

#import "NSObject+AMPExtension.h"

@interface AMPArrayNumberArray ()
@property (nonatomic, copy)     NSArray     *storage;
@property (nonatomic, assign)   NSUInteger  count;

- (NSUInteger)calculateCount:(NSArray *)numberArrays;

@end

@implementation AMPArrayNumberArray

@synthesize count = _count;

#pragma mark -
#pragma mark - Initializations and Deallocations

- (void)dealloc {
    self.storage = nil;
    
    [super dealloc];
}

- (instancetype)initWithNumberArrays:(NSArray *)numberArrays {
    self = [super init];
    self.storage = numberArrays;
    self.count = [self calculateCount:numberArrays];
    
    return self;
}

#pragma mark -
#pragma mark - Public Methods

- (NSNumber *)numberAtIndex:(NSUInteger)index {
    NSUInteger previousCount = 0;
    NSUInteger currentCount = 0;
    for (AMPNumberArray *numberArray in self.storage) {
        currentCount = [numberArray count];
        if (index < currentCount + previousCount) {
            return numberArray[index - previousCount];
        }
        
        previousCount += currentCount;
    }
    
    return nil;
}

#pragma mark -
#pragma mark - Private Methods

- (NSUInteger)calculateCount:(NSArray *)numberArrays {
    NSUInteger count = 0;
    for (AMPNumberArray *numberArray in numberArrays) {
        count += [numberArray count];
    }
    
    return count;
}

#pragma mark -
#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])buffer
                                    count:(NSUInteger)length
{
    state->mutationsPtr = (unsigned long *)self;
    
    NSUInteger currentLength = MIN(state->state + length, self.count);
    currentLength -= state->state;
    
    NSUInteger countOfNumberArray = self.storage.count;
    NSUInteger iterator = state->extra[1];
    
    if (iterator == countOfNumberArray) {
        return 0;
    }
    
    while (iterator < countOfNumberArray) {
        AMPNumberArray *numberArray = self.storage[iterator];
        NSUInteger readedLength = [numberArray countByEnumeratingWithState:state
                                                                   objects:buffer
                                                                     count:currentLength];
        if ((readedLength + state->extra[2]) == currentLength) {
            state->extra[2] = readedLength;
            break;
        }
        
        if (readedLength < currentLength) {
            state->state = 0;
        }

        if (iterator == (countOfNumberArray - 1)) {
            currentLength = readedLength;
        }
        
        state->extra[2] += readedLength;
        iterator++;
    }
    
    state->mutationsPtr = (unsigned long *)self;
    state->extra[1] = iterator;
    state->extra[2] = 0;
    
    return currentLength;
}

@end
