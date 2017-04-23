//
//  AMPLinkedListNode.m
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPLinkedListNode.h"

@interface AMPLinkedListNode ()
@property (nonatomic, retain) NSNumber            *content;

@end

@implementation AMPLinkedListNode

#pragma mark -
#pragma mark Class Methods

+ (instancetype)nodeWithContent:(NSNumber *)content {
    return [[[self alloc] initWithContent:content] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.content = nil;
    self.nextNode = nil;
    
    [super dealloc];
}

- (instancetype)initWithContent:(NSNumber *)content {
    self = [super init];
    self.content = content;
    
    return self;
}

@end
