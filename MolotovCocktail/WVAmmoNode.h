//
//  WVAmmoNode.h
//  MolotovCocktail
//
//  Created by Wesley Vance on 9/30/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, WVAmmoType) {
    WVAmmoTypeA,//Gets value '0'
    WVAmmoTypeB //Gets value '1'
};

@interface WVAmmoNode : SKSpriteNode
+ (instancetype) ammoOfType:(WVAmmoType)type;

@end

