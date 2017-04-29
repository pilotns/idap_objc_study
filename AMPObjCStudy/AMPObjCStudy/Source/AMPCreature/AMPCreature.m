//
//  AMPCreature.m
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCreature.h"

#import "AMPRandom.h"

#import "NSString+AMPRandom.h"

@interface AMPCreature ()
@property (nonatomic, retain) NSMutableArray *mutableChildren;

@end

@implementation AMPCreature

@dynamic children;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableChildren = nil;
    self.name = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.name = [NSString randomStringWithLength:6];
    self.age = AMPRandomValueWithRange(NSMakeRange(30, 30));
    self.weight = AMPRandomValueWithRange(NSMakeRange(600, 300)) / 9.0;
    self.mutableChildren = [NSMutableArray array];

    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)children {
    return [[self.mutableChildren copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)addChild:(AMPCreature *)child {
    [self.mutableChildren addObject:child];
}

- (void)removeChild:(AMPCreature *)child {
    [self.mutableChildren removeObject:child];
}

- (void)addChildren:(NSArray *)children {
    [self.mutableChildren addObjectsFromArray:children];
}

- (void)removeChildren:(NSArray *)children {
    [self.mutableChildren removeObjectsInArray:children];
}

- (NSUInteger)childrenCount {
    return self.mutableChildren.count;
}

- (void)perfomGenderSpecificOperation {
    
}

- (void)sayHello {
    NSLog(@"%@ says Hello", self.name);
    if ([self childrenCount] > 0) {
        NSLog(@"---Childs of %@---", self.name);
        for (AMPCreature *child in self.mutableChildren) {
            [child sayHello];
        }
        
        NSLog(@"---end childs.----");
        NSLog(@"");
    }
}

@end
