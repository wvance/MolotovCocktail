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
    
//    NSArray *textures = @[[SKTexture textureWithImageNamed:@"50px-MolotovCocktail"]];
//    
//    SKAction *cocktailAnimation = [SKAction animateWithTextures:textures timePerFrame:.05];
//    SKAction *cocktailRepeat = [SKAction repeatActionForever:cocktailAnimation];
//    [cocktail runAction:cocktailRepeat];
    [cocktail setupAnimation];
    [cocktail setupPhysicsBody];
    return cocktail;
}

- (void) setupPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.categoryBitMask = WVCollisionCategoryCocktail;
    self.physicsBody.affectedByGravity = NO;

//    self.physicsBody.collisionBitMask = WVCollisionCategoryPlatform | WVCollisionCategoryGround;
    self.physicsBody.contactTestBitMask = WVCollisionCategoryProjectile |WVCollisionCategoryGround | WVCollisionCategoryPlatform;
}

-(void) performTap{
    [self runAction:self.tapAction];
}

//- (SKAction *) tapAction {
//    
//    if (_tapAction != nil){
//        return _tapAction;
//    }
//    
//    //ANNIMATE ON TAP WITHIN A NODE
//    NSArray *textures = @[[SKTexture textureWithImageNamed:@"MolotovCocktail_Throw"],
//                           [SKTexture textureWithImageNamed:@"MolotovCocktail_Normal"]];
//
//    _tapAction = [SKAction animateWithTextures:textures timePerFrame: .1];
//    return _tapAction;
//    
//}

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
    float slope = (position.y -self.position.y) / (position.x - self.position.x);
    
    float offScreenX;
    if
        (position.x <= self.position.x ){
        offScreenX = -200;
    } else {
        offScreenX = self.parent.frame.size.width + 200;
    }
    
    float offScreenY = slope * offScreenX - slope * self.position.x + self.position.y;
    
    CGPoint pointOffScreen = CGPointMake(offScreenX, offScreenY);
    
    float distanceA = pointOffScreen.y - self.position.y;
    float distanceB = pointOffScreen.x - self.position.x;
    
    float distanceC = sqrtf(powf(distanceA, 2) + powf(distanceB,2));
    
    //Imported from constants file
    float time = distanceC/WVCocktailThrowSpeed;
    
    SKAction *moveCocktail = [SKAction moveTo: pointOffScreen duration:time];
    [self runAction:moveCocktail];
}

@end