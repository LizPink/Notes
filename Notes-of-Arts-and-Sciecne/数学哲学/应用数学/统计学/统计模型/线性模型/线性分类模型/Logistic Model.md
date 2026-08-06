# 模型背景
该模型假设数据的生成过程服从一个二项分布，进而通过一个Logistic分布来表示这个二项分布。而Logistic分布是一种类似于正态分布的对称分布，其密度函数相较于正态分布更加厚尾。
$$
	\begin{aligned}
	& p(Y=1 \mid \bm{X})=\frac{1}{1+e^{-(\bm{\beta}^T\bm{X})}} = \sigma(\theta^TX)
	\\
	& p(Y=0 \mid \bm{X})=1-\frac{1}{1+e^{-(\bm{\beta}^T\bm{X})}} = 1-\sigma(\theta^T X)
	\end{aligned}
$$

二元Logistic模型是一个参数模型，参数空间由$\bm{\beta}$生成。
# 模型估计
通常而言我们采用极大似然估计$\text{(Maximum Likelihood Estimation, MLE)}$对该模型的参数进行估计。对于观测样本$(\mathbf{Y}, \mathbf{X})$极大似然估计是要计算最如下优化过程，在参数空间中的估计参数
$$
	\begin{align}
	& \underset{\theta}{\arg\max} \mathbb{P}(\mathbf{Y}_1=\mathbf{y}_1, \cdots, \mathbf{Y}_n=\mathbf{y}_n\mid\mathbf{X};\theta)
	\\
	\iff
	\\
	& \underset{\theta}{\arg\max}\log\mathbb{P}(\mathbf{Y}_1=\mathbf{y}_1, \cdots, \mathbf{Y}_n=\mathbf{y}_n\mid \mathbf{X};\theta)
	\\
	\iff
	\\
	& \underset{\theta}{\arg\max}\frac{1}{n}\log\mathbb{P}(\mathbf{Y}_1=\mathbf{y}_1, \cdots, \mathbf{Y}_n=\mathbf{y}_n\mid \mathbf{X};\theta)
	\end{align}
$$

# 模型推断

# 模型预测

# 模型修正

# 模型总结
