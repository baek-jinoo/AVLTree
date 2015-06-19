//
//  Node.h
//  AVLTree
//
//  Created by Jin on 5/23/15.
//  Copyright (c) 2015 Jinwoo Baek All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (copy, nonatomic, readonly) NSNumber *number;

@property (strong, nonatomic, readonly) Node *rightNode;
@property (strong, nonatomic, readonly) Node *leftNode;
@property (weak, nonatomic, readonly) Node *parentNode;
@property (assign, nonatomic, readonly) NSInteger balance;
@property (assign, nonatomic, readonly) NSUInteger height;

- (instancetype)initWithNumber:(NSNumber *)number;
+ (instancetype)nodeWithNumber:(NSNumber *)number;

- (Node *)insert:(Node *)node;
- (BOOL)hasValueInRange:(NSRange)range;
- (Node *)remove:(NSNumber *)number;

@end
