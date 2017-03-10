//
//  GameBoard.h
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/8/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface GameBoard : NSObject

@property (nonatomic, strong, nonnull) NSMutableArray<Player *> *tiles;
@property (nonatomic, strong, nullable) NSMutableArray *moves;

+ (NSUInteger)tilesOnBoard;

- (nonnull id)initGameWithPlayerNone:(nonnull Player *)playerNone andPlayer1:(nonnull Player *)player1 andPlayer2:(nonnull Player *)player2;
- (BOOL)makeMoveByPlayer:(nonnull Player *)player move:(NSUInteger)pos;
- (BOOL)isGameOver;
- (nullable Player *)whoWonGame;

@end
