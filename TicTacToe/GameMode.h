//
//  GameMode.h
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/8/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameModeInterface.h"

@interface GameMode : NSObject <GameModeInterface>

- (nonnull id)initWithPlayer1:(nonnull Player *)player1 andPlayer2:(nonnull Player *)player2;
- (nullable Player *)turn;

@end
