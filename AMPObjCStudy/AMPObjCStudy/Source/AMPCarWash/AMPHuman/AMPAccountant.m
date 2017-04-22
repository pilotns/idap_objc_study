//
//  AMPAccountant.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPAccountant.h"

#import "AMPCarWash.h"
#import "AMPDirector.h"

@implementation AMPAccountant

#pragma mark -
#pragma mark - AMPCarWashMoneyFlowProtocol

- (void)takeMoney:(NSUInteger)money fromEmployee:(AMPHuman *)employee {
    NSUInteger employeeSalary = money * 0.4;
    money -= employeeSalary;
    NSUInteger selfSalary = money * 0.2;
    money -= selfSalary;
    [employee takeSalary:employeeSalary];
    [self takeSalary:selfSalary];
    
    [self.carWash.director takeMoney:money fromEmployee:self];
}

@end
