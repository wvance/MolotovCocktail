//
//  WVGameOverNode.h
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/27/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WVGameOverNode : SKNode

+ (instancetype) gameOverAtPosition:(CGPoint)position;
- (void) performAnimation;
@end
