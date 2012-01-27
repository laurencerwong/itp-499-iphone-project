//
//  Marble.m
//  Game
//
//  Created by ITP Student on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Marble.h"
#import "CocosDenshion.h"
#import "SimpleAudioEngine.h"
@implementation Marble

@synthesize myVelocity = _myVelocity;
@synthesize acceleration = _myAcceleration;
@synthesize myTarget = _myTarget;
@synthesize myMax = maxVelocity;
@synthesize myTempoCount = tempoCount;
@synthesize myStreak = _myStreak;
@synthesize myPulse = _myPulse;

+(id)marbleAtX:(int) x andY:(int)y{
	Marble *m = nil;
	if((m = [[[super alloc]initWithFile:@"ball.png"]autorelease])){
		m.myPulse = [BallPulse pulseWithFreq:40 width:50 height:50];
		m.position = ccp(x,y);
		[m setTarget:ccp(x,y)];
		m.myVelocity = ccp(0,0);
		m.acceleration = ccp(0,0);
		m.myMax = arc4random() % 30 + 20;
		m.myTempoCount = 0;
		m.myStreak = [CCMotionStreak streakWithFade:3 minSeg:3 image:@"ball.png" width:16 length:32 color:ccc4(255,255,255,255)];
		[m addChild:m.myStreak z:1];
		[m addChild:m.myPulse z:2];
	}
	return m;
}



-(void)setTarget:(CGPoint)t{
	_myTarget = t;
	int width = [[CCDirector sharedDirector] winSize].width;
	int section = width / 8;
	int count = 0;
	beat = 0;
	while(self.myTarget.x > count*section){
		beat += 20;
		count+= 1;
	}
	[_myPulse setFreq:beat];
}

-(void)act{
	[self updateAcceleration];
	[self updateVelocity];
	[self updateLocation];
	//[self updateSound];
}


-(void)explode{
	double xdistance = self.myTarget.x - self.position.x;
	double ydistance = self.myTarget.y - self.position.y;
	double xdistancesqr = pow(xdistance,2);
	double ydistancesqr = pow(ydistance,2);
	double distance = sqrt(xdistancesqr + ydistancesqr);
	int force = 100;
	self.myVelocity = ccpAdd(self.myVelocity,ccp(-force*xdistance/distance,-force*ydistance/distance));
	
}

-(void)explodeMusic:(int)force{
	double xdistance = self.myTarget.x - self.position.x;
	double ydistance = self.myTarget.y - self.position.y;
	if(abs((int)xdistance < 50) && abs((int)ydistance < 50)){
		if(xdistance < 0)
			xdistance = -90;
		else
			xdistance = 90;
		if(ydistance < 0)
			ydistance = -90;
		else
			ydistance = 90;
	}
	double xdistancesqr = pow(xdistance,2);
	double ydistancesqr = pow(ydistance,2);
	double distance = sqrt(xdistancesqr + ydistancesqr);
	self.myVelocity = ccpAdd(self.myVelocity,ccp(-force*xdistance/distance,-force*ydistance/distance));
}

-(void)updateAcceleration{
	double xdistance = self.myTarget.x - self.position.x;
	double ydistance = self.myTarget.y - self.position.y;
	double xdistancesqr = pow(xdistance,2);
	double ydistancesqr = pow(ydistance,2);
	double distance = sqrt(xdistancesqr + ydistancesqr);
	if(distance != 0){
		self.acceleration = ccp(3*xdistance/(distance),3*ydistance/(distance));
	}
}

-(void)updateVelocity{
	self.myVelocity =ccpAdd(self.myVelocity, self.acceleration);
	self.myVelocity = ccpSub(self.myVelocity, ccp(self.myVelocity.x/20,self.myVelocity.y/20));
}


-(void)updateLocation{
	self.position = ccpAdd(self.position,self.myVelocity);
	[self.myStreak setPosition:ccpAdd(CGPointZero,ccp(15.5,15.5))];
	[self.myStreak update:.1];
	if(abs(self.myTarget.x - self.position.x) < 10 && abs(self.myTarget.y - self.position.y) < 10){
		self.myTarget = self.position;
		self.myVelocity = CGPointZero;
		self.acceleration = CGPointZero;
	}
}	
-(void)updateSound:(int)count{
	if(count % beat == 0){
		float pitchAdjust = self.position.y/[[CCDirector sharedDirector] winSize].height;
		NSString *whichSound;
		if(playDefaultSound){
			whichSound = [NSString stringWithString:@"Asquare.wav"];
		}else{
			whichSound = [NSString stringWithString:@"snare.wav"];
		}	
		[[SimpleAudioEngine sharedEngine] playEffect:whichSound pitch:2*pitchAdjust pan:0.0f gain:1.0f];
	}
	NSLog(@"count = %d",count);
	NSLog(@"beat = %d",beat);

}

-(void)resetTempCount{
	tempoCount = 0;
}

-(void)toggleSound{
	playDefaultSound = !playDefaultSound;
}

@end
