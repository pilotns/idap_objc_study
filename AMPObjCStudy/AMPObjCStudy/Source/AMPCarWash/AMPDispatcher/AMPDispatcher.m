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

@interface AMPDispatcher () <AMPEmployeeObsever>
@property (nonatomic, retain)   AMPQueue    *workers;
@property (nonatomic, retain)   AMPQueue    *queue;

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

- (void)addWorkers:(NSArray<id<AMPDispatcherWorkingProcess>> *)workers {
    [self.workers pushObjects:workers];
}

- (void)addObjectForProcessing:(id)object {
    if (!self.workers.count) {
        [self.queue pushObject:object];
    } else {
        id worker = [self.workers pop];
        [worker performProcessingObject:object];
    }
    
}

#pragma mark -
#pragma mark AMPEmployeeObserver

- (void)employeeDidFinishWork:(id<AMPDispatcherWorkingProcess>)employee {
    if (!self.queue.count) {
        [self.workers pushObject:employee];
    } else {
        id object = [self.queue pop];
        [employee performProcessingObject:object];
    }
}

@end
