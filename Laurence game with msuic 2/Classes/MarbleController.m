//
//  MarbleController.m
//  Game
//
//  Created by ITP Student on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MarbleController.h"
#import "Marble.h"
#import "CCNode.h"
#import "musicPlayer.h"
#import "SimpleAudioEngine.h"

@implementation MarbleController


-(id)initWithX:(int)x andY:(int)y{
	myMarbles = [[NSMutableArray alloc]initWithCapacity:10];
	marblesToMove = [[NSMutableArray alloc]initWithCapacity:10];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"bump.wav"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"snare.wav"];
	for(int i=0;i<0;i++){
		[myMarbles addObject:[Marble marbleAtX:x/2 andY:y/2]];
	}
	clockCount =0;
	return self;
}



-(void)update{
	if(clockCount > 1000000){
		clockCount = 0;
	}
	else{
		clockCount++;
	}
	for(Marble *m in myMarbles){
		[m act];
		[m updateSound:clockCount];
	}
}

-(void)pickMarblesToMove:(CGPoint)p{
	[marblesToMove removeAllObjects];
	for(Marble *m in myMarbles){
		if([self distanceBetweenPoint:p and: m.position] < 40){
			[marblesToMove addObject:m];
		} 
	}
}

-(void)isMarbleInRangeForToggle:(CGPoint)p{
	for(Marble *m in myMarbles){
		if([self distanceBetweenPoint:p and:m.position] < 20){
			[m toggleSound];
		}
	}
}


-(void)setTarget:(CGPoint)p{
	for(Marble *m in marblesToMove){
		[m setTarget:p];

	}
}

-(void)movementFinished{
	for(Marble *m in myMarbles){
		[m resetTempCount];
	}
}

-(void)addMarbleAtX: (int)x andY:(int)y toLayer:(CCNode *)layer{
	for(Marble *m in myMarbles){
		if([self distanceBetweenPoint:m.position and:ccp(x,y)] < 25){
			return;
		}
	}
	[myMarbles addObject:[Marble marbleAtX:x andY:y]];
	[layer addChild:[myMarbles lastObject]];
	[self movementFinished];
}

-(double)distanceBetweenPoint:(CGPoint)point1 and:(CGPoint) point2{
	double dx = point2.x - point1.x;
	double dy = point2.y - point1.y;
	return sqrt(dx*dx + dy*dy );
}

-(void)dealloc{
	[myMarbles release];
	[marblesToMove release];
	[super dealloc];
}
@end
