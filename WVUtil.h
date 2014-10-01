//
//  WVUtil.h
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/10/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int WVCocktailThrowSpeed = 200;
static const int WVEnemyMinSpeed = -100;
static const int WVEnemyMaxSpeed = -50;

static const int PlayerSpeed = 300;

static const int WVMaxLives = 3;
static const int WVStartAmmo = 5;
static const int WVAmmoPerThrow = 1;

static const int WVPointsPerHit = 100;

static const int WVAddEnemyRate = 1.5;
static const int WVAddAmmoRate = 7; //Higher number is slower
static const int WVAmmoPerImage = 2;


typedef NS_OPTIONS(uint32_t, WVCollisionCategory) {
    WVCollisionCategoryPlatform     = 1 << 0, //0000
    WVCollisionCategoryEnemy        = 1 << 1, //0010
    WVCollisionCategoryGround       = 1 << 2, //0100
    WVCollisionCategorySelf         = 1 << 3, //1000
    WVCollisionCategoryCocktail     = 1 << 4,
    WVCollisionCategoryDebris       = 1 << 5,
    WVCollisionCategorySide         = 1 << 6,
    WVCollisionCategoryAmmo         = 1 << 7
};


@interface WVUtil : NSObject

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;

@end
