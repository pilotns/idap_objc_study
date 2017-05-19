//
//  AMPDispatcher.h
//  AMPObjCStudy
//
//  Created by pilotns on 15.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPDispatcherWorkingProcess.h"

@class AMPQueue;

@interface AMPDispatcher : NSObject
@property (nonatomic, readonly) AMPQueue    *workers;
@property (nonatomic, readonly) AMPQueue    *queue;

- (void)addWorkers:(id<NSFastEnumeration>)workers;

- (void)addObjectForProcessing:(id<AMPDispatcherWorkingProcess>)object;
- (void)addObjectsForProcessing:(NSArray *)objects;

// this method is intended for subclassing, do not call it directly
- (void)performWorkingProcessWithObject:(id)object;

// this method is intended for subclassing, do not call it directly
- (void)workerDidBecomeFree:(id)worker;

@end
