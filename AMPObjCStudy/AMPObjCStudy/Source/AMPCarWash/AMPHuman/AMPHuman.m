//
//  AMPHuman.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPHuman.h"

#import "AMPDirector.h"

#import "NSString+AMPRandom.h"

extern
NSUInteger AMPRandomValueWithRange(NSRange range);

@interface AMPHuman ()
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, assign)   NSUInteger  money;

- (void)randomSleep;
- (void)backgroundProcessWithObject:(id<AMPMoneyFlow>)object;

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
    self.name = [[NSString randomString] capitalizedString];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)performWorkWithObject:(id<AMPMoneyFlow>)object {
    [self performSelectorInBackground:@selector(backgroundProcessWithObject:) withObject:object];
}

- (void)handlingObject:(id)object {
    [self receiveMoney:[object giveMoney]];
}

#pragma mark -
#pragma mark Private Methods

- (void)backgroundProcessWithObject:(id<AMPMoneyFlow>)object {
    @synchronized (self) {
        self.state = AMPEmployeeDidBecomeBusy;
        [self handlingObject:object];
        self.state = AMPEmployeeDidFinishWork;
    }

}

- (void)randomSleep {
    usleep(1000 * (useconds_t)(AMPRandomValueWithRange(NSMakeRange(200, 300))));
}

#pragma mark -
#pragma mark AMPMoneyFlow

- (NSUInteger)giveMoney {
    if ([self isMemberOfClass:[AMPDirector class]]) {
        return 0;
    }
    
    NSUInteger money = self.money;
    self.money = 0;
    
    return money;
}

- (void)receiveMoney:(NSUInteger)money {
    [self randomSleep];
    self.money += money;
}

#pragma mark -
#pragma mark AMPEmployeeObserver

- (void)employeeDidFinishWork:(id<AMPMoneyFlow>)employee {
    [self performWorkWithObject:employee];
}

#pragma mark -
#pragma mark Override Methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case AMPEmployeeDidBecomeFree:
            return @selector(employeeDidBecomeFree:);
            
        case AMPEmployeeDidBecomeBusy:
            return @selector(employeeDidBecomeBusy:);
            
        case AMPEmployeeDidFinishWork:
            return @selector(employeeDidFinishWork:);
            
        default:
            return [super selectorForState:state];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@", [super description], self.name];
}

@end
