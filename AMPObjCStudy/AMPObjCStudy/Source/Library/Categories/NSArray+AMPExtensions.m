//
//  NSArray+AMPExtensions.m
//  AMPObjCStudy
//
//  Created by pilotns on 15.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSArray+AMPExtensions.h"

#import "AMPCollectionFiltering.h"

@implementation NSArray (AMPExtensions)

+ (instancetype)arrayWithObjectsCount:(NSUInteger)count factoryBlock:(AMPFactoryBlock)block {
    if (!block) {
        return nil;
    }
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger iterator = 0; iterator < count; iterator++) {
        id object = block();
        [resultArray addObject:object];
    }
    
    return [self arrayWithArray:resultArray];
}

- (instancetype)objectsWithClass:(Class)class {
    return AMPObjectsWithClassInCollection(class, self);
}

@end
