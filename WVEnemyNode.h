//
//  WVEnemyNode.h
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/10/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, WVEnemyType) {
    WVEnemyTypeA,//Gets value '0'
    WVEnemyTypeB, //Gets value '1'
    WVEnemyTypeC
    
};

@interface WVEnemyNode : SKSpriteNode

+ (instancetype) enemyOfType:(WVEnemyType)type;

@end
