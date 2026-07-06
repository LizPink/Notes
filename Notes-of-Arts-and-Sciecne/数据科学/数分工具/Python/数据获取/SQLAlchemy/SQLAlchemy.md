在Python中SQLAlchemy及其底层驱动是Python语言访问数据库的主流工具。
```text
SQLAlchemy
├── PostgreSQL dialect
│   ├── psycopg
│   ├── psycopg2
│   ├── asyncpg
│   └── pg8000
│
├── MySQL dialect
│   ├── mysqlclient
│   ├── PyMySQL
│   └── asyncmy
│
├── SQLite dialect
│   └── sqlite3
│
├── SQL Server dialect
│   └── pyodbc
│
└── Oracle dialect
    └── oracledb
```
访问并交互数据库的一般流程为：连接数据库->交互操作->关闭数据库。其中当我们需要进行查询操作时，需要执行`execute()`与`fetchall()`方法调用引擎进行查询并获取查询结果。