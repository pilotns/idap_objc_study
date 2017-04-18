//
//  AMPLinkedList.h
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPLinkedListNode;

@interface AMPLinkedList : NSObject
@property (nonatomic, retain)   AMPLinkedListNode *head;
@property (nonatomic, readonly) NSUInteger        count;

- (void)addObject:(NSNumber *)object;
- (NSNumber *)objectAtIndex:(NSUInteger)index;

@end
