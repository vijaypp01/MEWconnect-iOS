//
//  NSString+HexNSDecimalNumber.h
//  MyEtherWallet-iOS
//
//  Created by Mikhail Nikanorov on 04/05/2018.
//  Copyright © 2018 MyEtherWallet, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HexNSDecimalNumber)
- (NSDecimalNumber *) decimalNumberFromHexRepresentation;
@end
