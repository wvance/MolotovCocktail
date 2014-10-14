//
//  WVTitleScene.m
//  SpaceCatTutorial
//
//  Created by Wesley Vance on 8/7/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVTitleScene.h"
#import "WVGamePlayScene.h"
#import "WVCustomButton.h"

@implementation WVTitleScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        // This Loads up the initial background scene.
        
        SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"LoadScreen"];
        backGround.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:backGround];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    WVGamePlayScene *gamePlayScene = [WVGamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:gamePlayScene transition:transition];
    
}

@end
