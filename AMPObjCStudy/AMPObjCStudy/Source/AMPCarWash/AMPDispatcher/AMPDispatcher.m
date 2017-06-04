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
        
        [worker addObserver:self];
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
        [worker removeObserver:self];
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

- (void)processObject:(id)object {
    [self.processedObjects pushObject:object];
    [self performWork];
}

- (void)processObjects:(NSArray *)objects {
    [self.processedObjects pushObjects:objects];
    [self performWork];
}

#pragma mark -
#pragma mark Private Methods

- (void)performWork {
    AMPQueue *objectsQueue = self.processedObjects;
    
    while (true) {
        id object = [objectsQueue popObject];
        if (!object) {
            break;
        }
        
        id worker = [self.processingObjects popObject];
        if (worker) {
            [worker performProcessingObject:object];
        } else {
            [objectsQueue pushObject:object];
            break;
        }
    }
}

#pragma mark -
#pragma mark AMPEmployeeObserver

- (void)employeeDidFinishWork:(id<AMPDispatcherWorkingProcess>)employee {
    NSMutableSet *workers = self.mutableProcessingObjects;
    @synchronized (self) {
        if ([workers containsObject:employee]) {
            return;
        }
    }
    
    [self.processedObjects pushObject:employee];
    [self performWork];
}

- (void)employeeDidBecomeFree:(id)employee {
    NSMutableSet *workers = self.mutableProcessingObjects;
    @synchronized (self) {
        if (![workers containsObject:employee]) {
            return;
        }
    }
    
    [self.processingObjects pushObject:employee];
    [self performWork];
}

@end
