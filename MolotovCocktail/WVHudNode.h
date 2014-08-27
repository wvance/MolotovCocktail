//
//  WVHudNode.h
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/21/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WVHudNode : SKNode

@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger score;

+ (instancetype) hudAtPosition:(CGPoint)position inFrame:(CGRect)frame;


- (void) addPoints: (NSInteger)points; 
- (BOOL) loseLife;

@end
