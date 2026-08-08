
# 测试规则
## 测试发现规则
递归遍历整个项目文件夹，寻找"test_"或者"\_test"作为开头或者结尾的文件，再遍历所有"Test"开头的函数或者类成员函数。

# 测试配置
## 配置文件
```python
## Example1
# root/pyproject.toml:
[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "--cov=src --cov-report=term-missing"
...
```
## 命令参数
```sh
pytest
pytest -s	# 允许正常IO交互
```

## 测试标记
```python
# root/pytest.ini
[pytest]

markers = <标记名称1>: <注释1>, 

```

| 标记                   | 含义  |
| -------------------- | --- |
| @pytest.mark.skip    |     |
| @pytest.mark.skipif  |     |
| @pytest.mark.xpassed |     |

```python
pytest -m <标记名>
```

## 测试夹具
在pytest中测试夹具（fixture）是一个重要的特性，它使得我们可以在测试之前、测试之后统一地做一些事情，类似于测试的上下文管理器。
```python
## Example1
@pytest.fixture(autohouse=True)
def myFixture():
	...			# 测试前操作
	yield 		# 测试过程
	...			# 测试后操作

@pytest.mark.usefixtures("myFixture")
@pytest.mark.parametrize(
    "a, b, expected",
    [[1,2,3], [4,5,9], [7,8,15]]
)
def test_add(a,b,expected):
    result = add(a,b)
    assert result == expected
```
### 夹具依赖
不同的夹具之间可以形成顺序依赖关系
```python
@pytest.fixture
def fixture1():
	...

@pytest.fixture
def fixture2(fixture1):
	...
```

### 夹具共享
夹具共享是一个进阶特性，让多个测试用例之间共享一套夹具指令。首先夹具的共享范围可以通过`scope`参数进行修改。

| scope    | 含义         |
| -------- | ---------- |
| function | 每个测试函数调用一次 |
| class    | 每个测试类调用一次  |
| module   | 每个测试文件调用一次 |
| package  | 每个包调用一次    |
| session  | 整个项目只调用一次  |

```python
## Example1
@pytest.fixture(scope="session")	# 全局范围内共享
def myFixture:
	...	
	yield 
	...	
```

其次可以在/test下单独创建文件`conftest.py`用来管理具有共享状态的fixture夹具。
## 参数测试
```python
@pytest.mark.parameterize(argnames, argvalues)
"""
Parameters
----------
argnames: str | Sequence[str]
	用于指定测试函数需要的参数。
argvalues: 
	用于指定测试参数的取值。
"""

## Example1
# /src/utils.py:
def add(x, y):
	return x+y

# /test/test_01.py:
import pytest
from src import 
@pytest.mark.parametrize(
    "a, b, expected",
    [[1,2,3], [4,5,9], [7,8,15]]
)
def test_add(a,b,expected):
    result = add(a,b)
    assert result == expected
    
# pwsh:
uv run pytest
```

### 数据测试
在参数化测试的功能下，我们可以结合数据文件，实现批量的用例测试。