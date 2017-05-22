//
//  AMPQueue.m
//  AMPObjCStudy
//
//  Created by pilotns on 04.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPQueue.h"

#import "AMPQueue+AMPQueuePrivate.h"

@interface AMPQueue ()
@property (nonatomic, retain) NSMutableArray    *storage;

- (BOOL)containsObject:(id)object;

@end

@implementation AMPQueue

@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.storage = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.storage = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    @synchronized (self) {
        return self.storage.count;
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)pushObject:(id)object {
    NSMutableArray *storage = self.storage;
    if (!object || [self containsObject:object]) {
        return;
    }
    
    @synchronized (self) {
        [storage addObject:object];
    }
}

- (void)pushObjects:(id<NSFastEnumeration>)objects {
    @synchronized (self) {
        for (id object in objects) {
            [self pushObject:object];
        }
    }
}

- (id)pop {
    @synchronized (self) {
        id object = [[[self.storage firstObject] retain] autorelease];
        if (object) {
            [self.storage removeObjectAtIndex:0];
        }
        
        return object;
    }
}

#pragma mark -
#pragma mark Private Methods

- (BOOL)containsObject:(id)object {
    @synchronized (self) {
        return [self.storage containsObject:object];
    }
}

- (void)removeObject:(id)object {
    @synchronized (self) {
        [self.storage removeObject:object];
    }
}

@end
