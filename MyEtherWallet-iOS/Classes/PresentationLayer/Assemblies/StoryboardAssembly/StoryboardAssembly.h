//
//  StoryboardAssembly.h
//  MyEtherWallet-iOS
//
//  Created by Mikhail Nikanorov on 15/04/2018.
//  Copyright © 2018 MyEtherWallet, Inc. All rights reserved.
//

@import Typhoon;
@import RamblerTyphoonUtils.AssemblyCollector;

@class SystemInfrastructureAssembly;

@interface StoryboardAssembly : TyphoonAssembly <RamblerInitialAssembly>
@property (nonatomic, strong, readonly) SystemInfrastructureAssembly *systemInfrastructureAssembly;
- (UIStoryboard *)mainStoryboard;
- (UIStoryboard *)splashPasswordStoryboard;
- (UIStoryboard *)walletStoryboard;
@end
