这一章我们介绍支持向量机 (Support Vector Machine) 模型。支持向量机是一类有监督的度量模型，可以同时用于分类和回归任务。本章我们将频繁使用`sklearn.svm`的接口。

# 模型设定
支持向量机的原理在于在训练数据中，寻找并确定一个线性超平面，使得其能够将各类数据区分开，同时又离各类数据尽可能的远。而确定这个超平面位置的关键，是少部分距离这个超平面最近的样本点，称为支持向量。下面我们来严格叙述这个模型假设。

## 模型假设
### 硬间隔模型
我们先考虑二分类问题下的建模。定义数据集$\mathcal{D}$为
$$
\mathcal{D}:=\{(\boldsymbol{x}_i,y_i)\}_{i=1}^n
$$
其中$\boldsymbol{x}\in\mathbb{R}^n \text{ and } y\in\{-1,1\}$. 假设整个空间内的数据集是线性可分的，即存在一个平面$\partial:\{(\boldsymbol{\omega},b)\in\mathbb{R}^{n+1}\mid\boldsymbol{\omega}^Tx+b=0\}$满足
$$
	(X\boldsymbol{\omega}+\boldsymbol{b})\cdot \boldsymbol{y} > \boldsymbol{0},\quad\forall(\boldsymbol{\omega},b)\in\partial \tag{1.1}
$$
上述模型假设中标签$y$也可以取其他的二分类实值，因为不失一般性地总能找到一个变换满足标准的理论形式。
![[SVM.png|450]]
### 软间隔模型
在硬间隔的模型假设中，我们假设数据集是完全线性可分的。实际上数据集分布很可能不是完全线性可分的，尤其当特征数量增多的时候——因为一旦有一个维度的特征不是线性可分的，整个数据集就不是线性可分的——数据集线性不可分的概率就会增大。而一旦出现线性不可分的时候，就不满足线性可分的充要条件，也就是说会出现
$$
	\exists_i: y_i(\boldsymbol{\omega}^T\boldsymbol{x}+b) <0
	\tag{1.2}
$$
同时在后续我们指定好平面的法向量之后，可能会出现
$$
	\forall_{\partial(\boldsymbol{\omega},b)}\exists_i:y_i(\boldsymbol{\omega}^T\boldsymbol{x}_i+b) < 1
	\tag{1.3}
$$
这个时候我们只能允许部分错误分类的存在，通过放松部分假设来得到新条件下支持向量机的优化形式，在优化理论中这部分误差称为松弛变量。
![[SVM-Soft.png|525]]


### 核方法模型
硬间隔的支持向量机需要数据集是完全线性可分的，即使是软间隔的支持向量机也需要数据集是近似线性可分的。当数据集近似完全线性不可分的时候，我们仍然有可能通过一些处理方法提高数据集的可分性。这里所说的方法就是核方法：将低维数据集映射到高维空间中使其线性可分的方法。

理论上当数据集升维的维度越高，其完全线性可分的概率越大。核方法理论就是使用升维函数$\varphi$将数据集升到更高维度中，提高数据集可分性质的巧妙方法。而核函数则是简化了升维数据集内积的计算过程，甚至可以将数据映射至无穷维之后的计算变得可行。
![[SVM-Kernel.png|550]]
### 多分类模型
支持向量机最初设计适用于处理二分类问题，该模型也可以拓展到多分类问题。常用的思路可以是训练多个二分类器，将多分类问题拆解成多个二分类问题的复合，具体的实现路径包括一对多类(One vs Rest)和一对一类以及结合二者方法使用。如果要采用一对一类的多分类器，将需要$C_n^2$个SVM分类器。

## 模型推导
### 优化形式
#### 硬间隔模型
由于我们假设该数据集是线性可分的，因此至少存在一个平面满足上述要求。实际上只要存在一个平面满足上述要求，等价于存在无限多个平面满足上述要求（为数据集是离散的），我们记这些线性可分的平面集合为$\Sigma$集合。因此我们要在这些可行平面中找出最优的平面来，这个寻找过程可以通过一个优化过程来解决。
$$
	\max_{\partial\in\Sigma}d(\partial,\mathcal{D}) \tag{2.1}
$$
根据几何知识我们注意到，每一个平面可以表示为与其法向量有关的一个线性空间$\partial:\{(\boldsymbol{\omega},b)\in\mathbb{R}^{n+1}\mid\boldsymbol{\omega}^Tx+b=0\}$，这使得一个平面很多种等价的参数表示形式 (因为我们可以指定不同长度的法向量)。但是每个平面的非零法向量都具有独特性，都与其他平面的任何参数组合线性无关 (可以理解不同平面的非零法向量方向不同)。所以我们可以通过这些法向量对应其代表的平面，等价转化优化过程的表述。又因为这些平面法向量满足的充要条件为$(1.1)$，因此寻找最优平面的过程等价于寻找最优代表法向量的过程。
$$
\begin{align}
&\max_{(\boldsymbol{\omega},b)}d(\partial,D)=\frac{||\boldsymbol{w}^Tx_{\partial}+b||}{||\boldsymbol{\omega}||_2} \\ \\
\text{subject to}\quad &
(X\boldsymbol{w}+\boldsymbol{b})\odot\boldsymbol{y} > 0
\end{align}
\tag{2.2}
$$
这个优化过程还可以进一步优化。首先我们注意到这个优化问题可以有无穷多个解，因为我们要求解的是最优平面，而一个平面可以对应无穷多个法向量，因此还可以简化法向量的寻找范围。对于每一个平面，我们唯一指定一个法向量来代表这个平面$\partial(\boldsymbol{\omega,b}):\boldsymbol{\omega}^T\boldsymbol{x}+b=0$，这个法向量满足充分必要条件$\boldsymbol{w}^T\boldsymbol{x}_{\partial}+b=1$，对于距离其最近的$\boldsymbol{x}_{\partial}$样本点。这样我们就最小化了搜寻范围，现在每个每个平面有且仅有唯一的法向量与之对应了，相应的优化过程等价化简为
$$
\begin{align}
\underset{(\boldsymbol{\omega},b)}{\operatorname{minimize}}\quad &d(\partial,D)=\frac{1}{||\boldsymbol{\omega}||_2} \\[0.5em]

\text{subject to}\quad
&(X\boldsymbol{w}+\boldsymbol{b})\odot\boldsymbol{y} \geq 1
\end{align}
\tag{2.3}
$$
所以所谓的支持向量机，实际上是借助超平面的法向量来度量其到各个类别之间的距离，并以此为基础进行的优化过程。此外为了进一步让计算方便，我们还可以等价调整目标函数的形式，得到如下最终表述。
$$
\begin{align}
\underset{(\boldsymbol{\omega},b)}{\operatorname{minimize}} \quad
& \frac{1}{2}||\boldsymbol{\omega}||^2_2 \\[0.5em]
\text{subject to}\quad &
(X\boldsymbol{w}+\boldsymbol{b})\odot\boldsymbol{y} \geq 1
\end{align}
\tag{2.4}
$$
这是一个二次优化过程，属于凹凸优化过程，目前已经有成熟的理论可以解决它，所以下一部分我们介绍怎么求解这个优化过程。
#### 软间隔模型
由于数据集可能是不可分的，因此我们引入了分类误差的概念，在模型假设中我们允许误差的存在，但我们需要误差尽可能的小。于是在优化过程中我们将误差部分也加入了目标函数，希望通过求解最小化参数的过程中同时也减小分类误差。
$$
	\begin{aligned}
	\underset{(\boldsymbol{\omega},b,\boldsymbol{\xi})}{\operatorname{minimize}} \quad
	& \frac{1}{2}||\boldsymbol{\omega}||^2_2 + C\sum\xi_i \\[0.5em]
	\text{subject to}\quad & 
	(X\boldsymbol{w}+\boldsymbol{b})\odot\boldsymbol{y} \geq 1 - \boldsymbol{\xi}\ , \\[0.2em]
	&\boldsymbol{\xi} \geq 0
	\end{aligned}
	\tag{2.5}
$$
### 优化求解

# 模型训练



# 模型评估