//
//  AMPDispatcher.m
//  AMPObjCStudy
//
//  Created by pilotns on 15.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDispatcher.h"

#import "AMPQueue+AMPQueuePrivate.h"
#import "AMPWorker.h"

#import "NSObject+AMPExtensions.h"

@interface AMPDispatcher () <AMPEmployeeObsever>
@property (nonatomic, retain)   AMPQueue        *processingObjects;
@property (nonatomic, retain)   AMPQueue        *processedObjects;
@property (nonatomic, retain)   NSMutableSet    *mutableProcessingObjects;

@property (nonatomic, assign, getter=isWorking) BOOL working;

- (void)performWork;

@end

@implementation AMPDispatcher

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.processingObjects = nil;
    self.processedObjects = nil;
    self.mutableProcessingObjects = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.processingObjects = [AMPQueue object];
    self.processedObjects = [AMPQueue object];
    self.mutableProcessingObjects = [NSMutableSet set];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addWorker:(AMPWorker *)worker {
    @synchronized (self) {
        NSMutableSet *workers = self.mutableProcessingObjects;
        if ([workers containsObject:worker]) {
            return;
        }
        
        [workers addObject:worker];
        [self.processingObjects pushObject:worker];
    }
}

- (void)addWorkers:(id<NSFastEnumeration>)workers {
    for (id worker in workers) {
        [self addWorker:worker];
    }
}

- (void)removeWorker:(AMPWorker *)worker {
    @synchronized (self) {
        [self.mutableProcessingObjects removeObject:worker];
        [self.processingObjects removeObject:worker];
    }
}

- (void)removeAllWorkers {
    NSMutableSet *workers = self.mutableProcessingObjects;
    for (id worker in workers) {
        [self removeWorker:worker];
    }
}

- (void)processingObject:(id)object {
    [self performWorkingProcessWithObject:object];
}

- (void)processingObjects:(NSArray *)objects {
    [self.processedObjects pushObjects:objects];
    [self performWork];
}

- (void)performWorkingProcessWithObject:(id)object {
    id worker = [self.processingObjects pop];
    [worker performProcessingObject:object];
}

#pragma mark -
#pragma mark Private Methods

- (void)performWork {
    AMPQueue *objectsQueue = self.processedObjects;
    AMPQueue *workers = self.processingObjects;
    
    while (objectsQueue.count && workers.count) {
        [self performWorkingProcessWithObject:[objectsQueue pop]];
    }
}

#pragma mark -
#pragma mark AMPEmployeeObserver

- (void)employeeDidFinishWork:(id<AMPDispatcherWorkingProcess>)employee {
    @synchronized (self) {
        if ([self.mutableProcessingObjects containsObject:employee]) {
            return;
        }
        
        if (self.processingObjects.count) {
            [self performWorkingProcessWithObject:employee];
        } else {
            [self.processedObjects pushObject:employee];
        }
    }
}

- (void)employeeDidBecomeFree:(id)employee {
    @synchronized (self) {
        if (![self.mutableProcessingObjects containsObject:employee]) {
            return;
        }
        
        AMPQueue *processedObjects = self.processedObjects;
        if (processedObjects.count) {
            [employee performProcessingObject:[processedObjects pop]];
        } else {
            [self.processingObjects pushObject:employee];
        }
    }
}

@end
