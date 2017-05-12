//
//  AMPCollectionFiltering.m
//  AMPObjCStudy
//
//  Created by pilotns on 07.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCollectionFiltering.h"

NSArray* AMPObjectsWithClassInCollection(Class class, id<NSFastEnumeration> collection) {
    NSMutableArray *result = [NSMutableArray array];
    for (id object in collection) {
        if ([object isMemberOfClass:class]) {
            [result addObject:object];
        }
    }
    
    return result.count ? [[result copy] autorelease] : nil;
}
