//
//  AVLTreeSpec.m
//  AVLTree
//
//  Created by Jin on 5/23/15.
//  Copyright (c) 2015 Jinwoo Baek All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVLTree.h"
#import "Node.h"

#import <Quick/Quick.h>
#import <Quick/Quick-Swift.h>
#import <Nimble/Nimble.h>
#import <Nimble/Nimble-Swift.h>

QuickSpecBegin(TriangleBinaryTreeSpec)

describe(@"AVLTree", ^{
    __block AVLTree *subject;

    beforeEach(^{
        subject = [[AVLTree alloc] init];
    });

    describe(@"insert", ^{

        context(@"insert one number", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@3]];
            });

            it(@"returns the inserted number", ^{
                expect(subject.rootNode.number).to(equal(@3));

                expect(@(subject.rootNode.height)).to(equal(@1));
            });
        });

        context(@"insert two numbers in increasing order", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@2]];
                [subject insert:[Node nodeWithNumber:@3]];
            });

            it(@"returns the sorted numbers", ^{
                expect(@(subject.rootNode.height)).to(equal(@2));
                expect(@(subject.rootNode.rightNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@2));
                expect(subject.rootNode.rightNode.number).to(equal(@3));
            });
        });

        context(@"insert two nodes in decreasing order", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@2]];
                [subject insert:[Node nodeWithNumber:@1]];
            });

            it(@"returns the sorted numbers", ^{
                expect(@(subject.rootNode.height)).to(equal(@2));
                expect(@(subject.rootNode.leftNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@2));
                expect(subject.rootNode.leftNode.number).to(equal(@1));
            });
        });

        context(@"insert three nodes", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@2]];
                [subject insert:[Node nodeWithNumber:@1]];
                [subject insert:[Node nodeWithNumber:@3]];
            });

            it(@"returns the sorted numbers", ^{
                expect(@(subject.rootNode.height)).to(equal(@2));
                expect(@(subject.rootNode.leftNode.height)).to(equal(@1));
                expect(@(subject.rootNode.rightNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@2));
                expect(subject.rootNode.leftNode.number).to(equal(@1));
                expect(subject.rootNode.rightNode.number).to(equal(@3));
            });
        });

        context(@"insert four nodes", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@2]];
                [subject insert:[Node nodeWithNumber:@1]];
                [subject insert:[Node nodeWithNumber:@3]];
                [subject insert:[Node nodeWithNumber:@4]];
            });

            it(@"returns the sorted numbers", ^{
                expect(@(subject.rootNode.height)).to(equal(@3));
                expect(@(subject.rootNode.leftNode.height)).to(equal(@1));
                expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@2));
                expect(subject.rootNode.leftNode.number).to(equal(@1));
                expect(subject.rootNode.rightNode.number).to(equal(@3));
                expect(subject.rootNode.rightNode.rightNode.number).to(equal(@4));
            });
        });

        context(@"insert six nodes", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@10]];
                [subject insert:[Node nodeWithNumber:@5]];
                [subject insert:[Node nodeWithNumber:@20]];
                [subject insert:[Node nodeWithNumber:@30]];
                [subject insert:[Node nodeWithNumber:@3]];
                [subject insert:[Node nodeWithNumber:@7]];
            });

            it(@"returns the sorted numbers", ^{
                expect(@(subject.rootNode.height)).to(equal(@3));
                expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));
                expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@10));
                expect(subject.rootNode.leftNode.number).to(equal(@5));
                expect(subject.rootNode.leftNode.leftNode.number).to(equal(@3));
                expect(subject.rootNode.leftNode.rightNode.number).to(equal(@7));
                expect(subject.rootNode.rightNode.number).to(equal(@20));
                expect(subject.rootNode.rightNode.rightNode.number).to(equal(@30));
            });
        });

        context(@"causing positive unbalance on the root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@5]];
                [subject insert:[Node nodeWithNumber:@10]];
                [subject insert:[Node nodeWithNumber:@20]];
            });

            it(@"will cause left rotation on the root node", ^{
                expect(@(subject.rootNode.height)).to(equal(@2));
                expect(@(subject.rootNode.leftNode.height)).to(equal(@1));
                expect(@(subject.rootNode.rightNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@10));
                expect(subject.rootNode.leftNode.number).to(equal(@5));
                expect(subject.rootNode.rightNode.number).to(equal(@20));
            });
        });

        context(@"causing negative unbalance on the root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@20]];
                [subject insert:[Node nodeWithNumber:@10]];
                [subject insert:[Node nodeWithNumber:@5]];
            });
            it(@"will cause right rotation on the root node", ^{

                expect(@(subject.rootNode.height)).to(equal(@2));
                expect(@(subject.rootNode.leftNode.height)).to(equal(@1));
                expect(@(subject.rootNode.rightNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@10));
                expect(subject.rootNode.leftNode.number).to(equal(@5));
                expect(subject.rootNode.rightNode.number).to(equal(@20));
            });
        });

        context(@"causing positive unbalance on the right node of the root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@10]];
                [subject insert:[Node nodeWithNumber:@5]];
                [subject insert:[Node nodeWithNumber:@20]];
                [subject insert:[Node nodeWithNumber:@30]];
                [subject insert:[Node nodeWithNumber:@40]];
            });

            it(@"will cause right rotation on the right node of the root node", ^{
                expect(@(subject.rootNode.height)).to(equal(@3));
                expect(@(subject.rootNode.leftNode.height)).to(equal(@1));
                expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@10));
                expect(subject.rootNode.leftNode.number).to(equal(@5));
                expect(subject.rootNode.rightNode.number).to(equal(@30));
                expect(subject.rootNode.rightNode.rightNode.number).to(equal(@40));
                expect(subject.rootNode.rightNode.leftNode.number).to(equal(@20));
            });
        });

        context(@"causing negative unbalance on the left node of the root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@30]];
                [subject insert:[Node nodeWithNumber:@40]];
                [subject insert:[Node nodeWithNumber:@20]];
                [subject insert:[Node nodeWithNumber:@10]];
                [subject insert:[Node nodeWithNumber:@5]];
            });

            it(@"will cause right rotation on the right node of the root node", ^{
                expect(@(subject.rootNode.height)).to(equal(@3));
                expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                expect(@(subject.rootNode.rightNode.height)).to(equal(@1));
                expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@30));
                expect(subject.rootNode.leftNode.number).to(equal(@10));
                expect(subject.rootNode.rightNode.number).to(equal(@40));
                expect(subject.rootNode.leftNode.rightNode.number).to(equal(@20));
                expect(subject.rootNode.leftNode.leftNode.number).to(equal(@5));
            });
        });

        context(@"causing negative unbalance on the root node with an insertion on the right tree of the left node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@50]];
                [subject insert:[Node nodeWithNumber:@60]];
                [subject insert:[Node nodeWithNumber:@40]];
                [subject insert:[Node nodeWithNumber:@30]];
                [subject insert:[Node nodeWithNumber:@45]];
                [subject insert:[Node nodeWithNumber:@43]];
            });

            it(@"causes a double rotation", ^{
                expect(@(subject.rootNode.height)).to(equal(@3));
                expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@45));
                expect(subject.rootNode.leftNode.number).to(equal(@40));
                expect(subject.rootNode.rightNode.number).to(equal(@50));
                expect(subject.rootNode.rightNode.rightNode.number).to(equal(@60));
                expect(subject.rootNode.leftNode.leftNode.number).to(equal(@30));
                expect(subject.rootNode.leftNode.rightNode.number).to(equal(@43));
            });
        });

        context(@"causing positive unbalance on the root node with an insertion on the left tree of the right node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@50]];
                [subject insert:[Node nodeWithNumber:@60]];
                [subject insert:[Node nodeWithNumber:@40]];
                [subject insert:[Node nodeWithNumber:@70]];
                [subject insert:[Node nodeWithNumber:@55]];
                [subject insert:[Node nodeWithNumber:@56]];
            });

            it(@"causes a double rotation", ^{
                expect(@(subject.rootNode.height)).to(equal(@3));
                expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));

                expect(subject.rootNode.number).to(equal(@55));
                expect(subject.rootNode.leftNode.number).to(equal(@50));
                expect(subject.rootNode.rightNode.number).to(equal(@60));
                expect(subject.rootNode.rightNode.rightNode.number).to(equal(@70));
                expect(subject.rootNode.rightNode.leftNode.number).to(equal(@56));
                expect(subject.rootNode.leftNode.leftNode.number).to(equal(@40));
            });
        });

        context(@"duplicate insert for the root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@30]];
                [subject insert:[Node nodeWithNumber:@40]];
                [subject insert:[Node nodeWithNumber:@30]];
            });

            it(@"does not insert the duplicate node", ^{
                expect(subject.rootNode.number).to(equal(@30));
                expect(subject.rootNode.leftNode).to(beNil());
                expect(subject.rootNode.rightNode.number).to(equal(@40));
            });
        });

        context(@"duplicate insert for the right node of the root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@30]];
                [subject insert:[Node nodeWithNumber:@40]];
                [subject insert:[Node nodeWithNumber:@40]];
            });

            it(@"does not insert the duplicate node", ^{
                expect(subject.rootNode.number).to(equal(@30));
                expect(subject.rootNode.leftNode).to(beNil());
                expect(subject.rootNode.rightNode.number).to(equal(@40));
            });
        });
    });

    describe(@"find value in range", ^{

        context(@"root node's value is in range", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@10]];
            });

            it(@"returns YES", ^{
                NSRange range = NSMakeRange(3, 10); // 3 < x < 13
                expect(@([subject hasValueInRange:range])).to(beTrue());
            });
        });

        context(@"root node's value is not in range", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@2]];
            });

            it(@"returns NO", ^{
                NSRange range = NSMakeRange(3, 10); // 3 < x < 13
                expect(@([subject hasValueInRange:range])).to(beFalse());
            });
        });

        context(@"root node's left node value is in range", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@20]];
                [subject insert:[Node nodeWithNumber:@10]];
            });

            it(@"returns YES", ^{
                NSRange range = NSMakeRange(3, 10); // 3 < x < 13
                expect(@([subject hasValueInRange:range])).to(beTrue());
            });
        });

        context(@"root node's left node value is not in range", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@20]];
                [subject insert:[Node nodeWithNumber:@1]];
            });

            it(@"returns ", ^{
                NSRange range = NSMakeRange(3, 10); // 3 < x < 13
                expect(@([subject hasValueInRange:range])).to(beFalse());
            });
        });

        context(@"root node's right node value is in range", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@1]];
                [subject insert:[Node nodeWithNumber:@10]];
            });

            it(@"returns ", ^{
                NSRange range = NSMakeRange(3, 10); // 3 < x < 13
                expect(@([subject hasValueInRange:range])).to(beTrue());
            });
        });

        context(@"root node's right node value is not in range", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@1]];
                [subject insert:[Node nodeWithNumber:@2]];
            });

            it(@"returns NO", ^{
                NSRange range = NSMakeRange(3, 10); // 3 < x < 13
                expect(@([subject hasValueInRange:range])).to(beFalse());
            });
        });

        context(@"root node's right node's left node's value is in range", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@2]];
                [subject insert:[Node nodeWithNumber:@1]];
                [subject insert:[Node nodeWithNumber:@20]];
                [subject insert:[Node nodeWithNumber:@9]];
            });

            it(@"returns YES", ^{
                NSRange range = NSMakeRange(3, 10); // 3 < x < 13
                expect(@([subject hasValueInRange:range])).to(beTrue());
            });
        });
    });

    describe(@"remove", ^{
        context(@"remove root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@4]];
                [subject insert:[Node nodeWithNumber:@5]];
                [subject remove:@4];
            });

            it(@"correctly removes the node", ^{
                expect(subject.rootNode.number).to(equal(@5));
                expect(subject.rootNode.rightNode).to(beNil());
                expect(subject.rootNode.leftNode).to(beNil());
            });
        });

        context(@"failing test case", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@20]];
                [subject insert:[Node nodeWithNumber:@29]];
                [subject insert:[Node nodeWithNumber:@2]];
                [subject insert:[Node nodeWithNumber:@1]];
                [subject insert:[Node nodeWithNumber:@5]];
                [subject remove:@20];
            });

            it(@"correctly removes the node", ^{
                expect(subject.rootNode.number).to(equal(@2));
                expect(subject.rootNode.rightNode.number).to(equal(@5));
                expect(subject.rootNode.rightNode.rightNode.number).to(equal(@29));
                expect(subject.rootNode.leftNode.number).to(equal(@1));
            });
        });

        context(@"remove root node's right node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@1]];
                [subject insert:[Node nodeWithNumber:@5]];
                [subject remove:@5];
            });

            it(@"hasValueInRange returns NO", ^{
                NSRange range = NSMakeRange(3, 10); // 3 < x < 13
                expect(@([subject hasValueInRange:range])).to(beFalse());
                expect(@(subject.rootNode.height)).to(equal(@1));
            });
            //TODO check the actual number values
        });

        context(@"remove root node's left node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@20]];
                [subject insert:[Node nodeWithNumber:@5]];
                [subject remove:@5];
            });

            it(@"hasValueInRange returns NO", ^{
                NSRange range = NSMakeRange(3, 10); // 3 < x < 13
                expect(@([subject hasValueInRange:range])).to(beFalse());
                expect(@(subject.rootNode.height)).to(equal(@1));
            });
        });

        context(@"with an unbalanced tree", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@500]];
                [subject insert:[Node nodeWithNumber:@750]];
                [subject insert:[Node nodeWithNumber:@250]];
                [subject insert:[Node nodeWithNumber:@375]];
                [subject insert:[Node nodeWithNumber:@875]];
                [subject insert:[Node nodeWithNumber:@625]];
                [subject insert:[Node nodeWithNumber:@125]];
                [subject insert:[Node nodeWithNumber:@62]];
                [subject insert:[Node nodeWithNumber:@187]];
                [subject insert:[Node nodeWithNumber:@437]];
                [subject insert:[Node nodeWithNumber:@937]];
                [subject insert:[Node nodeWithNumber:@50]];
            });

            context(@"remove a node to cause a negative two unbalance", ^{
                beforeEach(^{
                    [subject remove:@375];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.number).to(equal(@750));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.rightNode.rightNode.number).to(equal(@937));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@62));
                    expect(subject.rootNode.leftNode.leftNode.leftNode.number).to(equal(@50));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@250));
                    expect(subject.rootNode.leftNode.rightNode.leftNode.number).to(equal(@187));
                    expect(subject.rootNode.leftNode.rightNode.rightNode.number).to(equal(@437));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@4));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.rightNode.height)).to(equal(@1));
                });
            });
        });

        context(@"with an unbalanced tree", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@500]];
                [subject insert:[Node nodeWithNumber:@750]];
                [subject insert:[Node nodeWithNumber:@250]];
                [subject insert:[Node nodeWithNumber:@375]];
                [subject insert:[Node nodeWithNumber:@875]];
                [subject insert:[Node nodeWithNumber:@625]];
                [subject insert:[Node nodeWithNumber:@125]];
                [subject insert:[Node nodeWithNumber:@62]];
                [subject insert:[Node nodeWithNumber:@790]];
                [subject insert:[Node nodeWithNumber:@550]];
                [subject insert:[Node nodeWithNumber:@937]];
                [subject insert:[Node nodeWithNumber:@1000]];
            });

            context(@"remove a node to cause a negative two unbalance", ^{
                beforeEach(^{
                    [subject remove:@625];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@750));
                    expect(subject.rootNode.rightNode.leftNode.leftNode.number).to(equal(@550));
                    expect(subject.rootNode.rightNode.leftNode.rightNode.number).to(equal(@790));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@937));
                    expect(subject.rootNode.rightNode.rightNode.rightNode.number).to(equal(@1000));
                    expect(subject.rootNode.leftNode.number).to(equal(@250));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.leftNode.leftNode.number).to(equal(@62));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@375));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@4));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.leftNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                });
            });
        });

        context(@"create a negatively unbalanced tree for double rotation at a root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@500]];
                [subject insert:[Node nodeWithNumber:@750]];
                [subject insert:[Node nodeWithNumber:@250]];
                [subject insert:[Node nodeWithNumber:@375]];
                [subject insert:[Node nodeWithNumber:@875]];
                [subject insert:[Node nodeWithNumber:@625]];
                [subject insert:[Node nodeWithNumber:@125]];
                [subject insert:[Node nodeWithNumber:@62]];
                [subject insert:[Node nodeWithNumber:@937]];
                [subject insert:[Node nodeWithNumber:@405]];
                [subject insert:[Node nodeWithNumber:@310]];
                [subject insert:[Node nodeWithNumber:@280]];
            });

            context(@"correctly removes the node", ^{
                beforeEach(^{
                    [subject remove:@937];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@375));
                    expect(subject.rootNode.rightNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@405));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@750));
                    expect(subject.rootNode.rightNode.rightNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.rightNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.leftNode.number).to(equal(@250));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.leftNode.leftNode.number).to(equal(@62));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@310));
                    expect(subject.rootNode.leftNode.rightNode.leftNode.number).to(equal(@280));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@4));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.rightNode.leftNode.height)).to(equal(@1));
                });
            });
        });

        context(@"setup for a negatively unbalanced tree for double rotation at a non-root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@1000]];
                [subject insert:[Node nodeWithNumber:@500]];
                [subject insert:[Node nodeWithNumber:@1600]];
                [subject insert:[Node nodeWithNumber:@750]];
                [subject insert:[Node nodeWithNumber:@1200]];
                [subject insert:[Node nodeWithNumber:@250]];
                [subject insert:[Node nodeWithNumber:@2000]];
                [subject insert:[Node nodeWithNumber:@375]];
                [subject insert:[Node nodeWithNumber:@875]];
                [subject insert:[Node nodeWithNumber:@1400]];
                [subject insert:[Node nodeWithNumber:@625]];
                [subject insert:[Node nodeWithNumber:@125]];
                [subject insert:[Node nodeWithNumber:@1800]];
                [subject insert:[Node nodeWithNumber:@2200]];
                [subject insert:[Node nodeWithNumber:@62]];
                [subject insert:[Node nodeWithNumber:@937]];
                [subject insert:[Node nodeWithNumber:@405]];
                [subject insert:[Node nodeWithNumber:@310]];
                [subject insert:[Node nodeWithNumber:@2400]];
                [subject insert:[Node nodeWithNumber:@280]];
            });

            context(@"correctly removes the node", ^{
                beforeEach(^{
                    [subject remove:@937];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@1000));
                    expect(subject.rootNode.rightNode.number).to(equal(@1600));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@1200));
                    expect(subject.rootNode.rightNode.leftNode.rightNode.number).to(equal(@1400));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@2000));
                    expect(subject.rootNode.rightNode.rightNode.leftNode.number).to(equal(@1800));
                    expect(subject.rootNode.rightNode.rightNode.rightNode.number).to(equal(@2200));
                    expect(subject.rootNode.rightNode.rightNode.rightNode.rightNode.number).to(equal(@2400));
                    expect(subject.rootNode.leftNode.number).to(equal(@375));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@500));
                    expect(subject.rootNode.leftNode.rightNode.leftNode.number).to(equal(@405));
                    expect(subject.rootNode.leftNode.rightNode.rightNode.number).to(equal(@750));
                    expect(subject.rootNode.leftNode.rightNode.rightNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.leftNode.rightNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@250));
                    expect(subject.rootNode.leftNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.leftNode.leftNode.leftNode.number).to(equal(@62));
                    expect(subject.rootNode.leftNode.leftNode.rightNode.number).to(equal(@310));
                    expect(subject.rootNode.leftNode.leftNode.rightNode.leftNode.number).to(equal(@280));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@5));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@4));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.leftNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.rightNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@4));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.leftNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.rightNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.leftNode.leftNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.leftNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.rightNode.leftNode.height)).to(equal(@1));
                });
            });
        });

        context(@"create a positively unbalanced tree for double rotation at a root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@500]];
                [subject insert:[Node nodeWithNumber:@750]];
                [subject insert:[Node nodeWithNumber:@250]];
                [subject insert:[Node nodeWithNumber:@375]];
                [subject insert:[Node nodeWithNumber:@875]];
                [subject insert:[Node nodeWithNumber:@625]];
                [subject insert:[Node nodeWithNumber:@125]];
                [subject insert:[Node nodeWithNumber:@62]];
                [subject insert:[Node nodeWithNumber:@937]];
                [subject insert:[Node nodeWithNumber:@560]];
                [subject insert:[Node nodeWithNumber:@685]];
                [subject insert:[Node nodeWithNumber:@715]];
            });

            context(@"correctly removes the node", ^{
                beforeEach(^{
                    [subject remove:@62];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@625));
                    expect(subject.rootNode.rightNode.number).to(equal(@750));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@685));
                    expect(subject.rootNode.rightNode.leftNode.rightNode.number).to(equal(@715));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.rightNode.rightNode.number).to(equal(@937));
                    expect(subject.rootNode.leftNode.number).to(equal(@500));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@250));
                    expect(subject.rootNode.leftNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@560));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@4));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.leftNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                });
            });
        });

        context(@"create a positively unbalanced tree for double rotation at a non-root node", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@1000]];
                [subject insert:[Node nodeWithNumber:@500]];
                [subject insert:[Node nodeWithNumber:@1600]];
                [subject insert:[Node nodeWithNumber:@750]];
                [subject insert:[Node nodeWithNumber:@1200]];
                [subject insert:[Node nodeWithNumber:@250]];
                [subject insert:[Node nodeWithNumber:@2000]];
                [subject insert:[Node nodeWithNumber:@375]];
                [subject insert:[Node nodeWithNumber:@875]];
                [subject insert:[Node nodeWithNumber:@1400]];
                [subject insert:[Node nodeWithNumber:@625]];
                [subject insert:[Node nodeWithNumber:@125]];
                [subject insert:[Node nodeWithNumber:@1800]];
                [subject insert:[Node nodeWithNumber:@2200]];
                [subject insert:[Node nodeWithNumber:@62]];
                [subject insert:[Node nodeWithNumber:@937]];
                [subject insert:[Node nodeWithNumber:@560]];
                [subject insert:[Node nodeWithNumber:@685]];
                [subject insert:[Node nodeWithNumber:@2400]];
                [subject insert:[Node nodeWithNumber:@715]];
            });

            context(@"correctly removes the node", ^{
                beforeEach(^{
                    [subject remove:@62];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@1000));
                    expect(subject.rootNode.rightNode.number).to(equal(@1600));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@1200));
                    expect(subject.rootNode.rightNode.leftNode.rightNode.number).to(equal(@1400));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@2000));
                    expect(subject.rootNode.rightNode.rightNode.leftNode.number).to(equal(@1800));
                    expect(subject.rootNode.rightNode.rightNode.rightNode.number).to(equal(@2200));
                    expect(subject.rootNode.rightNode.rightNode.rightNode.rightNode.number).to(equal(@2400));
                    expect(subject.rootNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@750));
                    expect(subject.rootNode.leftNode.rightNode.leftNode.number).to(equal(@685));
                    expect(subject.rootNode.leftNode.rightNode.leftNode.rightNode.number).to(equal(@715));
                    expect(subject.rootNode.leftNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.leftNode.rightNode.rightNode.rightNode.number).to(equal(@937));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@500));
                    expect(subject.rootNode.leftNode.leftNode.leftNode.number).to(equal(@250));
                    expect(subject.rootNode.leftNode.leftNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.leftNode.rightNode.number).to(equal(@560));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@5));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@4));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.leftNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.rightNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@4));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.leftNode.rightNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.rightNode.leftNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.rightNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.leftNode.leftNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.leftNode.rightNode.height)).to(equal(@1));
                });
            });
        });

        context(@"balanced tree is setup", ^{
            beforeEach(^{
                [subject insert:[Node nodeWithNumber:@500]];
                [subject insert:[Node nodeWithNumber:@750]];
                [subject insert:[Node nodeWithNumber:@250]];
                [subject insert:[Node nodeWithNumber:@375]];
                [subject insert:[Node nodeWithNumber:@875]];
                [subject insert:[Node nodeWithNumber:@625]];
                [subject insert:[Node nodeWithNumber:@125]];
            });

            context(@"remove root node's left node that has a negative balance with the leaf node being a left node", ^{
                beforeEach(^{
                    [subject insert:[Node nodeWithNumber:@62]];
                    [subject remove:@250];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.number).to(equal(@750));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@62));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@375));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                });
            });

            context(@"remove root node's left node that has a negative balance with the leaf node being a right node", ^{
                beforeEach(^{
                    [subject insert:[Node nodeWithNumber:@195]];
                    [subject remove:@250];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.number).to(equal(@750));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.leftNode.number).to(equal(@195));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@375));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@125));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));
                });
            });

            context(@"remove root node's left node that has a positive balance with the leaf node being a right node", ^{
                beforeEach(^{
                    [subject insert:[Node nodeWithNumber:@445]];
                    [subject remove:@250];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.number).to(equal(@750));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.leftNode.number).to(equal(@375));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@445));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                });
            });

            context(@"remove root node's left node that has a positive balance with the leaf node being a left node", ^{
                beforeEach(^{
                    [subject insert:[Node nodeWithNumber:@305]];
                    [subject remove:@250];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.number).to(equal(@750));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.leftNode.number).to(equal(@305));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@375));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                });
            });

            context(@"remove root node's right node that has a negative balance with the leaf node being a left node", ^{
                beforeEach(^{
                    [subject insert:[Node nodeWithNumber:@572]];
                    [subject remove:@750];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.number).to(equal(@625));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@572));
                    expect(subject.rootNode.leftNode.number).to(equal(@250));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@375));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                });
            });

            context(@"remove root node's right node that has a negative balance with the leaf node being a right node", ^{
                beforeEach(^{
                    [subject insert:[Node nodeWithNumber:@695]];
                    [subject remove:@750];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.number).to(equal(@695));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.leftNode.number).to(equal(@250));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@375));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                });
            });

            context(@"remove root node's right node that has a positive balance with the leaf node being a left node", ^{
                beforeEach(^{
                    [subject insert:[Node nodeWithNumber:@820]];
                    [subject remove:@750];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.number).to(equal(@820));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.leftNode.number).to(equal(@250));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@375));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                });
            });

            context(@"remove root node's right node that has a positive balance with the leaf node being a right node", ^{
                beforeEach(^{
                    [subject insert:[Node nodeWithNumber:@1000]];
                    [subject remove:@750];
                });

                it(@"correctly removes the node", ^{
                    expect(subject.rootNode.number).to(equal(@500));
                    expect(subject.rootNode.rightNode.number).to(equal(@875));
                    expect(subject.rootNode.rightNode.rightNode.number).to(equal(@1000));
                    expect(subject.rootNode.rightNode.leftNode.number).to(equal(@625));
                    expect(subject.rootNode.leftNode.number).to(equal(@250));
                    expect(subject.rootNode.leftNode.leftNode.number).to(equal(@125));
                    expect(subject.rootNode.leftNode.rightNode.number).to(equal(@375));
                });

                it(@"sets the heights correctly", ^{
                    expect(@(subject.rootNode.height)).to(equal(@3));
                    expect(@(subject.rootNode.rightNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.height)).to(equal(@2));
                    expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@1));
                    expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@1));
                });
            });

            context(@"create a deeper tree", ^{
                beforeEach(^{
                    [subject insert:[Node nodeWithNumber:@62]];
                    [subject insert:[Node nodeWithNumber:@187]];
                    [subject insert:[Node nodeWithNumber:@313]];
                    [subject insert:[Node nodeWithNumber:@437]];
                    [subject insert:[Node nodeWithNumber:@563]];
                    [subject insert:[Node nodeWithNumber:@687]];
                    [subject insert:[Node nodeWithNumber:@813]];
                    [subject insert:[Node nodeWithNumber:@937]];
                });

                context(@"remove a node's right node that has a negative balance with the leaf node being a left node", ^{
                    beforeEach(^{
                        [subject insert:[Node nodeWithNumber:@280]];
                        [subject remove:@375];
                    });

                    it(@"correctly removes the node", ^{
                        expect(subject.rootNode.number).to(equal(@500));
                        expect(subject.rootNode.rightNode.number).to(equal(@750));
                        expect(subject.rootNode.rightNode.rightNode.number).to(equal(@875));
                        expect(subject.rootNode.rightNode.leftNode.number).to(equal(@625));
                        expect(subject.rootNode.leftNode.number).to(equal(@250));
                        expect(subject.rootNode.leftNode.leftNode.number).to(equal(@125));
                        expect(subject.rootNode.leftNode.rightNode.number).to(equal(@313));
                        expect(subject.rootNode.leftNode.rightNode.leftNode.number).to(equal(@280));
                        expect(subject.rootNode.leftNode.rightNode.rightNode.number).to(equal(@437));
                    });

                    it(@"sets the heights correctly", ^{
                        expect(@(subject.rootNode.height)).to(equal(@4));
                        expect(@(subject.rootNode.rightNode.height)).to(equal(@3));
                        expect(@(subject.rootNode.rightNode.rightNode.height)).to(equal(@2));
                        expect(@(subject.rootNode.rightNode.leftNode.height)).to(equal(@2));
                        expect(@(subject.rootNode.leftNode.height)).to(equal(@3));
                        expect(@(subject.rootNode.leftNode.leftNode.height)).to(equal(@2));
                        expect(@(subject.rootNode.leftNode.rightNode.height)).to(equal(@2));
                        expect(@(subject.rootNode.leftNode.rightNode.leftNode.height)).to(equal(@1));
                        expect(@(subject.rootNode.leftNode.rightNode.rightNode.height)).to(equal(@1));
                    });
                });
            });
        });
    });
});

QuickSpecEnd
