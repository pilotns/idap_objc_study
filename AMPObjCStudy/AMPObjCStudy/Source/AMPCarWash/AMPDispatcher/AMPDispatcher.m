//
//  AMPDispatcher.m
//  AMPObjCStudy
//
//  Created by pilotns on 15.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDispatcher.h"

#import "AMPQueue.h"
#import "AMPHuman.h"

#import "NSObject+AMPExtensions.h"

static BOOL isWorking = NO;

@interface AMPDispatcher () <AMPEmployeeObsever>
@property (nonatomic, retain)   AMPQueue    *workers;
@property (nonatomic, retain)   AMPQueue    *queue;

- (void)performWork;

@end

@implementation AMPDispatcher

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.workers = nil;
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.workers = [AMPQueue object];
    self.queue = [AMPQueue object];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addWorkers:(id<NSFastEnumeration>)workers {
    [self.workers pushObjects:workers];
}

- (void)addObjectForProcessing:(id<AMPDispatcherWorkingProcess>)object {
    [self performWorkingProcessWithObject:object];
}

- (void)addObjectsForProcessing:(NSArray *)objects {
    [self.queue pushObjects:objects];
    [self performWork];
}

- (void)performWorkingProcessWithObject:(id)object {
    if (!self.workers.count) {
        [self.queue pushObject:object];
    } else {
        id worker = [self.workers pop];
        [worker performProcessingObject:object];
    }
}

- (void)workerDidBecomeFree:(id)worker {
    AMPQueue *queue = self.queue;
    if (!queue.count) {
        [self.workers pushObject:worker];
    } else {
        [worker performProcessingObject:[queue pop]];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)performWork {
    if (isWorking) {
        return;
    }
    
    AMPQueue *objectsQueue = self.queue;
    isWorking = YES;
    while (objectsQueue.count) {
        [self performWorkingProcessWithObject:[objectsQueue pop]];
    }
    
    isWorking = NO;
}

@end
