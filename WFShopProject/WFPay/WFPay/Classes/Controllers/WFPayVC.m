//
//  WFPayVC.m
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import "WFPayVC.h"
#import "ADSRouter.h"
#import "WFHelpers.h"
#import "WFPayment.h"
#import "WFPaymentService.h"
#import "WFPaymentCell.h"
#import "WFUIComponent.h"
#import "WFPaymentHeader.h"
#import "WFPayOrder.h"

@interface WFPayVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) WFPaymentService *paymentService;
@property (nonatomic, strong) NSArray<WFPayment*> *payments;
@property (nonatomic, assign) NSInteger selectedPaymentIdx;
@property (nonatomic, strong) WFPayOrder *payOrder;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@end

@implementation WFPayVC

ADS_REQUEST_MAPPING(WFPayVC, "wfshop://pay")
ADS_PARAMETER_MAPPING(WFPayVC, orderId, "orderId")
ADS_STORYBOARD_IN_BUNDLE("WFPay", "WFPayVC", "WFPay")
ADS_SHOWSTYLE_PRESENT

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _payBtn.backgroundColor = [UIColor wf_mainColor];
    _payBtn.titleLabel.font = [UIFont wf_pfr20];
    self.title = @"选择支付方式";
    
    [self setUpNavi];
}

- (void)setUpNavi {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.paymentService getPayments:^(NSArray<WFPayment *> *payments) {
        weakSelf.payments = payments;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [weakSelf tableView:weakSelf.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _payments.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WFPaymentCell *paymentCell = [tableView dequeueReusableCellWithIdentifier:[WFPaymentCell wf_reuseIdentifier] forIndexPath:indexPath];
    paymentCell.payment = _payments[indexPath.row];
    return paymentCell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WFPaymentHeader *paymentHeader = [WFPaymentHeader new];
    paymentHeader.totalFee = _payOrder ? _payOrder.cost : 0.f;
    return paymentHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    WFPaymentHeader *paymentHeader = [WFPaymentHeader new];
    [paymentHeader setNeedsLayout];
    [paymentHeader layoutIfNeeded];
    CGSize size = [paymentHeader systemLayoutSizeFittingSize:CGSizeMake(_tableView.wf_width, 1.f) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    return size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedPaymentIdx = indexPath.row;
    [_payBtn setTitle:[NSString stringWithFormat:@"%@付款%.2f元", _payments[indexPath.row].name, _payOrder.cost] forState:UIControlStateNormal];
}

- (IBAction)pay:(id)sender {
    NSLog(@"pay channel:%@", _payments[_selectedPaymentIdx].channel);
    [self.paymentService payWithOrder:_payOrder channel:_payments[_selectedPaymentIdx].channel vc:self callback:^{
        
    }];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (WFPaymentService*)paymentService {
    if (!_paymentService) {
        _paymentService = [WFPaymentService new];
    }
    return _paymentService;
}

- (void)setOrderId:(NSString *)orderId {
    _orderId = orderId;
    __weak typeof(self) weakSelf = self;
    [self.paymentService getPayOrderWithOrderId:_orderId callback:^(WFPayOrder *payOrder) {
        weakSelf.payOrder = payOrder;
        [weakSelf.tableView reloadData];
    }];
}


@end
