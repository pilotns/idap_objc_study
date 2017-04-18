//
//  AMPLinkedListNode.h
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMPLinkedListNode : NSObject
@property (nonatomic, readonly) NSNumber            *content;
@property (nonatomic, retain)   AMPLinkedListNode   *nextNode;

+ (instancetype)nodeWithContent:(NSNumber *)content;
- (instancetype)initWithContent:(NSNumber *)content;

@end
