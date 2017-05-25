//
//  AMPGCDExtensions.h
//  AMPObjCStudy
//
//  Created by pilotns on 25.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

dispatch_queue_t AMPCreateDispatchSerialQueue();
dispatch_queue_t AMPCreateDispatchConcurrentQueue();

dispatch_queue_t AMPGetGlobalBackgroundQueue();
dispatch_queue_t AMPGetGlobalUtilityQueue();
dispatch_queue_t AMPGetGlobalDefaultQueue();
dispatch_queue_t AMPGetGlobalUserInitiatedQueue();
dispatch_queue_t AMPGetGlobalUserInteractiveQueue();

void AMPSerialDispatchAsyncInBackground(dispatch_block_t block);
void AMPSerialDispatchSyncInBackground(dispatch_block_t block);

void AMPConcurrentDispatchAsyncInBackground(dispatch_block_t block);
void AMPConcurrentDispatchSyncInBackground(dispatch_block_t block);

void AMPDispatchAsyncOnMainQueue(dispatch_block_t block);
void AMPDispatchSyncOnMainQueue(dispatch_block_t block);

dispatch_source_t AMPCreateDispatchTimerOnQueue(dispatch_queue_t queue, uint64_t interval, dispatch_block_t eventHandler);

