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

static const int PlayerSpeed = 100;

static const int WVMaxLives = 1;
static const int WVStartAmmo = 10;
static const int WVAmmoPerThrow = 1;

//Score Stats
static const int WVPointsPerHit = 100;

//New Sprite Add to Frame Rates
static const int WVAddEnemyRate = 1.5;
static const int WVAddAmmoRate = 7; //Higher number is slower
static const int WVAmmoPerImage = 2;

//Boss Base Stats
static const int WVBossHealth = 100;
static const int WVBossDamage = 10;
static const int WVBossSpeed = 10;



typedef NS_OPTIONS(uint32_t, WVCollisionCategory) {
    WVCollisionCategoryPlatform     = 1 << 0, //0000
    WVCollisionCategoryEnemy        = 1 << 1, //0010
    WVCollisionCategoryGround       = 1 << 2, //0100
    WVCollisionCategorySelf         = 1 << 3, //1000
    WVCollisionCategoryCocktail     = 1 << 4,
    WVCollisionCategoryDebris       = 1 << 5,
    WVCollisionCategorySide         = 1 << 6,
    WVCollisionCategoryAmmo         = 1 << 7,
    WVCollisionCategoryBoss         = 1 << 8
};


@interface WVUtil : NSObject

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;

@end
