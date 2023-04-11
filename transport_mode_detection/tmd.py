from torch import nn
import torch.nn.functional as f


class TMD(nn.Module):
    def __init__(self, input_dim=None, output_dim=None):
        super(TMD, self).__init__()
        self.input_dim = input_dim
        self.output_dim = output_dim
        self.lin_relu = nn.Sequential(
            nn.Linear(self.input_dim, 300),
            nn.ReLU(),
            nn.Linear(300, 100),
            nn.ReLU(),
            nn.Dropout(),
            nn.Linear(100, output_dim)
        )

    def forward(self, x):
        x = self.lin_relu(x)
        return x
