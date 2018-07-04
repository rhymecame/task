//
//  WFPaymentCell.m
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import "WFPaymentCell.h"
#import "WFUIComponent.h"
#import "UIImageView+WebCache.h"
#import "WFPayment.h"

@interface WFPaymentCell ()

@property (weak, nonatomic) IBOutlet UILabel *paymentName;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIImageView *radio;
@property (weak, nonatomic) IBOutlet UIImageView *paymentIcon;

@end

@implementation WFPaymentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI {
    _paymentName.font = [UIFont wf_pfr14];
    _subTitle.font = [UIFont wf_pfr12];
    _subTitle.textColor = [UIColor wf_lightGrayColor];
    _radio.tintColor = [UIColor wf_mainColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        UIImage *radioImg = [[UIImage imageNamed:@"round-check-fill" inBundle:WFGetBundle(@"WFPay") compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_radio setImage:radioImg];
    } else {
        [_radio setImage:[UIImage imageNamed:@"radio" inBundle:WFGetBundle(@"WFPay") compatibleWithTraitCollection:nil]];
    }
}

- (void)setPayment:(WFPayment *)payment {
    _payment = payment;
    [_paymentIcon sd_setImageWithURL:[NSURL URLWithString:_payment.icon]];
    _paymentName.text = payment.name;
    _subTitle.text = payment.subTitle;
}

@end
