//
//  AMPGCDExtensions.m
//  AMPObjCStudy
//
//  Created by pilotns on 25.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPGCDExtensions.h"

static char * const kAMPDispatchSerialQueue = "kAMPDispatchSerialQueue";
static char * const kAMPDispatchConcurrentQueue = "kAMPDispatchConcurrentQueue";

dispatch_queue_t AMPCreateDispatchSerialQueue() {
    return dispatch_queue_create(kAMPDispatchSerialQueue, DISPATCH_QUEUE_SERIAL);
}

dispatch_queue_t AMPCreateDispatchConcurrentQueue() {
    return dispatch_queue_create(kAMPDispatchConcurrentQueue, DISPATCH_QUEUE_CONCURRENT);
}

dispatch_queue_t AMPGetGlobalBackgroundQueue() {
    return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);
}

dispatch_queue_t AMPGetGlobalUtilityQueue() {
    return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0);
}

dispatch_queue_t AMPGetGlobalDefaultQueue() {
    return dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
}

dispatch_queue_t AMPGetGlobalUserInitiatedQueue() {
    return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
}

dispatch_queue_t AMPGetGlobalUserInteractiveQueue() {
    return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
}

void AMPSerialDispatchAsyncInBackground(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_queue_t queue = AMPCreateDispatchSerialQueue();
    dispatch_async(queue, block);
    dispatch_release(queue);
}

void AMPSerialDispatchSyncInBackground(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_queue_t queue = AMPCreateDispatchSerialQueue();
    dispatch_sync(queue, block);
    dispatch_release(queue);
}

void AMPConcurrentDispatchAsyncInBackground(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_async(AMPGetGlobalBackgroundQueue(), block);
}

void AMPConcurrentDispatchSyncInBackground(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_sync(AMPGetGlobalBackgroundQueue(), block);
}

void AMPDispatchAsyncOnMainQueue(dispatch_block_t block) {
    if (!block) {
        return;
    }

    dispatch_async(dispatch_get_main_queue(), block);
}

void AMPDispatchSyncOnMainQueue(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    if ([[NSThread currentThread] isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

dispatch_source_t AMPCreateDispatchTimerOnQueue(dispatch_queue_t queue, uint64_t interval, dispatch_block_t eventHandler) {
    if (!eventHandler) {
        return NULL;
    }
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, eventHandler);
    dispatch_resume(timer);
    
    return timer;
}

