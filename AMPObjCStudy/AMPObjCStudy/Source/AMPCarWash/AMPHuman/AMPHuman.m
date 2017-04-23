//
//  AMPHuman.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPHuman.h"

#import "NSString+AMPRandom.h"

@interface AMPHuman ()
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, assign)   NSUInteger  money;

@end

@implementation AMPHuman

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.name = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.name = [NSString randomString];
    
    return self;
}

#pragma mark -
#pragma mark AMPMoneyFlow

- (void)giveMoneyToEmployee:(id<AMPMoneyFlow>)employee {
    [employee takeMoneyFromSender:self];
    self.money = 0;
}

- (void)takeMoneyFromSender:(id<AMPMoneyFlow>)sender {
    self.money += sender.money;
}

@end
