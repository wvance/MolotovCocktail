//
//  WVBossNode.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 10/13/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVBossNode.h"
#import "WVUtil.h"

@implementation WVBossNode

- (void) setupPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = WVCollisionCategoryEnemy;
    //self.physicsBody.collisionBitMask = 0;
    //self.physicsBody.contactTestBitMask = WVCollisionCategoryCocktail | WVCollisionCategoryGround |WVCollisionCategorySelf;
    //float dy = [WVUtil randomWithMin:WVEnemyMinSpeed max:WVEnemyMaxSpeed];
    //self.physicsBody.velocity = CGVectorMake(0, dy);
}

@end
