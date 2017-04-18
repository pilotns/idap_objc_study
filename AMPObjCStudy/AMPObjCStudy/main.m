//
//  main.m
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPCreatureTest.h"
#import "AMPMacros.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        AMPCallTest(AMPCreatureWarOrBirthTest, AMPEmptyParameter);
        AMPCallTest(AMPCreatureSayHelloTest, AMPEmptyParameter);
    }
    
    return 0;
}
