//
//  AMPQueue.m
//  AMPObjCStudy
//
//  Created by pilotns on 04.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPQueue.h"

@interface AMPQueue ()
@property (nonatomic, retain) NSMutableArray    *storage;

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
    if (!object) {
        return;
    }
    
    @synchronized (self) {
        [self.storage addObject:object];
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

@end
