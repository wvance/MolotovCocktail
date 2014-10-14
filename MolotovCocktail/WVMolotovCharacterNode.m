//
//  WVMolotovCharacterNode.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/8/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVMolotovCharacterNode.h"
#import "WVUtil.h"

@implementation WVMolotovCharacterNode


+ (instancetype) characterAtPosition:(CGPoint)position{
    WVMolotovCharacterNode *Molotov = [self spriteNodeWithImageNamed:@"Molotov_Step1"];
    Molotov.name = @"Molotov";
    Molotov.zPosition = 9;

    Molotov.xScale = 3;
    Molotov.yScale = 3;
    
    Molotov.position = position;
    Molotov.anchorPoint = CGPointMake(.5, 0);
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"Molotov_Step1"],
                          [SKTexture textureWithImageNamed:@"Molotov_Step2"],
                          [SKTexture textureWithImageNamed:@"Molotov_Step3"],
                          [SKTexture textureWithImageNamed:@"Molotov_Step4"],
                          [SKTexture textureWithImageNamed:@"Molotov_Step5"],
                          [SKTexture textureWithImageNamed:@"Molotov_Step6"],
                          [SKTexture textureWithImageNamed:@"Molotov_Step7"],
                          [SKTexture textureWithImageNamed:@"Molotov_Step8"]];
    
    SKAction *cocktailAnimation = [SKAction animateWithTextures:textures timePerFrame:.3];
    SKAction *cocktailRepeat = [SKAction repeatActionForever:cocktailAnimation];
    [Molotov runAction:cocktailRepeat];
    [Molotov setupPhysicsBody];
    
    return Molotov;
}

- (void) setupPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.categoryBitMask = WVCollisionCategorySelf;
    self.physicsBody.affectedByGravity = YES;
    self.physicsBody.dynamic = YES;
    self.physicsBody.contactTestBitMask = WVCollisionCategoryEnemy | WVCollisionCategorySide | WVCollisionCategoryAmmo;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.mass = 100;
}


@end
