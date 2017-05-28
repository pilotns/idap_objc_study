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
@class AMPWorker;

@interface AMPDispatcher : NSObject

- (void)addWorker:(AMPWorker *)worker;
- (void)addWorkers:(id<NSFastEnumeration>)workers;

- (void)removeWorker:(AMPWorker *)worker;
- (void)removeAllWorkers;

- (void)processObject:(id)object;
- (void)processObjects:(NSArray *)objects;

// this method is intended for subclassing, do not call it directly
- (void)performWorkingProcessWithObject:(id)object;

@end
