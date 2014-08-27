//
//  WVExplosionNode.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/9/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVExplosionNode.h"

@implementation WVExplosionNode


+ (instancetype) explosionAtPosition:(CGPoint)position{
    WVExplosionNode *Boom = [self spriteNodeWithImageNamed:@"boom64"];
    
    Boom.xScale = .7;
    Boom.yScale = .7;
    
    Boom.position = position;
    Boom.anchorPoint = CGPointMake(.5, 0);
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"boom1"],
                          [SKTexture textureWithImageNamed:@"boom2"],
                          [SKTexture textureWithImageNamed:@"boom3"],
                          [SKTexture textureWithImageNamed:@"boom4"],
                          [SKTexture textureWithImageNamed:@"boom5"],
                          [SKTexture textureWithImageNamed:@"boom6"],
                          [SKTexture textureWithImageNamed:@"boom7"],
                          [SKTexture textureWithImageNamed:@"boom8"],
                          [SKTexture textureWithImageNamed:@"boom9"],
                          [SKTexture textureWithImageNamed:@"boom10"],
                          [SKTexture textureWithImageNamed:@"boom11"],
                          [SKTexture textureWithImageNamed:@"boom12"],
                          [SKTexture textureWithImageNamed:@"boom13"],
                          [SKTexture textureWithImageNamed:@"boom14"],
                          [SKTexture textureWithImageNamed:@"boom15"],
                          [SKTexture textureWithImageNamed:@"boom16"],
                          [SKTexture textureWithImageNamed:@"boom17"],
                          [SKTexture textureWithImageNamed:@"boom18"],
                          [SKTexture textureWithImageNamed:@"boom19"],
                          [SKTexture textureWithImageNamed:@"boom20"],
                          [SKTexture textureWithImageNamed:@"boom21"],
                          [SKTexture textureWithImageNamed:@"boom22"],
                          [SKTexture textureWithImageNamed:@"boom23"],
                          [SKTexture textureWithImageNamed:@"boom24"],
                          [SKTexture textureWithImageNamed:@"boom25"],
                          [SKTexture textureWithImageNamed:@"boom26"],
                          [SKTexture textureWithImageNamed:@"boom27"],
                          [SKTexture textureWithImageNamed:@"boom28"],
                          [SKTexture textureWithImageNamed:@"boom29"],
                          [SKTexture textureWithImageNamed:@"boom30"],
                          [SKTexture textureWithImageNamed:@"boom31"],
                          [SKTexture textureWithImageNamed:@"boom32"],
                          [SKTexture textureWithImageNamed:@"boom33"],
                          [SKTexture textureWithImageNamed:@"boom34"],
                          [SKTexture textureWithImageNamed:@"boom35"],
                          [SKTexture textureWithImageNamed:@"boom36"],
                          [SKTexture textureWithImageNamed:@"boom37"],
                          [SKTexture textureWithImageNamed:@"boom38"],
                          [SKTexture textureWithImageNamed:@"boom39"],
                          [SKTexture textureWithImageNamed:@"boom40"],
                          [SKTexture textureWithImageNamed:@"boom41"],
                          [SKTexture textureWithImageNamed:@"boom42"],
                          [SKTexture textureWithImageNamed:@"boom43"],
                          [SKTexture textureWithImageNamed:@"boom44"],
                          [SKTexture textureWithImageNamed:@"boom45"],
                          [SKTexture textureWithImageNamed:@"boom46"],
                          [SKTexture textureWithImageNamed:@"boom47"],
                          [SKTexture textureWithImageNamed:@"boom48"],
                          [SKTexture textureWithImageNamed:@"boom49"],
                          [SKTexture textureWithImageNamed:@"boom50"],
                          [SKTexture textureWithImageNamed:@"boom51"],
                          [SKTexture textureWithImageNamed:@"boom52"],
                          [SKTexture textureWithImageNamed:@"boom53"],
                          [SKTexture textureWithImageNamed:@"boom54"],
                          [SKTexture textureWithImageNamed:@"boom55"],
                          [SKTexture textureWithImageNamed:@"boom56"],
                          [SKTexture textureWithImageNamed:@"boom57"],
                          [SKTexture textureWithImageNamed:@"boom58"],
                          [SKTexture textureWithImageNamed:@"boom59"],
                          [SKTexture textureWithImageNamed:@"boom60"],
                          [SKTexture textureWithImageNamed:@"boom61"],
                          [SKTexture textureWithImageNamed:@"boom62"],
                          [SKTexture textureWithImageNamed:@"boom63"],
                          [SKTexture textureWithImageNamed:@"boom64"]];
    
    SKAction *cocktailAnimation = [SKAction animateWithTextures:textures timePerFrame:.015];
    //SKAction *cocktailRepeat = [SKAction repeatActionForever:cocktailAnimation];
    [Boom runAction:cocktailAnimation];
    
    
    return Boom;
}


@end
