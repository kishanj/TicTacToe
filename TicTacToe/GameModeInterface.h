//
//  GameModeInterface.h
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/9/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "GameBoard.h"

@protocol GameModeInterface <NSObject>

- (NSUInteger)bestMoveForPlayer:(nonnull Player *)player onGameBoard:(nonnull GameBoard *)board;

@end
