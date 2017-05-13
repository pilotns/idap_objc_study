//
//  NSSet+AMPExtensions.m
//  AMPObjCStudy
//
//  Created by pilotns on 29.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSSet+AMPExtensions.h"

@implementation NSSet (AMPExtensions)

- (NSSet *)objectsWithClass:(Class)class {
    return [self objectsPassingTest:^BOOL(id object, BOOL *stop) {
        return [object isMemberOfClass:class];
    }];
}

@end
