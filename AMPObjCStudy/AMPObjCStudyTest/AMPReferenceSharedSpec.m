//
//  AMPReferenceSharedSpec.m
//  AMPObjCStudy
//
//  Created by pilotns on 27.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "Kiwi.h"

#import "AMPReference.h"
#import "AMPRetainReference.h"
#import "AMPAssignReference.h"
#import "AMPCopyReference.h"

SHARED_EXAMPLES_BEGIN(AMPReferenceSharedSpec)

sharedExamplesFor(@"AMPReference class equality", ^(NSDictionary *data) {
    Class aClass = data[@"class"];
    AMPReference *reference = data[@"object"];
    
    AMPReference *anotherReference = [[aClass alloc] initWithTarget:reference.target];
    
    it(@"should equal to anotherReference", ^{
        [[reference should] equal:anotherReference];
    });
    
    it(@"should be a member of AMPRetainReference class", ^{
        [[reference should] beMemberOfClass:aClass];
    });
});

sharedExamplesFor(@"AMPReference target pointer equality", ^(NSDictionary *data) {
    AMPReference *reference = data[@"object"];
    id target = data[@"target"];
    
    it(@"target, on pointers level, should equal to target", ^{
        [[theValue(reference.target) should] equal:theValue(target)];
    });
});

SHARED_EXAMPLES_END
