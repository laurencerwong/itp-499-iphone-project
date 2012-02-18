//
//  HelloWorldLayer.h
//  Game
//
//  Created by Clark Barry on 10/20/11.
//  Copyright University of Southern California 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
@class MarbleController;
// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
	MarbleController *myController;
	CFAbsoluteTime time;
	CGPoint flickOrigin;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
