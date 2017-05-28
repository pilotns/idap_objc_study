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
#import "AMPMacros.h"

#import "NSString+AMPRandom.h"
#import "NSObject+AMPExtensions.h"

static const NSRange AMPDefaultSleepRange = { 50, 10 };

@interface AMPHuman ()
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, assign)   NSUInteger  money;
@property (nonatomic, retain)   AMPQueue    *queue;

- (void)randomSleep;
- (void)processObject:(id<AMPMoneyFlow>)object;
- (void)backgroundProcessingObject:(id<AMPMoneyFlow>)object;
- (void)finishProcessingObjectOnMainThread:(id<AMPMoneyFlow>)object;

- (void)willChangeStateWithBlock:(void (^)(void))block;

@end

@implementation AMPHuman

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.name = nil;
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.name = [[NSString randomString] capitalizedString];
    self.queue = [AMPQueue object];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)performWorkWithObject:(id<AMPMoneyFlow>)object {
    @synchronized (self) {
        if (AMPEmployeeDidBecomeFree == self.state) {
            self.state = AMPEmployeeDidBecomeBusy;
            [self processObject:object];
        } else {
            [self.queue pushObject:object];
        }
    }
}

- (void)handleObject:(id<AMPMoneyFlow>)object {
    [self randomSleep];
    [self takeMoneyFormObject:object];
}

- (void)finishProcessingObject:(AMPHuman *)object {
    [object willChangeStateWithBlock:^{
        object.state = AMPEmployeeDidBecomeFree;
    }];
}

- (void)finishProcessing {
    AMPWeakify(self);
    [self willChangeStateWithBlock:^{
        AMPStrongify(self);
        self.state = AMPEmployeeDidFinishWork;
    }];
}

#pragma mark -
#pragma mark Private Methods

- (void)randomSleep {
    usleep(1000 * (useconds_t)(AMPRandomValueWithRange(AMPDefaultSleepRange)));
}

- (void)processObject:(id<AMPMoneyFlow>)object {
    [self performSelectorInBackground:@selector(backgroundProcessingObject:) withObject:object];
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

- (void)willChangeStateWithBlock:(void (^)(void))block {
    if (!block) {
        return;
    }
    
    @synchronized (self) {
        AMPQueue *queue = self.queue;
        if (queue.count) {
            [self processObject:[queue pop]];
        } else {
            block();
        }
    }
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
