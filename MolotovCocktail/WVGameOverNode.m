//
//  WVGameOverNode.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/27/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVGameOverNode.h"

@implementation WVGameOverNode

+ (instancetype) gameOverAtPosition:(CGPoint)position{
    WVGameOverNode *gameOver = [self node];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-CondensedBlack"];
    gameOverLabel.name = @"GameOver";
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 48;
    gameOverLabel.position = position;
    [gameOver addChild:gameOverLabel];

    return gameOver;
}

- (void) performAnimation{
    SKLabelNode *label = (SKLabelNode*) [self childNodeWithName:@"GameOver"];
    label.xScale = 0;
    label.yScale = 0;
    SKAction *scaleUp = [SKAction scaleTo:1.2f duration:.75f];
    SKAction *scaleDown = [SKAction scaleTo:.9f duration:.25f];
    SKAction *run = [SKAction runBlock:^{
        SKLabelNode *touchToRestart = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-CondensedBlack"];
        touchToRestart.text = @"Touch To Restart";
        touchToRestart.fontSize = 24;
        touchToRestart.position = CGPointMake(label.position.x, label.position.y - 40);
        [self addChild:touchToRestart];
    }];
    
    SKAction *scaleSequence = [SKAction sequence:@[scaleUp,scaleDown,run]];
    [label runAction:scaleSequence];
}
@end
