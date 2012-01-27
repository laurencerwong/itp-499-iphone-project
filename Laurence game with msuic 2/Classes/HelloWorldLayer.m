//
//  HelloWorldLayer.m
//  Game
//
//  Created by Clark Barry on 10/20/11.
//  Copyright University of Southern California 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "MarbleController.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) {
		self.isTouchEnabled = YES;
		[[CCDirector sharedDirector]setDisplayFPS:YES];
		CGSize size = [[CCDirector sharedDirector] winSize];
		myController = [[MarbleController alloc] initWithX:(int)size.width andY:(int)size.height];
		[self schedule:@selector(gameLogic:) interval:(.01)];
	}
	return self;
}

-(void)gameLogic:(ccTime)dt{
	[myController update];
}


-(void) registerWithTouchDispatcher{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
	CGPoint location = [touch locationInView: [touch view]];
	location = [[CCDirector sharedDirector]convertToGL:location];
	[myController pickMarblesToMove:location];
    return TRUE;    
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{  
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	[myController setTarget:location];
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
		if (touch.tapCount == 2) {
			[myController isMarbleInRangeForToggle:location];
			[myController addMarbleAtX:location.x andY:location.y toLayer:self];
		}else{
			[myController setTarget:location];
			[myController movementFinished];
		}
	
	
	
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc{
	[myController release];
	[super dealloc];
}
@end
