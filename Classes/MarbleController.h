//
//  MarbleController.h
//  Game
//
//  Created by ITP Student on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CCNode;

@interface MarbleController : NSObject {
	NSMutableArray *myMarbles;
	NSMutableArray *marblesToMove;
	unsigned int clockCount;
}


-(id)initWithX:(int)x andY:(int)y;
-(void)addMarbleAtX:(int)x andY:(int)y toLayer:(CCNode *)layer;
-(void)isMarbleInRangeForToggle:(CGPoint)p;
-(void)update;
-(void)setTarget:(CGPoint)t;
-(void)pickMarblesToMove:(CGPoint)p;
-(void)movementFinished;
-(double)distanceBetweenPoint:(CGPoint)point1 and:(CGPoint)point2;
@end
