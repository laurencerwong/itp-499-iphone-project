//
//  Marble.h
//  Game
//
//  Created by ITP Student on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "BallPulse.h"

@interface Marble : CCSprite {
	CGPoint _myTarget;
	CGPoint _myAcceleration;
	CGPoint _myVelocity;
	unsigned int maxVelocity;
	unsigned int tempoCount;
	unsigned int beat;
	CCMotionStreak *_myStreak;
	BallPulse *_myPulse;
	bool playDefaultSound;
}

@property (nonatomic,assign)CGPoint myTarget;
@property (nonatomic,assign)CGPoint myVelocity;
@property (nonatomic,assign)CGPoint acceleration;
@property(nonatomic,assign)unsigned int myMax;
@property(nonatomic,assign)unsigned int myTempoCount;
@property(nonatomic,assign)CCMotionStreak *myStreak;
@property(nonatomic, assign)BallPulse *myPulse;

+(id)marbleAtX:(int)x andY:(int)y;
-(void)act;
-(void)setTarget:(CGPoint)t;
-(void)updateAcceleration;
-(void)updateVelocity;
-(void)updateLocation;
-(void)updateSound:(int)count;
-(void)explode;
-(void)resetTempCount;
-(void)toggleSound;
@end
