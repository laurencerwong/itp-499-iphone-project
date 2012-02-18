//
//  BallPulse.m
//  Game
//
//  Created by Laurence Wong on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BallPulse.h"

//max radius = 50

@implementation BallPulse

-(id)initPulse:(int)inFreq width:(int)width height:(int)height{
	if( (self = [super init])){
		center = ccp((int)width/2, (int)height/2);
		freq = inFreq;
		radius = width/2*1.0;
		startRadius = radius;
		curOpac = 255.0f;
		opacMod = 255.0/((float)freq * 2);
		radMod = radius/(float)freq;
		curCount = 0;
		shouldDraw = NO;
		[self schedule:@selector(update:) interval:0];
	}
	return self;

}

+(id)pulseWithFreq:(int)inFreq width:(int)width height:(int)height{
	return [[[self alloc] initPulse:inFreq width:width height:height]autorelease];
}

-(void)setFreq:(int)inFreq{
	shouldDraw = NO;
	radius = startRadius;
	freq = inFreq;
	curOpac = 255.0f;
	opacMod = 255.0/((float)freq * 2);
	radMod = radius/(float)freq;
	curCount = 0;
}

-(void)update:(ccTime)delta{
	if(curCount == freq){
		curCount = 0;
		shouldDraw = YES;
	}
	else{
		curCount++;
	}
}

-(void)draw{
	if(radius <= 75.0f && shouldDraw){
		radius += radMod;
		glLineWidth(3); 
		glColor4ub(curOpac,curOpac,curOpac,curOpac);
		ccDrawCircle(center, radius, 0, 30, NO);
		curOpac -= opacMod;
	}
	else{
		shouldDraw = NO;
		radius = radMod * freq;
		curOpac = 255.0f;
	}
}

@end
