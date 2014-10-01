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
    
    //ANNIMATE HERE
    //NSArray *textures;

    if(type == WVEnemyTypeA){
        enemy = [self spriteNodeWithImageNamed:@"NSA"];
        //textures = @[[SKTexture textureWithImageNamed:@"NSA"]];
        
    } else if (type == WVEnemyTypeB){
        enemy = [self spriteNodeWithImageNamed:@"TKMLogo"];
        //textures = @[[SKTexture textureWithImageNamed:@"NSA"]];
    }else {
        enemy = [self spriteNodeWithImageNamed:@"Obama"];
    }
    //SKAction *animation = [SKAction animateWithTextures:textures timePerFrame: 0.1];
    //[enemy runAction:[SKAction repeatActionForever:animation]];
    
    float scale = [WVUtil randomWithMin:10 max:20] / 100.0f;
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
