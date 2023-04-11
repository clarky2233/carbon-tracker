import torch
from sklearn.preprocessing import MinMaxScaler, LabelEncoder
from torch.utils.data import Dataset
import pandas as pd


class SensorDataset(Dataset):

    def __init__(self, filename, sensors=None) -> None:
        super().__init__()
        self.filename = filename

        measures = ['mean', 'min', 'max', 'std']
        targets = ['Car', 'Bus', 'Train']

        cols = None
        if sensors is not None:
            cols = [f'{sensor}#{measure}' for sensor in sensors for measure in measures]
            cols.append('target')

        df = pd.read_csv(self.filename, usecols=cols)
        self.data_frame = df[df['target'].isin(targets)].dropna()

        label_encoder = LabelEncoder()
        self.data_frame['target'] = label_encoder.fit_transform(self.data_frame['target'])

        features, labels = self.data_frame.iloc[:, :-1].values, self.data_frame.iloc[:, -1].values

        scaler = MinMaxScaler()
        X = scaler.fit_transform(features)
        y = labels

        self.features = torch.tensor(X, dtype=torch.float32)
        self.targets = torch.tensor(y)

    def __len__(self):
        return len(self.targets)

    def __getitem__(self, index):
        return self.features[index], self.targets[index]
