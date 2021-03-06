//
//  HomeInteractorInput.h
//  MyEtherWallet-iOS
//
//  Created by Mikhail Nikanorov on 28/04/2018.
//  Copyright © 2018 MyEtherWallet, Inc. All rights reserved.
//

@import Foundation;

@class MEWConnectResponse;
@class TokenPlainObject;

@protocol HomeInteractorInput <NSObject>
- (void) configurateWithAddress:(NSString *)address;
- (NSString *) obtainAddress;
- (NSUInteger) obtainNumberOfTokens;
- (BOOL) obtainBackupStatus;
- (void) subscribe;
- (void) unsubscribe;
- (void) searchTokensWithTerm:(NSString *)term;
- (void) disconnect;
- (BOOL) isConnected;
- (TokenPlainObject *) obtainEthereum;
@end
