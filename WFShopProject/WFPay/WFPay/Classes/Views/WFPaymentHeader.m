//
//  WFPaymentHeader.m
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import "WFPaymentHeader.h"
#import "Masonry.h"
#import "WFUIComponent.h"

@interface WFPaymentHeader ()

@property (nonatomic, strong) UILabel *hint;
@property (nonatomic, strong) UILabel *feeLabel;

@end

@implementation WFPaymentHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor wf_mainBackgroundColor];
    
    _hint = [UILabel new];
    _hint.font = [UIFont wf_pfr18];
    _hint.text = @"需支付:";
    [self addSubview:_hint];
    
    _feeLabel = [UILabel new];
    _feeLabel.font = [UIFont wf_pfr16];
    _feeLabel.textColor = [UIColor wf_redColor];
    [self addSubview:_feeLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(16);
        make.bottom.equalTo(self).offset(-16);
    }];
    [_feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_hint.mas_centerY);
        make.left.equalTo(_hint.mas_right);
    }];
}

- (void)setTotalFee:(CGFloat)totalFee {
    _totalFee = totalFee;
    _feeLabel.text = [NSString stringWithFormat:@"%.2f元", _totalFee];
}

@end
