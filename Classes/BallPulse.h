//
//  BallPulse.h
//  Game
//
//  Created by Laurence Wong on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BallPulse : CCNode {
	
	int freq, curCount;
	float radMod, radius, startRadius, opacMod, curOpac;
	BOOL shouldDraw;
	CGPoint center;
}

/*
@property(nonatomic, assign) int freq;
@property(nonatomic, assign) int radius;
@property(nonatomic, assign) int radMod;
@property(nonatomic, assign) int opacMod;
@property(nonatomic, assign) int curCount;
@property(nonatomic, assign) int curOpaq;
@property(nonatomic, assign) BOOL shouldDraw;
*/
 
+(id)pulseWithFreq:(int)inFreq width:(int)width height:(int)height;
-(id)initPulse:(int)inFreq width:(int)width height:(int)height;
-(void)setFreq:(int)inFreq;
@end
