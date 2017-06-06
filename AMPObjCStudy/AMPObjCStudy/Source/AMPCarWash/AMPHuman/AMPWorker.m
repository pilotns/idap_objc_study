//
//  AMPWorker.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPWorker.h"

#import "AMPDirector.h"
#import "AMPQueue.h"
#import "AMPRandom.h"

#import "AMPGCDExtensions.h"
#import "AMPMacros.h"

#import "NSString+AMPRandom.h"
#import "NSObject+AMPExtensions.h"

static const NSRange AMPDefaultSleepRange = { 10, 5 };

@interface AMPWorker ()
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, assign)   NSUInteger  money;

- (void)randomSleep;
- (void)finishProcessingObjectOnMainThread:(id<AMPMoneyFlow>)object;

@end

@implementation AMPWorker

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
    AMPWeakify(self);
    AMPDispatchAsyncInBackground(^{
        AMPStrongify(self);
        [self handleObject:object];
        AMPDispatchAsyncOnMainQueue(^{
            AMPStrongify(self);            
            [self finishProcessingObjectOnMainThread:object];
        });
    });
}

- (void)handleObject:(id<AMPMoneyFlow>)object {
    [self randomSleep];
    [self takeMoneyFormObject:object];
}

- (void)finishProcessingObject:(AMPWorker *)object {
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
