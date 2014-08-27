//
//  WVUtil.h
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/10/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int WVCocktailThrowSpeed = 400;
static const int WVEnemyMinSpeed = -100;
static const int WVEnemyMaxSpeed = -50;

static const int WVMaxLives = 1;

static const int WVPointsPerHit = 100;

typedef NS_OPTIONS(uint32_t, WVCollisionCategory) {
    WVCollisionCategoryPlatform     = 1 << 0, //0000
    WVCollisionCategoryProjectile   = 1 << 1, //0010
    WVCollisionCategoryGround       = 1 << 2, //0100
    WVCollisionCategorySelf         = 1 << 3, //1000
    WVCollisionCategoryCocktail     = 1 << 4,
    WVCollisionCategoryDebris       = 1 << 5
};


@interface WVUtil : NSObject

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;

@end
