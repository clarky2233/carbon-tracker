import pandas as pd
import numpy as np
import torch
from pandas import DataFrame
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split, StratifiedKFold, cross_val_score, GridSearchCV
from sklearn.neural_network import MLPClassifier
from sklearn.preprocessing import MinMaxScaler, StandardScaler, LabelEncoder
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from torch import nn
from torch.utils.data import DataLoader, SubsetRandomSampler, Subset
from torch.utils.mobile_optimizer import optimize_for_mobile

from dataset import SensorDataset
from tmd import TMD

from sklite import LazyExport


def load_dataset(filename: str, sensors: list[str]):
    measures = ['mean', 'min', 'max', 'std']
    targets = ['Bus', 'Car', 'Train']

    cols = [f'{sensor}#{measure}' for sensor in sensors for measure in measures]
    cols.append('target')

    dataset = pd.read_csv(filename, usecols=cols)
    dataset = dataset[dataset['target'].isin(targets)].dropna()

    label_encoder = LabelEncoder()
    dataset['target'] = label_encoder.fit_transform(dataset['target'])

    return dataset


def preprocessing(dataset: DataFrame):
    features, labels = dataset.iloc[:, :-1], dataset.iloc[:, -1]
    X_train, X_test, y_train, y_test = train_test_split(features, labels, stratify=labels)

    # scaler = MinMaxScaler()
    # scaler.fit(X_train)
    # X_train_norm = scaler.transform(X_train)
    # X_test_norm = scaler.transform(X_test)

    return X_train, X_test, y_train, y_test


def svm_classifier(train_features, test_features, train_labels, test_labels):
    svm = SVC(kernel="rbf")
    svm.fit(train_features, train_labels)
    accuracy = svm.score(test_features, test_labels)
    print(accuracy)


def rf_classifier(train_features, test_features, train_labels, test_labels):
    n_estimators = [10, 30, 60, 100, 150]
    max_leaf_nodes = [6, 12, 18]
    param_grid = {'n_estimators': n_estimators, 'max_leaf_nodes': max_leaf_nodes}

    x = {'bootstrap': [True, False],
         'max_depth': [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, None],
         'max_features': ['log2', 'sqrt'],
         'min_samples_leaf': [1, 2, 4],
         'min_samples_split': [2, 5, 10],
         'n_estimators': [200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000]
         }

    cvKFold = StratifiedKFold(n_splits=10, shuffle=True)

    rf = RandomForestClassifier()

    grid_search = GridSearchCV(rf, x, cv=cvKFold, return_train_score=True)
    grid_search.fit(train_features, train_labels)

    print(grid_search.best_params_, grid_search.best_score_, grid_search.score(test_features, test_labels))


def rf_std(train_features, test_features, train_labels, test_labels):
    rf = RandomForestClassifier(bootstrap=False, n_estimators=200)
    rf.fit(train_features, train_labels)
    print(rf.score(test_features, test_labels))
    return rf


def mlp_classifier(train_features, test_features, train_labels, test_labels):
    mlp = MLPClassifier(hidden_layer_sizes=(500,), max_iter=1000)
    mlp.fit(train_features, train_labels)
    print(mlp.score(test_features, test_labels))


def knn(train_features, test_features, train_labels, test_labels):
    mlp = KNeighborsClassifier()
    mlp.fit(train_features, train_labels)
    print(mlp.score(test_features, test_labels))


def main():
    sensors = ['android.sensor.accelerometer', 'android.sensor.gyroscope', 'android.sensor.magnetic_field']
    sensors = ['android.sensor.accelerometer', 'android.sensor.magnetic_field']
    dataset = load_dataset('datasets/dataset_5SecondWindow.csv', sensors=sensors)
    train_features, test_features, train_labels, test_labels = preprocessing(dataset)
    clf = rf_std(train_features, test_features, train_labels, test_labels)

    lazy = LazyExport(clf)
    lazy.save('checkpoints/tmd_rf_acc_mag.json', force_override=True)



    # dataset = SensorDataset(filename='datasets/dataset_5secondWindow.csv', sensors=sensors)
    #
    # train_indices, test_indices, _, _ = train_test_split(
    #     range(len(dataset)),
    #     dataset.targets,
    #     stratify=dataset.targets,
    # )
    #
    # train_split = Subset(dataset, train_indices)
    # test_split = Subset(dataset, test_indices)
    #
    # batch_size = 64
    # epochs = 10
    # lr = 0.001
    #
    # train_loader = DataLoader(train_split, batch_size=batch_size, shuffle=True)
    # test_loader = DataLoader(test_split, batch_size=batch_size)
    #
    # model = TMD(input_dim=len(sensors) * 4, output_dim=3)
    # loss_fn = nn.CrossEntropyLoss()
    # optimizer = torch.optim.Adam(model.parameters(), lr=lr)
    #
    # model.train()
    # for epoch in range(epochs):
    #     for batch, (images, labels) in enumerate(train_loader):
    #         # forward pass
    #         output = model(images)
    #
    #         # loss
    #         loss = loss_fn(output, labels)
    #
    #         # zero gradients
    #         optimizer.zero_grad()
    #
    #         # gradient
    #         loss.backward()
    #
    #         # update weights
    #         optimizer.step()
    #     if epoch % 10 == 0:
    #         print(f'Epochs [{epoch + 1}/{epochs}], Losses: {loss.item():.4f}')
    #
    # print("=======\nTESTING\n=======")
    # model.eval()
    # with torch.no_grad():
    #     correct = 0
    #     total = 0
    #     for features, labels in test_loader:
    #         print(features.shape)
    #         output = model(features)
    #         correct += torch.sum(torch.argmax(output, dim=1) == labels)
    #         total += labels.shape[0]
    #     accuracy = correct / total * 100
    #     print(f'Accuracy of the model  {accuracy:.2f}%')
    #
    # example = torch.rand(1, len(sensors) * 4)
    # traced_script_module = torch.jit.trace(model, example)
    # traced_script_module_optimized = optimize_for_mobile(traced_script_module)
    # traced_script_module_optimized._save_for_lite_interpreter('checkpoints/tmd_classifier2.pt')


if __name__ == '__main__':
    main()
