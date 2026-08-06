# 模型背景
算法Skip-Gram是Word2Vec模型一种重要的实现方式。该模型认为语言元素具有“中心词”和“上下文”两种语境含义，因此通过计算样本语料中Token作为两种角色出现的似然概率来估计向量矩阵。
# 模型估计

假设Token可以被描述为$d$维的特征向量，同时其作为中心词与上下文的角色分别被描述为$\bm{u}_i$与$\bm{v}_i$向量，用两个向量矩阵$\bm{U}$与$\bm{V}$分别存储Token向量。在给定中心词Token的条件下，上下文Token出现的概率满足
$$
	P(w_o\mid w_c)=\frac{e^{u_c \cdot v_o}}{\underset{j\in 
	\mathcal{V}}{\sum}u_cv_j}
$$
抽取预料样本，指定样本窗口大小为n。假设各个Token出现的概率是相互独立的，则该语料样本的似然概率为
$$
	L(U,V)={\underset{1 \leq c \leq N}\prod}{\underset{0 < |j|\leq n}\prod}P(w_{c+j}|w_c)
$$
