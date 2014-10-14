//
//  WVEnemyNode.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/10/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVEnemyNode.h"
#import "WVUtil.h"

@implementation WVEnemyNode

+ (instancetype) enemyOfType:(WVEnemyType)type{
    WVEnemyNode *enemy;

    if(type == WVEnemyTypeA){
        enemy = [self spriteNodeWithImageNamed:@"Astroid_01"];
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"Astroid_01"],
                              [SKTexture textureWithImageNamed:@"Astroid_02"],
                              [SKTexture textureWithImageNamed:@"Astroid_03"],
                              [SKTexture textureWithImageNamed:@"Astroid_04"],
                              [SKTexture textureWithImageNamed:@"Astroid_05"],
                              [SKTexture textureWithImageNamed:@"Astroid_06"],
                              [SKTexture textureWithImageNamed:@"Astroid_07"],
                              [SKTexture textureWithImageNamed:@"Astroid_08"],
                              [SKTexture textureWithImageNamed:@"Astroid_09"],
                              [SKTexture textureWithImageNamed:@"Astroid_10"],
                              [SKTexture textureWithImageNamed:@"Astroid_11"],
                              [SKTexture textureWithImageNamed:@"Astroid_12"],
                              [SKTexture textureWithImageNamed:@"Astroid_13"],
                              [SKTexture textureWithImageNamed:@"Astroid_14"],
                              [SKTexture textureWithImageNamed:@"Astroid_15"],
                              [SKTexture textureWithImageNamed:@"Astroid_16"],
                              [SKTexture textureWithImageNamed:@"Astroid_17"],
                              [SKTexture textureWithImageNamed:@"Astroid_18"],
                              [SKTexture textureWithImageNamed:@"Astroid_19"]];
        
        SKAction *animation = [SKAction animateWithTextures:textures timePerFrame: 0.08];
        [enemy runAction:[SKAction repeatActionForever:animation]];

    } else if (type == WVEnemyTypeB){
        enemy = [self spriteNodeWithImageNamed:@"TKMLogo"];
        //textures = @[[SKTexture textureWithImageNamed:@"NSA"]];
    }else {
        enemy = [self spriteNodeWithImageNamed:@"Obama"];
    }
    
    float scale = [WVUtil randomWithMin:40 max:70] / 100.0f;
    enemy.xScale = scale;
    enemy.yScale = scale;
    
    [enemy setupPhysicsBody];
    
    return enemy;
}

- (void) setupPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = WVCollisionCategoryEnemy;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = WVCollisionCategoryCocktail | WVCollisionCategoryGround |WVCollisionCategorySelf;
    float dy = [WVUtil randomWithMin:WVEnemyMinSpeed max:WVEnemyMaxSpeed];
    self.physicsBody.velocity = CGVectorMake(0, dy);
}
@end
