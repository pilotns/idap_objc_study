//
//  AMPReferenceSpec.m
//  AMPObjCStudy
//
//  Created by pilotns on 27.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "Kiwi.h"

#import "AMPReference.h"
#import "AMPAssignReference.h"
#import "AMPRetainReference.h"
#import "AMPCopyReference.h"

SPEC_BEGIN(AMPReferenceSpec)

describe(@"AMPReference", ^{
    __block AMPReference *reference = nil;
    NSMutableString *target = [NSMutableString stringWithFormat:@"%@", @"target_string"];
    
    beforeAll(^{
        reference = nil;
    });
    
    context(@"when create with +retainReferenceWithTarget:", ^{
        reference = [AMPReference retainReferenceWithTarget:target];
        
        itBehavesLike(@"AMPReference class", @{@"object" : reference, @"class" : [AMPRetainReference class]});
        
        itBehavesLike(@"AMPReference target pointer", @{@"object" : reference, @"target" : target});
    });
    
    context(@"when create with +assignReferenceWithTarget:", ^{
        reference = [AMPReference assignReferenceWithTarget:target];
        
        itBehavesLike(@"AMPReference class", @{@"object" : reference, @"class" : [AMPAssignReference class]});
        
        itBehavesLike(@"AMPReference target pointer", @{@"object" : reference, @"target" : target});
        
    });
    
    context(@"when create with +copyReferenceWithTarget:", ^{
        reference = [AMPReference copyReferenceWithTarget:target];
        
        itBehavesLike(@"AMPReference class", @{@"object" : reference, @"class" : [AMPCopyReference class]});
        
        it(@"target, on pointers level, should not equal to target", ^{
            [[theValue(reference.target) shouldNot] equal:theValue(target)];
        });
    });
});

SPEC_END
