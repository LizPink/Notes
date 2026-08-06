在机器学习中基于统计模型[[Logistic Model]]构建的机器模型在分类问题中具有重要应用。
# 模型训练
对于二分类样本数据$(\mathbf{X}, \mathbf{Y})$模型优化目标如下
$$
	\begin{align}
	\underset{\theta}{\arg\max}\frac{1}{n}\log\mathbb{P}(\mathbf{Y}_1=\mathbf{y}_1, \cdots, \mathbf{Y}_n=\mathbf{y}_n\mid \mathbf{X};\theta)
	\end{align}
$$
模型的损失函数如下
$$
	\begin{aligned}
	\text{Loss}(\theta):=&-\frac{1}{N}\sum_{i=1}^N[y_i\log\sigma(\theta^Tx_i) + (1-y_i)\log(1-\sigma(\theta^Tx_i))] + \frac{\lambda}{2}||\theta||_2^2
	\\
	=&-\frac{1}{N}\big[y^T\log\sigma(X\theta)+(\bm{1}-y)^T\log(\bm{1}-\sigma({X\theta}))\big] + \frac{\lambda}{2}||\theta||^2_2
	\end{aligned} \tag{1}
$$
模型的损失梯度如下
$$
	\nabla_{\theta}\text{Loss}=-X^T(y-\sigma(X\theta)) + \lambda\theta
$$
模型的迭代过程如下
$$
	\theta \leftarrow \theta-\eta(\nabla_\theta\text{Loss})^T
$$
## 模型推导
已知损失函数为：

$$
L(\boldsymbol\theta)
=
-\frac{1}{N}
\left[
\mathbf y^T\log\mathbf p
+
(\mathbf 1-\mathbf y)^T\log(\mathbf 1-\mathbf p)
\right]
+
\frac{\lambda}{2}\|\boldsymbol\theta\|_2^2,
$$

其中：

$$
\mathbf p=\sigma(X\boldsymbol\theta).
$$

将损失函数拆成三项：

$$
L(\boldsymbol\theta)
=
\frac{1}{N}
\left[
L_1(\boldsymbol\theta)+L_2(\boldsymbol\theta)
\right]
+
L_3(\boldsymbol\theta),
$$

其中：

$$
L_1(\boldsymbol\theta)
=
-\mathbf y^T\log\sigma(X\boldsymbol\theta),
$$

$$
L_2(\boldsymbol\theta)
=
-(\mathbf 1-\mathbf y)^T
\log\left(\mathbf 1-\sigma(X\boldsymbol\theta)\right),
$$

$$
L_3(\boldsymbol\theta)
=
\frac{\lambda}{2}\|\boldsymbol\theta\|_2^2.
$$

---

### 1. 第一项求导

令：

$$
\mathbf f_1(\boldsymbol\theta)
=
\log\sigma(X\boldsymbol\theta).
$$

则：

$$
L_1(\boldsymbol\theta)
=
-\mathbf y^T\mathbf f_1(\boldsymbol\theta).
$$

因此：

$$
\nabla_{\boldsymbol\theta}L_1
=
-
J_{\mathbf f_1}(\boldsymbol\theta)^T\mathbf y.
$$

根据链式法则：

$$
J_{\mathbf f_1}(\boldsymbol\theta)
=
\frac{\partial\log\sigma(\mathbf z)}{\partial\mathbf z}
\frac{\partial\mathbf z}{\partial\boldsymbol\theta},
\qquad
\mathbf z=X\boldsymbol\theta.
$$

因为：

$$
\frac{\partial\mathbf z}{\partial\boldsymbol\theta}=X,
$$

并且：

$$
\frac{d}{dz}\log\sigma(z)
=
\frac{\sigma'(z)}{\sigma(z)}
=
1-\sigma(z),
$$

所以：

$$
\frac{\partial\log\sigma(\mathbf z)}{\partial\mathbf z}
=
\operatorname{diag}
\left(
\mathbf 1-\sigma(\mathbf z)
\right).
$$

因此：

$$
J_{\mathbf f_1}(\boldsymbol\theta)
=
\operatorname{diag}
\left(
\mathbf 1-\sigma(X\boldsymbol\theta)
\right)X.
$$

代回：

$$
\begin{aligned}
\nabla_{\boldsymbol\theta}L_1
&=
-
\left[
\operatorname{diag}
\left(
\mathbf 1-\sigma(X\boldsymbol\theta)
\right)X
\right]^T
\mathbf y
\\
&=
-
X^T
\operatorname{diag}
\left(
\mathbf 1-\mathbf p
\right)\mathbf y
\\
&=
-
X^T
\left[
\mathbf y\odot(\mathbf 1-\mathbf p)
\right].
\end{aligned}
$$

即：

$$
\boxed{
\nabla_{\boldsymbol\theta}L_1
=
-
X^T
\left[
\mathbf y\odot(\mathbf 1-\mathbf p)
\right]
}
$$

---

### 2. 第二项求导

令：

$$
\mathbf f_2(\boldsymbol\theta)
=
\log\left(
\mathbf 1-\sigma(X\boldsymbol\theta)
\right).
$$

则：

$$
L_2(\boldsymbol\theta)
=
-(\mathbf 1-\mathbf y)^T
\mathbf f_2(\boldsymbol\theta).
$$

因此：

$$
\nabla_{\boldsymbol\theta}L_2
=
-
J_{\mathbf f_2}(\boldsymbol\theta)^T
(\mathbf 1-\mathbf y).
$$

根据链式法则：

$$
J_{\mathbf f_2}(\boldsymbol\theta)
=
\frac{
\partial\log\left(\mathbf 1-\sigma(\mathbf z)\right)
}{
\partial\mathbf z
}
\frac{\partial\mathbf z}{\partial\boldsymbol\theta}.
$$

对于标量函数：

$$
\begin{aligned}
\frac{d}{dz}\log(1-\sigma(z))
&=
-\frac{\sigma'(z)}{1-\sigma(z)}
\\
&=
-\frac{\sigma(z)(1-\sigma(z))}
{1-\sigma(z)}
\\
&=
-\sigma(z).
\end{aligned}
$$

因此：

$$
\frac{
\partial\log\left(\mathbf 1-\sigma(\mathbf z)\right)
}{
\partial\mathbf z
}
=
-\operatorname{diag}\left(\sigma(\mathbf z)\right).
$$

所以：

$$
J_{\mathbf f_2}(\boldsymbol\theta)
=
-\operatorname{diag}
\left(
\sigma(X\boldsymbol\theta)
\right)X.
$$

代回：

$$
\begin{aligned}
\nabla_{\boldsymbol\theta}L_2
&=
-
\left[
-\operatorname{diag}(\mathbf p)X
\right]^T
(\mathbf 1-\mathbf y)
\\
&=
X^T
\operatorname{diag}(\mathbf p)
(\mathbf 1-\mathbf y)
\\
&=
X^T
\left[
(\mathbf 1-\mathbf y)\odot\mathbf p
\right].
\end{aligned}
$$

即：

$$
\boxed{
\nabla_{\boldsymbol\theta}L_2
=
X^T
\left[
(\mathbf 1-\mathbf y)\odot\mathbf p
\right]
}
$$

---

### 3. 合并交叉熵

$$
\begin{aligned}
\nabla_{\boldsymbol\theta}(L_1+L_2)
&=
-X^T
\left[
\mathbf y\odot(\mathbf 1-\mathbf p)
\right]
+
X^T
\left[
(\mathbf 1-\mathbf y)\odot\mathbf p
\right]
\\
&=
X^T
\left[
-\mathbf y\odot(\mathbf 1-\mathbf p)
+
(\mathbf 1-\mathbf y)\odot\mathbf p
\right].
\end{aligned}
$$

括号内化简：

$$
\begin{aligned}
-\mathbf y\odot(\mathbf 1-\mathbf p)
+
(\mathbf 1-\mathbf y)\odot\mathbf p
&=
-\mathbf y
+
\mathbf y\odot\mathbf p
+
\mathbf p
-
\mathbf y\odot\mathbf p
\\
&=
\mathbf p-\mathbf y.
\end{aligned}
$$

因此：

$$
\boxed{
\nabla_{\boldsymbol\theta}(L_1+L_2)
=
X^T(\mathbf p-\mathbf y)
}
$$

平均交叉熵的梯度为：

$$
\boxed{
\nabla_{\boldsymbol\theta}L_{\mathrm{data}}
=
\frac{1}{N}X^T(\mathbf p-\mathbf y)
}
$$

---

### 4. 正则项求导

$$
L_3(\boldsymbol\theta)
=
\frac{\lambda}{2}
\|\boldsymbol\theta\|_2^2
=
\frac{\lambda}{2}
\boldsymbol\theta^T\boldsymbol\theta.
$$

因此：

$$
\begin{aligned}
\nabla_{\boldsymbol\theta}L_3
&=
\frac{\lambda}{2}
\cdot 2\boldsymbol\theta
\\
&=
\lambda\boldsymbol\theta.
\end{aligned}
$$

即：

$$
\boxed{
\nabla_{\boldsymbol\theta}L_3
=
\lambda\boldsymbol\theta
}
$$

---

### 5. 最终结果

$$
\boxed{
\nabla_{\boldsymbol\theta}L(\boldsymbol\theta)
=
\frac{1}{N}
X^T
\left[
\sigma(X\boldsymbol\theta)-\mathbf y
\right]
+
\lambda\boldsymbol\theta
}
$$
