//
//  AMPReference.m
//  AMPObjCStudy
//
//  Created by pilotns on 27.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPReference.h"

#import "AMPCopyReference.h"
#import "AMPRetainReference.h"
#import "AMPAssignReference.h"

@interface AMPReference ()
@property (nonatomic, assign) id target;

@end

@implementation AMPReference

@dynamic target;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)retainReferenceWithTarget:(id)target {
    return [[[AMPRetainReference alloc] initWithTarget:target] autorelease];
}

+ (instancetype)assignReferenceWithTarget:(id)target {
    return [[[AMPAssignReference alloc] initWithTarget:target] autorelease];
}
    
+ (instancetype)copyReferenceWithTarget:(id<NSCopying>)target {
    return [[[AMPCopyReference alloc] initWithTarget:target] autorelease];
}

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.target = nil;
    
    [super dealloc];
}

- (instancetype)initWithTarget:(id)target {
    self = [self init];
    self.target = target;
    
    return self;
}

- (instancetype)init {
    NSAssert([self class] != [AMPReference class], NSInternalInconsistencyException);
    
    return [super init];
}

#pragma mark -
#pragma mark Equality

- (NSUInteger)hash {
    return [[self class] hash] ^ [self.target hash];
}

- (BOOL)isEqual:(AMPReference *)reference {
    if (!reference) {
        return NO;
    }
    
    if (reference == self) {
        return YES;
    }
    
    if ([reference isMemberOfClass:[self class]]) {
        return [self isEqualToReference:reference];
    }
    
    return NO;
}

- (BOOL)isEqualToReference:(AMPReference *)reference {
    return self.target == reference.target;
}



@end
