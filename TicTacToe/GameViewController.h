//
//  GameViewController.h
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/3/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@class Game;

@interface GameViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic, nullable) Game *game;

- (void)resetGame;
- (void)resetStats;
- (void)assignTile:(NSUInteger)tag toPlayer:(nullable Player *)player;
- (void)assignTurn:(nullable Player *)command;
- (void)assignWinner:(nullable Player *)winner;

@end

