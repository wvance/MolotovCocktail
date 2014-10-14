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
#import "WVAmmoNode.h"
#import <Parse/Parse.h>

@import CoreMotion;
@interface WVGamePlayScene ()
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval timeSinceAmmoAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;
@property (nonatomic) NSTimeInterval addAmmoTimeInterval;
@property (nonatomic) BOOL gameOver;
@property (nonatomic) BOOL restart;
@property (nonatomic) BOOL gameOverDisplayed;
@property (nonatomic) BOOL noAmmo;
@property (nonatomic) NSInteger finalScore;

@end

@implementation WVGamePlayScene

// Motion manager for accelerometer
CMMotionManager *_motionManager;
// Acceleration value from accelerometer
CGFloat _yAcceleration;

-(id)initWithSize:(CGSize)size {
    
    self.lastUpdateTimeInterval = 0;
    self.timeSinceAmmoAdded = 0;
    self.timeSinceEnemyAdded = 0;
    self.addEnemyTimeInterval = WVAddEnemyRate; //Base is 1.5, higher # is slower
    self.addAmmoTimeInterval = WVAddAmmoRate; //Base is 3, higher # is slower
    
    self.totalGameTime = 0;
    self.minSpeed = WVEnemyMinSpeed;
    self.restart = NO;
    self.gameOver = NO;
    self.gameOverDisplayed = NO;
    self.noAmmo = NO;
    
    if (self = [super initWithSize:size]) {
        
        [self setupPhysicsBody];
        
        //Add Initial Background
        SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"level1background"];
        backGround.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        backGround.xScale = .5;
        backGround.yScale = .5;
        [self addChild:backGround];
        
        //Add Ground
        WVGroundNode *ground = [WVGroundNode groundWithSize:CGSizeMake(self.frame.size.width, 10)];
        [self addChild:ground];
        
        //Add Main Character
        WVMolotovCharacterNode *mainCharacter = [WVMolotovCharacterNode characterAtPosition:CGPointMake(self.frame.size.width / 2, 35)];
        mainCharacter.xScale = 2;
        mainCharacter.yScale = 2;
        [self addChild:mainCharacter];
        
        //Add HUD
        WVHudNode *hud = [WVHudNode hudAtPosition:CGPointMake(0, self.frame.size.height - 20) inFrame:self.frame];
        [self addChild:hud];
        
    
        //SetUp CoreMotion for Movement
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 0.2;
        [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 CMAcceleration acceleration = accelerometerData.acceleration;
                                                 _yAcceleration = (acceleration.y * 0.75) + (_yAcceleration * 0.25);
                                             }];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.gameOver && !self.noAmmo){
        for (UITouch *touch in touches){
            CGPoint position = [touch locationInNode:self];
            
            [self shootCockTailTowardsPosition:position];
            [self loseAmmo];
        }
    } else if (self.restart){
        for (SKNode *node in [self children]) {
            [node removeFromParent];
        }
        
        WVGamePlayScene *scene = [WVGamePlayScene sceneWithSize:self.view.bounds.size];
        [self.view presentScene:scene];
    }
}

- (void) logData{
    //Logging data into Database Online
    WVHudNode *hud = (WVHudNode*)[self childNodeWithName:@"HUD"];
    self.finalScore = hud.score;
    UIDevice * currentDevice = [UIDevice currentDevice];
    NSString *deviceIDString = [currentDevice.identifierForVendor UUIDString]; //getting unique id for the user
    
    NSNumber *playerScoreNum = [NSNumber numberWithInt: (int) hud.score]; //converting score into NSNumber format in which Parse expect the score
    
    PFObject *scoreObject = [PFObject objectWithClassName:@"PLAYERSCORE"];
    [scoreObject setObject:deviceIDString forKey:@"USER_ID"]; //user's unique id
    
    [scoreObject setObject:playerScoreNum forKey:@"SCORE"]; //user's score
    [scoreObject saveInBackground]; //saving in background, so our application is not halted while saving the score.
}

- (void) didSimulatePhysics
{
    WVMolotovCharacterNode *mainCharacter = (WVMolotovCharacterNode*)[self childNodeWithName:@"Molotov"];
    // Set velocity based on x-axis acceleration
    mainCharacter.physicsBody.velocity = CGVectorMake(_yAcceleration * 400.0f, mainCharacter.physicsBody.velocity.dy);
    return;
}

- (void) performGameOver {
    WVHudNode *hud = (WVHudNode*)[self childNodeWithName:@"HUD"];
    UIDevice * currentDevice = [UIDevice currentDevice];
    NSString *deviceIDString = [currentDevice.identifierForVendor UUIDString]; //getting unique id for the user
    
    NSNumber *playerScoreNum = [NSNumber numberWithInt: (int) hud.score]; //converting score into NSNumber format in which Parse expect the score

    PFQuery *query = [PFQuery queryWithClassName:@"PLAYERSCORE"]; //creating query for Parse of Highest Score
    
    [query whereKey:@"USER_ID" equalTo:deviceIDString];
    [query orderByDescending:@"SCORE"]; //Sorting the score so we have highest score on the top
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *scoreArray, NSError *error) {
        
        NSNumber* hightestScore = [scoreArray.firstObject objectForKey:@"SCORE"]; //highest score is first object
        NSLog(@"highest score %@ devise %@",hightestScore, deviceIDString);
        
        if (hightestScore < playerScoreNum){
            hightestScore = playerScoreNum; //if highest score so far is smaller than current score, display current score
        }
        NSString * highscoremsg = [NSString stringWithFormat:@"Highest Score: %@",hightestScore];
        
        SKLabelNode *highscore = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"]; //Displaying highest score label
        highscore.text = highscoremsg;
        highscore.fontColor = [SKColor redColor];
        highscore.position = CGPointMake(self.size.width/2, 200);
        [highscore setScale:.5];
        [self addChild:highscore];
        
    }];

    WVGameOverNode *gameOver = [WVGameOverNode gameOverAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [self addChild:gameOver];
    self.restart = YES;
    self.gameOverDisplayed = YES;
    [gameOver performAnimation];
    [self logData];
}

- (void) shootCockTailTowardsPosition:(CGPoint)position{
    WVMolotovCocktailNode *Cocktail = (WVMolotovCocktailNode*) [self childNodeWithName:@"CockTail"];
    WVMolotovCharacterNode *Molotov = (WVMolotovCharacterNode*)[self childNodeWithName:@"Molotov"];
    Cocktail = [WVMolotovCocktailNode cocktailAtPosition:CGPointMake(Molotov.position.x, Molotov.position.y + Molotov.frame.size.height )];
    
    [self addChild:Cocktail];
    [Cocktail performTap];
    [Cocktail moveTowardsPosition:position];
}

- (void) addAmmoToScreen {
    NSUInteger randomAmmo = [WVUtil randomWithMin:0 max:1];
    WVAmmoNode *ammo = [WVAmmoNode ammoOfType:randomAmmo];
    float y = self.frame.size.height + ammo.size.height;
    float x = [WVUtil randomWithMin:10 + ammo.size.width max:self.frame.size.width - ammo.size.width - 10];
    ammo.position = CGPointMake(x, y);
    
    [self addChild:ammo];
}

- (void) addEnemy {
    NSUInteger randomEnemy = [WVUtil randomWithMin:0 max:1];
    WVEnemyNode *enemy = [WVEnemyNode enemyOfType:randomEnemy];
    float y = self.frame.size.height + enemy.size.height;
    float x = [WVUtil randomWithMin:10 + enemy.size.width max:self.frame.size.width - enemy.size.width - 10];
    enemy.position = CGPointMake(x,y);
    
    [self addChild:enemy];
}

- (void) update:(NSTimeInterval)currentTime {
    if (self.lastUpdateTimeInterval){
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.timeSinceAmmoAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    if (self.timeSinceEnemyAdded > self.addEnemyTimeInterval && !self.gameOver) {
        [self addEnemy];
        self.timeSinceEnemyAdded = 0;
    }
    if (self.timeSinceAmmoAdded > self.addAmmoTimeInterval && !self.gameOver){
        [self addAmmoToScreen];
        self.timeSinceAmmoAdded = 0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if ( self.totalGameTime > 480){
        //8 min
        self.addEnemyTimeInterval = WVAddEnemyRate - 1;
        self.minSpeed = -160;
    } else if (self.totalGameTime > 240){
        //4 min
        self.addEnemyTimeInterval = WVAddEnemyRate - .75;
        self.minSpeed = -150;
    }else if (self.totalGameTime >120){
        //2 min
        self.addEnemyTimeInterval = WVAddEnemyRate - .5;
        self.minSpeed = -125;
    }else if (self.totalGameTime > 30){
        self.addEnemyTimeInterval = WVAddEnemyRate - .25;
        self.minSpeed = -100;
    }
    
    if (self.gameOver && !self.gameOverDisplayed){
        [self performGameOver];
    }
    return;
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
    
    if (firstBody.categoryBitMask == WVCollisionCategoryEnemy && secondBody.categoryBitMask == WVCollisionCategoryCocktail) {
        NSLog(@"BAM!");
        
        WVEnemyNode *enemy = (WVEnemyNode *)firstBody.node;
        WVMolotovCocktailNode *cocktail = (WVMolotovCocktailNode *)secondBody.node;
        
        [self addPoints:WVPointsPerHit];
        
        [enemy removeFromParent];
        [cocktail removeFromParent];
        [self createBoomAtPosition:contact.contactPoint];
        
    } else if (firstBody.categoryBitMask == WVCollisionCategoryEnemy && secondBody.categoryBitMask == WVCollisionCategoryGround){
        NSLog(@"Hit Ground!");
        WVEnemyNode *enemy = (WVEnemyNode *)firstBody.node;
        [enemy removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
        //[self loseLife];
        
    } else if (firstBody.categoryBitMask == WVCollisionCategoryEnemy && secondBody.categoryBitMask == WVCollisionCategorySelf){
        NSLog(@"Hit Molotov!");
        WVEnemyNode *enemy = (WVEnemyNode *)firstBody.node;
        [enemy removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
        [self loseLife];
    } else if (firstBody.categoryBitMask == WVCollisionCategoryGround && secondBody.categoryBitMask == WVCollisionCategoryCocktail){
        NSLog(@"Missed!");
        WVMolotovCocktailNode *cocktail = (WVMolotovCocktailNode *)secondBody.node;
        [cocktail removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
        [self createBoomAtPosition:contact.contactPoint];
    } else if (firstBody.categoryBitMask == WVCollisionCategorySelf && secondBody.categoryBitMask == WVCollisionCategorySide){
        NSLog(@"Collided with Side");
    } else if (firstBody.categoryBitMask == WVCollisionCategorySelf && secondBody.categoryBitMask == WVCollisionCategoryAmmo){
        NSLog(@"Got some Ammo!");
        WVAmmoNode *ammo = (WVAmmoNode *)secondBody.node;
        [ammo removeFromParent];
        [self gainAmmo];
    } else if (firstBody.categoryBitMask == WVCollisionCategoryGround && secondBody.categoryBitMask == WVCollisionCategoryAmmo){
        NSLog(@"Ammo Hit Ground!");
        WVAmmoNode *ammo = (WVAmmoNode *)secondBody.node;
        [ammo removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
    }
}

- (void) gainAmmo{
    WVHudNode *hud = (WVHudNode*)[self childNodeWithName:@"HUD"];
    [hud gainAmmo:WVAmmoPerImage];
    self.noAmmo = NO;
}

- (void) loseLife{
    WVHudNode *hud = (WVHudNode*)[self childNodeWithName:@"HUD"];
    self.gameOver = [hud loseLife];
}
- (void) loseAmmo{
    WVHudNode *hud = (WVHudNode*)[self childNodeWithName:@"HUD"];
    self.noAmmo = [hud loseAmmo];
}
- (void) addPoints:(NSInteger)points{
    WVHudNode *hud = (WVHudNode*)[self childNodeWithName:@"HUD"];
    [hud addPoints:points];
}

- (void) createDebrisAtPosition:(CGPoint)position{
    NSInteger numberOfPieces = [WVUtil randomWithMin:5 max:20];
    
    for (int i=0; i<numberOfPieces; i++){
        NSInteger randomPiece = [WVUtil randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%ld",(long)randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        
        debris.position = position;
        
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = WVCollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = WVCollisionCategoryGround;
        debris.name = @"Debris";
        debris.physicsBody.velocity = CGVectorMake([WVUtil randomWithMin:-150 max:150], [WVUtil randomWithMin:150 max:350]);
        [debris runAction: [SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
    }
}

- (void) createBoomAtPosition:(CGPoint)position{
        WVExplosionNode *boom = [WVExplosionNode explosionAtPosition:position];
        [self addChild:boom];
    
        [boom runAction: [SKAction waitForDuration:1.0] completion:^{
            [boom removeFromParent];
        }];
}

- (void) setupPhysicsBody{
    self.physicsWorld.gravity = CGVectorMake(0, -9.8);
    self.physicsWorld.contactDelegate = self;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = WVCollisionCategorySide;
}

@end
