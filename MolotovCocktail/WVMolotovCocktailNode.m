//
//  WVMolotovCocktailNode.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/8/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVMolotovCocktailNode.h"
#import "WVUtil.h"

@interface WVMolotovCocktailNode()
@property(nonatomic) SKAction *tapAction;
@end

@implementation WVMolotovCocktailNode

+ (instancetype) cocktailAtPosition:(CGPoint)position{
    WVMolotovCocktailNode *cocktail = [self spriteNodeWithImageNamed:@"MolotovCocktail_Normal"];
    cocktail.position = position;
    cocktail.anchorPoint = CGPointMake(.5, 0);
    cocktail.name = @"CockTail";
    cocktail.zPosition = 8;
    
    [cocktail setupAnimation];
    [cocktail setupPhysicsBody];
    return cocktail;
}

-(void) performTap{
    [self runAction:self.tapAction];
}

- (void) setupAnimation {
    NSArray *texture = @[[SKTexture textureWithImageNamed:@"MolotovCocktail_Throw1"],
                         [SKTexture textureWithImageNamed:@"MolotovCocktail_Throw2"],
                         [SKTexture textureWithImageNamed:@"MolotovCocktail_Throw3"],
                         [SKTexture textureWithImageNamed:@"MolotovCocktail_Throw4"]];
    
    SKAction *animation = [SKAction animateWithTextures:texture timePerFrame: .25];
    SKAction *repeatAction = [SKAction repeatActionForever:animation];
    [self runAction:repeatAction];
}

-(void) moveTowardsPosition:(CGPoint)position{    
    float characterStrength = 10;
    float yThrow;
    float xThrow;
    float xThrowPower;
    float yThrowPower;
    yThrow = 10;
    yThrowPower = 650;
    if (self.position.x > position.x){
        xThrow = -1; //throw left
        xThrowPower = self.position.x - position.x;
    } else if (self.position.x < position.x){
        xThrow = 1; //throw right
        xThrowPower = position.x - self.position.x;
    }
    [self.physicsBody applyImpulse:CGVectorMake(xThrow * xThrowPower * characterStrength, yThrow * yThrowPower)];
}

- (void) setupPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.categoryBitMask = WVCollisionCategoryCocktail;
    self.physicsBody.affectedByGravity = YES;
    self.physicsBody.allowsRotation = YES;
    self.physicsBody.contactTestBitMask = WVCollisionCategoryEnemy | WVCollisionCategoryGround | WVCollisionCategoryPlatform;
    self.physicsBody.mass = 10;
}

@end
