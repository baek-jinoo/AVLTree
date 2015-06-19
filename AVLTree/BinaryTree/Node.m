//
//  Node.m
//  AVLTree
//
//  Created by Jin on 5/23/15.
//  Copyright (c) 2015 Jinwoo Baek All rights reserved.
//

#import "Node.h"

@interface Node ()

@property (copy, nonatomic, readwrite) NSNumber *number;

@property (strong, nonatomic, readwrite) Node *rightNode;
@property (strong, nonatomic, readwrite) Node *leftNode;
@property (weak, nonatomic, readwrite) Node *parentNode;
@property (assign, nonatomic, readwrite) NSInteger balance;
@property (assign, nonatomic, readwrite) NSUInteger height;

@end


@implementation Node

#pragma mark - Object Lifecycle

- (instancetype)initWithNumber:(NSNumber *)number;
{
    self = [self init];
    if (self) {
        _number = number;
        _height = 1;
    }
    return self;
}

+ (instancetype)nodeWithNumber:(NSNumber *)number;
{
    return [[self alloc] initWithNumber:number];
}

#pragma mark - Public

- (Node *)insert:(Node *)node;
{
    Node *nodeToReturn = self;
    if (!node) {
        return nodeToReturn;
    }
    NSComparisonResult comparisonResult = [self.number compare:node.number];

    if (comparisonResult == NSOrderedAscending) {
        if (!self.rightNode) {
            self.rightNode = node;
            self.rightNode.height = 1;
        } else {
            self.rightNode = [self.rightNode insert:node];
        }
    }
    else if (comparisonResult == NSOrderedDescending) {
        if (!self.leftNode) {
            self.leftNode = node;
            self.leftNode.height = 1;
        } else {
            self.leftNode = [self.leftNode insert:node];
        }
    }

    if (self.balance > 1) {
        if (self.rightNode.balance < 0) {
            self.rightNode = [self.rightNode rotateLeft];
        }
        nodeToReturn = [self rotateRight];
    }
    else if (self.balance < -1) {
        if (self.leftNode.balance > 0) {
            self.leftNode = [self.leftNode rotateRight];
        }
        nodeToReturn = [self rotateLeft];
    }
    [self updateHeight];
    return nodeToReturn;
}

- (Node *)remove:(NSNumber *)number;
{
    Node *nodeToReturn = self;
    if (!number) {
        return nodeToReturn;
    }

    if ([self.number isEqualToNumber:number]) {
        if (self.balance > 0) {
            nodeToReturn = [self.rightNode insert:self.leftNode];
        }
        else {
            nodeToReturn = [self.leftNode insert:self.rightNode];
        }
        return nodeToReturn;
    }
    else {
        NSComparisonResult comparisonResult = [self.number compare:number];

        if (comparisonResult == NSOrderedAscending) {
            self.rightNode = [self.rightNode remove:number];
        }
        else if (comparisonResult == NSOrderedDescending) {
            self.leftNode = [self.leftNode remove:number];
        }
    }

    if (self.balance < -1) {
        if (self.leftNode.balance > 0) {
            self.leftNode = [self.leftNode rotateRight];
        }
        nodeToReturn = [self rotateLeft];
    }
    else if (self.balance > 1) {
        if (self.rightNode.balance < 0) {
            self.rightNode = [self.rightNode rotateLeft];
        }
        nodeToReturn = [self rotateRight];
    }

    [self updateHeight];
    return nodeToReturn;
}

- (NSInteger)balance;
{
    return self.rightNode.height - self.leftNode.height;
}

- (BOOL)hasValueInRange:(NSRange)range;
{
    BOOL returnValue = NO;
    NSUInteger minimum = range.location;
    NSUInteger maximum = range.location + range.length;

    NSUInteger value = [self.number unsignedIntegerValue];

    if (value <= minimum) {
        if (!self.rightNode) {
            returnValue = NO;
        }
        else {
            returnValue = [self.rightNode hasValueInRange:range];
        }
    }
    else if (value >= maximum) {
        if (!self.leftNode) {
            returnValue = NO;
        }
        else {
            returnValue = [self.leftNode hasValueInRange:range];
        }
    }
    else {
        returnValue = YES;
    }
    return returnValue;
}

#pragma mark - Private

- (void)updateHeight;
{
    self.height = MAX(self.leftNode.height, self.rightNode.height) + 1;
}

- (Node *)rotateLeft;
{
    Node *leftNode = self.leftNode;
    self.leftNode = leftNode.rightNode;
    leftNode.rightNode = self;
    [self updateHeight];
    [leftNode updateHeight];
    return leftNode;
}

- (Node *)rotateRight;
{
    Node *rightNode = self.rightNode;
    self.rightNode = rightNode.leftNode;
    rightNode.leftNode = self;
    [self updateHeight];
    [rightNode updateHeight];
    return rightNode;
}

@end
