//
//  DeclinedTransactionViewController.m
//  MyEtherWallet-iOS
//
//  Created by Mikhail Nikanorov on 28/04/2018.
//  Copyright © 2018 MyEtherWallet, Inc. All rights reserved.
//

#import "DeclinedTransactionViewController.h"

#import "DeclinedTransactionViewOutput.h"

#import "LinkedLabel.h"

#import "UIColor+Application.h"

@interface DeclinedTransactionViewController () <LinkedLabelDelegate>
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet LinkedLabel *descriptionLabel;
@end

@implementation DeclinedTransactionViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - DeclinedTransactionViewInput

- (void) setupInitialState {
  { //Title label
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 0.0;
    style.maximumLineHeight = 40.0;
    style.minimumLineHeight = 40.0;
    NSDictionary *attributes = @{NSFontAttributeName: self.titleLabel.font,
                                 NSForegroundColorAttributeName: self.titleLabel.textColor,
                                 NSParagraphStyleAttributeName: style,
                                 NSKernAttributeName: @(-0.3)};
    self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:attributes];
  }
  { //Description
    NSString *text = NSLocalizedString(@"You declined the transaction and it was cancelled. If you have security concerns, please contact MEW Support", nil);
    NSArray <NSString *> *linkedParts = [NSLocalizedString(@"MEW Support", nil) componentsSeparatedByString:@"|"];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5.0;
    NSDictionary *attributes = @{NSFontAttributeName: self.descriptionLabel.font,
                                 NSForegroundColorAttributeName: self.descriptionLabel.textColor,
                                 NSParagraphStyleAttributeName: style,
                                 NSKernAttributeName: @(-0.01)};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    for (NSString *part in linkedParts) {
      NSRange range = [attributedString.string rangeOfString:part];
      if (range.location != NSNotFound && range.length > 0) {
        NSDictionary *linkAttributes = @{NSUnderlineColorAttributeName: [UIColor clearColor],
                                         NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone),
                                         NSLinkAttributeName: [NSURL URLWithString:@"http://dummy.url"],
                                         NSForegroundColorAttributeName: [UIColor mainApplicationColor]};
        [attributedString addAttributes:linkAttributes range:range];
      }
    }
    
    self.descriptionLabel.attributedText = attributedString;
  }
}

#pragma mark - IBActions

- (IBAction) closeAction:(id)sender {
  [self.output closeAction];
}

#pragma mark - LinkedLabelDelegate

- (void)linkedLabel:(LinkedLabel *)label didSelectURL:(NSURL *)url {
  
}

@end
