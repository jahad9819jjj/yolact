```
torch.__version__
1.13.1+cu116
```

このバージョンの`torch`ではDataLoaderに違いがあるのか、下記のコードでエラーを吐く
```
# Forward Pass + Compute loss at the same time (see CustomDataParallel and NetLoss)
# TODO:NetLossで3つの引数が必要だが実際は提供されていなくエラーを吐く
# len(datum)=2となっており, 3つの引数を提供するためにはどうすれば良いのか
# images, targets = datum?
losses = net(datum)
```
具体的には`forward`の引数が足りなかった
```
class NetLoss(nn.Module):
    """
    A wrapper for running the network and computing the loss
    This is so we can more efficiently use DataParallel.
    networkを実行して損失関数を計算するためのラッパー
    DataParallelをより効率的に使用できるようにするため
    """
    
    def __init__(self, net:Yolact, criterion:MultiBoxLoss):
        super().__init__()

        self.net = net
        self.criterion = criterion
    
    def forward(self, images, targets, masks, num_crowds):
        preds = self.net(images)
        losses = self.criterion(self.net, preds, targets, masks, num_crowds)
        return losses
```

