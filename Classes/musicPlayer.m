//
//  musicPlayer.m
//  Game
//
//  Created by Laurence Wong on 11/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "musicPlayer.h"


@implementation musicPlayer

int const THRESHOLD = 5000;
int const THRESHBUF_HIGH = 20;
int const THRESHBUF_LOW = 3;

-(id)initAudioPlayer{
	MPMusicPlayerController *mplayer = [MPMusicPlayerController applicationMusicPlayer];
	
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/01.mp3", [[NSBundle mainBundle] resourcePath]]];
	NSError *error;
	player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	player.numberOfLoops = 0;
	
	lastDec = 0;
	threshold = THRESHOLD;
	threshbuf = 0;
	threshmod = 300;
	threshmodbuf = 0;
	
	if(player == nil)
		NSLog(@"PLAYER BE NIL");
	else {
		[player play];
	}
	[player setMeteringEnabled:YES];
	return self;
}

-(void)update{
	[player updateMeters];
}

-(int)curLevel{
	float level = [player peakPowerForChannel:0];
	/*	float linear = pow (10, level / 20);
	int curL;
	if(linear < 0.2 && linear != 0.0)
		curL = linear * 20 + 5;
	else
		curL = linear * 20;
*/
	int inlevel = (int)((level + 160.0) * 1000);
	if(threshmodbuf > 10){
		threshmod -= 50;
		threshmodbuf = 0;
		NSLog(@"decreasing threshmodbuf");
	}
	if(abs(inlevel - lastDec) >= threshold){
		/*if(threshmodbuf < 2){
			threshmod += 50;
			threshmodbuf = 0;
			NSLog(@"increasing threshmodbuf");
		}*/
		if(threshbuf <= THRESHBUF_LOW){
			threshmodbuf++;
			threshold += threshmod;
			threshbuf++;
			lastDec = inlevel;
			NSLog(@"increasing threshold");
			return 0;
		}
		else{
			threshbuf = 0;
			threshmodbuf = 0;
		}
		lastDec = inlevel;
		NSLog(@"%d", inlevel/1000 - 50);
		if(((inlevel / 1000) - 50) > 80)
			return 80;
		else{
			return ((inlevel / 1000) - 50);
		}
	}
	else{
		threshbuf++;
		lastDec = inlevel;
		if(threshbuf >= THRESHBUF_HIGH){
			threshmodbuf++;
			threshbuf = 0;
			threshold-= threshmod;
			NSLog(@"decreasing threshold");
		}
		return 0;
	}
}

@end
