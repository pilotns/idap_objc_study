//
//  NSArray+AMPExtensions.m
//  AMPObjCStudy
//
//  Created by pilotns on 15.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSArray+AMPExtensions.h"

NSArray* AMPObjectsWithClassInCollection(Class class, id<NSFastEnumeration> collection) {
    NSMutableArray *result = [NSMutableArray array];
    for (id object in collection) {
        if ([object isMemberOfClass:class]) {
            [result addObject:object];
        }
    }
    
    return result.count ? [[result copy] autorelease] : nil;
}

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
