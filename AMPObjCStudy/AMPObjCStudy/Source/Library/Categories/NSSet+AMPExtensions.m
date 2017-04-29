//
//  NSSet+AMPExtensions.m
//  AMPObjCStudy
//
//  Created by pilotns on 29.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSSet+AMPExtensions.h"

extern
NSArray *AMPObjectsWithClassInCollection(Class class, id<NSFastEnumeration> collection);

@implementation NSSet (AMPExtensions)

- (NSSet *)objectsWithClass:(Class)class {
    return [NSSet setWithArray:AMPObjectsWithClassInCollection(class, self)];
}

@end
