//
//  AVLTree.h
//  AVLTree
//
//  Created by Jin on 5/23/15.
//  Copyright (c) 2015 Jinwoo Baek All rights reserved.
//

#import "AVLTree.h"

@implementation AVLTree

- (void)insert:(Node *)node;
{
    if (!self.rootNode) {
        self.rootNode = node;
    }
    else {
        self.rootNode = [self.rootNode insert:node];
    }
}

- (BOOL)hasValueInRange:(NSRange)range;
{
    BOOL returnBOOL = NO;
    if (self.rootNode) {
        returnBOOL = [self.rootNode hasValueInRange:range];
    }

    return returnBOOL;
}

- (void)remove:(NSNumber *)number;
{
    if (self.rootNode) {
        if ([self.rootNode.number isEqualToNumber:number]) {
            self.rootNode = [self.rootNode remove:number];
        }
        else {
            self.rootNode = [self.rootNode remove:number];
        }
    }
}

@end
