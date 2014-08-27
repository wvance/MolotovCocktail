//
//  WVExplosionNode.h
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/9/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WVExplosionNode : SKSpriteNode
    + (instancetype) explosionAtPosition:(CGPoint)position;
@end
