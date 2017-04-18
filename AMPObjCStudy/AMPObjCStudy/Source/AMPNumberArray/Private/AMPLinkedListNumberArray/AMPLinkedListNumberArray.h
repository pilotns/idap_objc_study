//
//  AMPLinkedListNumberArray.h
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPNumberArray.h"

@class AMPLinkedList;

@interface AMPLinkedListNumberArray : AMPNumberArray
@property (nonatomic, readonly) AMPLinkedList *storage;

- (instancetype)initWithArray:(NSArray *)numbers;

@end
