//
//  WVHudNode.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/21/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVHudNode.h"
#import "WVUtil.h" 

@implementation WVHudNode

+ (instancetype) hudAtPosition:(CGPoint)position inFrame:(CGRect)frame {
    WVHudNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 10;
    hud.name = @"HUD";
    
    SKSpriteNode *molotovHead = [SKSpriteNode spriteNodeWithImageNamed:@"DeptofDestruction"];
    molotovHead.position = CGPointMake(20, -10);
    molotovHead.xScale = .1; 
    molotovHead.yScale = .1;
    [hud addChild:molotovHead];
    
    hud.lives = WVMaxLives;
    
    SKSpriteNode *lastLifeBar;
    
    for (int i = 0; i < hud.lives; i++){
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"Heart"];
        lifeBar.name = [NSString stringWithFormat:@"Life%d", i+1];
        lifeBar.yScale = .3;
        lifeBar.xScale = .3;
        
        [hud addChild:lifeBar];
        
        if (lastLifeBar == nil){
            lifeBar.position = CGPointMake(molotovHead.position.x + 30, molotovHead.position.y);
        }
        else {
            lifeBar.position = CGPointMake(lastLifeBar.position.x + 20, lastLifeBar.position.y);
        }
        
        lastLifeBar = lifeBar;
    }
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-CondensedBlack"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize = 24;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(frame.size.width-20 , -10);
    
    [hud addChild:scoreLabel];
    
    return hud;
}

- (void) addPoints: (NSInteger)points{
    self.score += points;
    
    SKLabelNode *scoreLabel = (SKLabelNode*)[self childNodeWithName:@"Score"];
    scoreLabel.text = [NSString stringWithFormat:@"%d",self.score];
}

- (BOOL) loseLife {
    if ( self.lives > 0) {
        NSString *lifeNodeName = [NSString stringWithFormat:@"Life%d", self.lives];
        SKNode *lifeToRemove = [self childNodeWithName:lifeNodeName];
        
        [lifeToRemove removeFromParent];
        
        self.lives--;
        
        NSLog(@"Life Loss # %d",self.lives);
    }
    return self.lives == 0;
}


@end
