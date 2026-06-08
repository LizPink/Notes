这一章我们介绍度量模型中的第一个分类器-KNN分类器。无论是KNN回归器还是KNN分类器，其核心思想都是KNN算法：根据新样本与训练样本之间的距离来判断样本的标签取值，接下来我们就进入KNN分类器的学习。本章我们会频繁使用sklearn.neighbors中的接口。
# 模型设定
从模型设定上可以看出，度量类模型非常依赖特征数据的缩放，因为其算法需要依赖样本之间度量距离。而与预测无关的特征单位会影响特征在距离计算中的作用，进而影响特征在预测中的重要性。


# 模型训练
```python
# neighbors.KNerighborsClassifier
model = neighbors.KNeighborsClassifier(
	n_neighbors = 5			# n_neighbors: int
	weights = "uniform"		# weights: ["uniform", "distance"]
)
```

```python
# neighbors.KNeighborsRegressor(
	n_neighbors = 5			# n_neighbors: int
	weights = "uniform"		# weights: ["uniform", "distance"]
)
```
# 模型评价