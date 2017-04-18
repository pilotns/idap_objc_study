//
//  AMPLinkedListNumberArray.m
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPLinkedListNumberArray.h"

#import "AMPLinkedList.h"
#import "AMPLinkedListNode.h"

#import "NSObject+AMPExtension.h"

@interface AMPLinkedListNumberArray ()
@property (nonatomic, retain) AMPLinkedList *storage;

- (void)parsenumbers:(NSArray *)numbers;

@end

@implementation AMPLinkedListNumberArray

#pragma mark -
#pragma mark - Initializations and Deallocations

- (instancetype)initWithArray:(NSArray *)numbers {
    self = [super init];
    self.storage = [AMPLinkedList object];
    [self parsenumbers:numbers];
    
    return self;
}

#pragma mark -
#pragma mark - Public Methods

- (NSNumber *)numberAtIndex:(NSUInteger)index {
    return [self.storage objectAtIndex:index];
}

- (NSUInteger)count {
    return [self.storage count];
}

#pragma mark -
#pragma mark - Private Methods

- (void)parseNumbers:(NSUInteger *)numbers count:(NSUInteger)count {
    for (NSUInteger iterator = 0; iterator < count; iterator++) {
        NSNumber *number = @(numbers[count - iterator - 1]);
        [self.storage addObject:number];
    }
}

- (void)parsenumbers:(NSArray *)numbers {
    NSUInteger count = [numbers count];
    for (NSUInteger iterator = 0; iterator < count; iterator++) {
        [self.storage addObject:numbers[count - iterator - 1]];
    }
}

#pragma mark -
#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])buffer
                                    count:(NSUInteger)length
{
    state->mutationsPtr = (unsigned long *)self;
    NSUInteger currentLength = MIN(state->state + length - state->extra[2], [self count]);
    currentLength = currentLength - state->state;
    AMPLinkedListNode *head = !state->state ? self.storage.head : (AMPLinkedListNode *)state->extra[0];
    for (NSUInteger iterator = 0; iterator < currentLength; iterator++) {
        buffer[iterator + state->extra[2]] = head.content;
        head = head.nextNode;
    }
    
    state->extra[0] = (unsigned long)head;
    state->itemsPtr = buffer;
    state->state += currentLength;
    
    return currentLength;
}

@end
