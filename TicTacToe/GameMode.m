//
//  GameMode.m
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/8/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import "GameMode.h"

@interface GameMode()

@property (nonatomic, strong, nonnull) Player *player1;
@property (nonatomic, strong, nonnull) Player *player2;

@end

@implementation GameMode

- (nonnull id)initWithPlayer1:(nonnull Player *)player1 andPlayer2:(nonnull Player *)player2 {
    if (self = [super init]) {
        _player1 = player1;
        _player2 = player2;
    }
    
    return self;
}

- (nullable Player *)turn {
    if ([self coinToss]) {
        return _player1;
    }
    else {
        return _player2;
    }
}

- (BOOL)coinToss
{
    return arc4random() % 2;
}

- (NSUInteger)bestMoveForPlayer:(nonnull Player *)player onGameBoard:(nonnull GameBoard *)board {
    return NSUIntegerMax;
}

@end
