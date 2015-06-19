//
//  NodeSpec.m
//  AVLTree
//
//  Created by Jin on 5/28/15.
//  Copyright (c) 2015 Jinwoo Baek All rights reserved.
//

#import "Node.h"

#import <Quick/Quick.h>
#import <Quick/Quick-Swift.h>
#import <Nimble/Nimble.h>
#import <Nimble/Nimble-Swift.h>

QuickSpecBegin(NodeSpec)

describe(@"Node", ^{
    __block Node *subject;

    beforeEach(^{
        subject = [Node nodeWithNumber:@10];
    });

    context(@"balance with left node", ^{
        beforeEach(^{
            [subject insert:[Node nodeWithNumber:@5]];
        });

        it(@"returns negative one", ^{
            expect(@(subject.balance)).to(equal(@(-1)));
        });
    });

    context(@"balance with right node", ^{
        beforeEach(^{
            [subject insert:[Node nodeWithNumber:@20]];
        });

        it(@"returns negative one", ^{
            expect(@(subject.balance)).to(equal(@(1)));
        });
    });
});

QuickSpecEnd
