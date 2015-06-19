//
//  AVLTree.m
//  AVLTree
//
//  Created by Jin on 5/23/15.
//  Copyright (c) 2015 Jinwoo Baek All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface AVLTree : NSObject

- (void)insert:(Node *)node;
- (BOOL)hasValueInRange:(NSRange)range;
- (void)remove:(NSNumber *)number;

@property (strong, nonatomic) Node *rootNode;

@end
