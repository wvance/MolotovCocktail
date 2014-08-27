//
//  WVGamePlayScene.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 8/7/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVGamePlayScene.h"
#import "WVMolotovCocktailNode.h"
#import "WVMolotovCharacterNode.h"
#import "WVExplosionNode.h"
#import "WVEnemyNode.h"
#import "WVGroundNode.h"
#import "WVUtil.h"
#import "WVHudNode.h"
#import "WVGameOverNode.h"

@interface WVGamePlayScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;
@property (nonatomic) BOOL gameOver;
@property (nonatomic) BOOL restart;
@property (nonatomic) BOOL gameOverDisplayed;
@end

@implementation WVGamePlayScene

-(id)initWithSize:(CGSize)size {
    self.lastUpdateTimeInterval = 0;
    self.timeSinceEnemyAdded = 0;
    self.addEnemyTimeInterval = 1.5;
    self.totalGameTime = 0;
    self.minSpeed = WVEnemyMinSpeed;
    self.restart = NO;
    self.gameOver = NO;
    self.gameOverDisplayed = NO;
    
    if (self = [super initWithSize:size]) {
        
        // This Loads up the initial background scene.
        SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"citybg"];
        backGround.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:backGround];

        
//        WVMolotovCocktailNode *cocktail =[WVMolotovCocktailNode cocktailAtPosition:CGPointMake(CGRectGetMidX(self.frame) - 200,50)];
//        [self addChild:cocktail];
        
//        WVExplosionNode *boom = [WVExplosionNode explosionAtPosition:CGPointMake(CGRectGetMidX(self.frame), 120)];
//        [self addChild:boom];
        
        WVMolotovCharacterNode *molotv = [WVMolotovCharacterNode characterAtPosition:CGPointMake(250, 20)];
        [self addChild:molotv];
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        self.physicsWorld.contactDelegate = self;
        
        WVGroundNode *ground = [WVGroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
        [self addChild:ground];
        
        
        WVHudNode *hud = [WVHudNode hudAtPosition:CGPointMake(0, self.frame.size.height - 20) inFrame:self.frame];
        
        [self addChild:hud];
//        [self addEnemy];
        
    }
    return self;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.gameOver){
        for (UITouch *touch in touches){
            CGPoint position = [touch locationInNode:self];
            [self shootCockTailTowardsPosition:position];
        }
    } else if (self.restart){
        for (SKNode *node in [self children]) {
            [node removeFromParent];
        }
        
        WVGamePlayScene *scene = [WVGamePlayScene sceneWithSize:self.view.bounds.size];
        [self.view presentScene:scene];
    }
}

- (void) performGameOver {
    WVGameOverNode *gameOver = [WVGameOverNode gameOverAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [self addChild:gameOver];
    
    self.restart = YES;
    self.gameOverDisplayed = YES;
    [gameOver performAnimation];
}

- (void) shootCockTailTowardsPosition:(CGPoint)position{
    WVMolotovCocktailNode *Cocktail = (WVMolotovCocktailNode*) [self childNodeWithName:@"CockTail"];
    
    WVMolotovCharacterNode *Molotov = (WVMolotovCharacterNode*)[self childNodeWithName:@"Molotov"];
    
    Cocktail = [WVMolotovCocktailNode cocktailAtPosition:CGPointMake(Molotov.position.x, Molotov.position.y + Molotov.frame.size.height - 15)];
    [self addChild:Cocktail];
    [Cocktail performTap];
    [Cocktail moveTowardsPosition:position];
}

- (void) addEnemy {
    NSUInteger randomEnemy = [WVUtil randomWithMin:0 max:3];
    
    WVEnemyNode *enemy = [WVEnemyNode enemyOfType:randomEnemy];
    float dy = [WVUtil randomWithMin:WVEnemyMinSpeed max:WVEnemyMaxSpeed];
    enemy.physicsBody.velocity = CGVectorMake(0, dy);

    
    float y = self.frame.size.height + enemy.size.height;
    float x = [WVUtil randomWithMin:10+enemy.size.width max:self.frame.size.width - enemy.size.width - 10];
    
    enemy.position = CGPointMake(x,y);
    [self addChild:enemy];
}

- (void) update:(NSTimeInterval)currentTime {
    
    if (self.lastUpdateTimeInterval){
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    if (self.timeSinceEnemyAdded > self.addEnemyTimeInterval && !self.gameOver) {
        [self addEnemy];
        self.timeSinceEnemyAdded = 0;
    }
    self.lastUpdateTimeInterval = currentTime;
    
    if ( self.totalGameTime > 480){
        //8 min
        self.addEnemyTimeInterval = 0.5;
        self.minSpeed = -160;
    } else if (self.totalGameTime > 240){
        //4 min
        self.addEnemyTimeInterval = .75;
        self.minSpeed = -150;
    }else if (self.totalGameTime >120){
        //2 min
        self.addEnemyTimeInterval = 1.0;
        self.minSpeed = -125;
    }else if (self.totalGameTime > 30){
        self.addEnemyTimeInterval = 1.25;
        self.minSpeed = -100;
    }
    
    if (self.gameOver && !self.gameOverDisplayed){
        [self performGameOver];
    }
}

- (void) didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody *firstBody, *secondBody;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == WVCollisionCategoryProjectile && secondBody.categoryBitMask == WVCollisionCategoryCocktail) {
        NSLog(@"BAM!");
        
        WVEnemyNode *enemy = (WVEnemyNode *)firstBody.node;
        WVMolotovCocktailNode *cocktail = (WVMolotovCocktailNode *)secondBody.node;
        
        [self addPoints:WVPointsPerHit];
        
        [enemy removeFromParent];
        [cocktail removeFromParent];
        
    } else if (firstBody.categoryBitMask == WVCollisionCategoryProjectile && secondBody.categoryBitMask == WVCollisionCategoryGround){
        NSLog(@"Hit Ground!");
        
        WVEnemyNode *enemy = (WVEnemyNode *)firstBody.node;        
        [enemy removeFromParent];
        
        [self loseLife];
        
    }
    [self createDebrisAtPosition:contact.contactPoint];
}

- (void) loseLife{
    WVHudNode *hud = (WVHudNode*)[self childNodeWithName:@"HUD"];
    self.gameOver = [hud loseLife];
}

- (void) addPoints:(NSInteger)points{
    WVHudNode *hud = (WVHudNode*)[self childNodeWithName:@"HUD"];
    [hud addPoints:points];
}

- (void) createDebrisAtPosition:(CGPoint)position{
    NSInteger numberOfPieces = [WVUtil randomWithMin:5 max:20];
    
    for (int i=0; i<numberOfPieces; i++){
        NSInteger randomPiece = [WVUtil randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%d",randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        
        WVExplosionNode *boom = [WVExplosionNode explosionAtPosition:position];
        [self addChild:boom];
        
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = WVCollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = WVCollisionCategoryGround | WVCollisionCategoryDebris;
        debris.name = @"Debris";
        
        debris.physicsBody.velocity = CGVectorMake([WVUtil randomWithMin:-150 max:150], [WVUtil randomWithMin:150 max:350]);
        
        [debris runAction: [SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
        
        [boom runAction: [SKAction waitForDuration:1.0] completion:^{
            [boom removeFromParent];
        }];
    }
}

@end
