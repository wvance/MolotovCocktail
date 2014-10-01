//
//  WVAmmoNode.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 9/30/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//
#import "WVAmmoNode.h"
#import "WVUtil.h"
@implementation WVAmmoNode

+ (instancetype) ammoOfType:(WVAmmoType)type{
    WVAmmoNode *ammo;
    
    //ANNIMATE HERE
    //NSArray *textures;
    
    if(type == WVAmmoTypeA){
        ammo = [self spriteNodeWithImageNamed:@"Ammo"];
        //textures = @[[SKTexture textureWithImageNamed:@"NSA"]];
    } else {
        ammo = [self spriteNodeWithImageNamed:@"Ammo"];
        //textures = @[[SKTexture textureWithImageNamed:@"NSA"]];
    }
    //SKAction *animation = [SKAction animateWithTextures:textures timePerFrame: 0.1];
    //[enemy runAction:[SKAction repeatActionForever:animation]];
    float scale = [WVUtil randomWithMin:10 max:20] / 100.0f;
    ammo.xScale = scale;
    ammo.yScale = scale;
    [ammo setupPhysicsBody];
    return ammo;
}

- (void) setupPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = WVCollisionCategoryAmmo;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = WVCollisionCategorySelf | WVCollisionCategoryGround;
    float dy = [WVUtil randomWithMin:WVEnemyMinSpeed max:WVEnemyMaxSpeed];
    self.physicsBody.velocity = CGVectorMake(0, dy);
}

@end

