//
//  WVUtil.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/10/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVUtil.h"

@implementation WVUtil

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max{
    return arc4random()%(max-min) + min; 
}

@end
