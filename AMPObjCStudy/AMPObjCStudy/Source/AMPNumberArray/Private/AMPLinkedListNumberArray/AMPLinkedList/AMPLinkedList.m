//
//  AMPLinkedList.m
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPLinkedList.h"

#import "AMPLinkedListNode.h"

@interface AMPLinkedList ()
@property (nonatomic, assign) NSUInteger    count;

@end

@implementation AMPLinkedList

#pragma mark -
#pragma mark Initialization and Deallocations

- (void)dealloc {
    self.head = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public Methods

- (void)addObject:(NSNumber *)object {
    AMPLinkedListNode *newHead = [AMPLinkedListNode nodeWithContent:object];
    AMPLinkedListNode *previousHead = self.head;
    [newHead setNextNode:previousHead];
    self.head = newHead;
    self.count += 1;
}

- (NSNumber *)objectAtIndex:(NSUInteger)index {
    NSAssert(index < self.count, NSRangeException);
    NSUInteger count = self.count;
    AMPLinkedListNode *head = self.head;
    for (NSUInteger iterator = 0; iterator < count; iterator++) {
        if (iterator == index) {
            return head.content;
        }
        head = head.nextNode;
    }
    
    return nil;
}

@end
