//
//  WVMolotovCocktailNode.h
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/8/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WVMolotovCocktailNode : SKSpriteNode

+ (instancetype) cocktailAtPosition:(CGPoint)position;
-(void) moveTowardsPosition:(CGPoint)position;
-(void) performTap;

@end
