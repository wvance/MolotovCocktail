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
    hud.ammo = WVStartAmmo;
    
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
    scoreLabel.text = @"Score: 0";
    scoreLabel.fontSize = 24;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(frame.size.width-20 , -10);
    
    [hud addChild:scoreLabel];
    
    SKLabelNode *ammoLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-CondensedBlack"];
    ammoLabel.name = @"Ammo";
    ammoLabel.text = [NSString stringWithFormat:@"Ammo: %d",WVStartAmmo];
    ammoLabel.fontSize = 24;
    ammoLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    ammoLabel.position  = CGPointMake(frame.size.width - 200, -10);
    [hud addChild:ammoLabel];
    
    return hud;
}

- (void) addPoints: (NSInteger)points{
    self.score += points;
    SKLabelNode *scoreLabel = (SKLabelNode*)[self childNodeWithName:@"Score"];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long) self.score];
}


- (BOOL) loseLife {
    if ( self.lives > 0) {
        NSString *lifeNodeName = [NSString stringWithFormat:@"Life%ld", (long) self.lives];
        SKNode *lifeToRemove = [self childNodeWithName:lifeNodeName];
        
        [lifeToRemove removeFromParent];
        
        self.lives--;
        
        NSLog(@"Life Loss # %ld", (long) self.lives);
    }
    return self.lives == 0;
}
- (BOOL) loseAmmo{
    if (self.ammo > 0){
        self.ammo--;
        SKLabelNode *ammoLabel = (SKLabelNode*)[self childNodeWithName:@"Ammo"];
        ammoLabel.text = [NSString stringWithFormat:@"Ammo: %ld", (long) self.ammo];
        NSLog(@"Ammo # %ld", (long) self.ammo);
    }
    return self.ammo == 0;
}

-(void) gainAmmo: (NSInteger) ammo{
    self.ammo += ammo;
    SKLabelNode *ammoLabel = (SKLabelNode*)[self childNodeWithName:@"Ammo"];
    ammoLabel.text = [NSString stringWithFormat:@"Ammo: %ld", (long) self.ammo];

    NSLog(@"Total Ammo! # %ld", (long) self.ammo);
}
@end
