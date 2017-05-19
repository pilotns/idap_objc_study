//
//  AMPHuman.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPHuman.h"

#import "AMPDirector.h"
#import "AMPQueue.h"
#import "AMPRandom.h"

#import "NSString+AMPRandom.h"
#import "NSObject+AMPExtensions.h"

static const NSRange AMPDefaultSleepRange = { 300, 200 };

@interface AMPHuman ()
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, assign)   NSUInteger  money;

- (void)randomSleep;
- (void)backgroundProcessingObject:(id<AMPMoneyFlow>)object;
- (void)finishProcessingObjectOnMainThread:(id<AMPMoneyFlow>)object;

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
    self.state = AMPEmployeeDidBecomeBusy;
    [self performSelectorInBackground:@selector(backgroundProcessingObject:) withObject:object];
}

- (void)handleObject:(id<AMPMoneyFlow>)object {
    [self randomSleep];
    [self takeMoneyFormObject:object];
}

- (void)finishProcessingObject:(AMPHuman *)object {
    object.state = AMPEmployeeDidBecomeFree;
}

- (void)finishProcessing {
    self.state = AMPEmployeeDidFinishWork;
}

#pragma mark -
#pragma mark Private Methods

- (void)randomSleep {
    usleep(1000 * (useconds_t)(AMPRandomValueWithRange(AMPDefaultSleepRange)));
}

- (void)backgroundProcessingObject:(id<AMPMoneyFlow>)object {
    [self handleObject:object];
    
    [self performSelectorOnMainThread:@selector(finishProcessingObjectOnMainThread:)
                           withObject:object
                        waitUntilDone:NO];
}

- (void)finishProcessingObjectOnMainThread:(id<AMPMoneyFlow>)object {
    [self finishProcessingObject:object];
    [self finishProcessing];
}

#pragma mark -
#pragma mark AMPMoneyFlow

- (NSUInteger)giveMoney {
    @synchronized (self) {
        NSUInteger money = self.money;
        self.money = 0;
        
        return money;
    }
}

- (void)receiveMoney:(NSUInteger)money {
    @synchronized (self) {
        self.money += money;
    }
}

- (void)takeMoneyFormObject:(id<AMPMoneyFlow>)object {
    [self receiveMoney:[object giveMoney]];
}

#pragma mark -
#pragma mark AMPDispatcherWorkingProcess

- (void)performProcessingObject:(id)object {
    [self performWorkWithObject:object];
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
