//
//  WVGroundNode.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/10/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVGroundNode.h"
#import "WVUtil.h"

@implementation WVGroundNode

+ (instancetype) groundWithSize:(CGSize)size{
    WVGroundNode *ground = [self spriteNodeWithColor:[SKColor blackColor] size:size];
    ground.name = @"Ground";
    ground.position = CGPointMake(size.width /2, size.height/2);
    
    [ground setupPhysicsBody];
    return ground;
}


- (void) setupPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO; //Makes this unaffected by physics
    
    self.physicsBody.categoryBitMask = WVCollisionCategoryGround;
    //self.physicsBody.collisionBitMask = WVCollisionCategoryCocktail;
    self.physicsBody.contactTestBitMask = WVCollisionCategoryProjectile | WVCollisionCategoryCocktail;
}
@end
