# StarRocks-Starter
Start learning StarRocks with one click based on Docker!

## Steps

1. Run StarRocks container (run in latest version `2.5.0`):

```shell
docker run -p 9030:9030 -p 8030:8030 -p 8040:8040 --privileged=true -d --name starrocks-starter d87904488/starrocks-starter:2.5.0
```

2. Access StarRocks using mysql client:

```shell
mysql -uroot -h127.0.0.1 -P 9030
```

3. Test it, run following sql:

```sql
CREATE DATABASE TEST;

USE TEST;

CREATE TABLE `sr_on_mac` (
 `c0` int(11) NULL COMMENT "",
 `c1` date NULL COMMENT "",
 `c2` datetime NULL COMMENT "",
 `c3` varchar(65533) NULL COMMENT ""
) ENGINE=OLAP 
DUPLICATE KEY(`c0`)
PARTITION BY RANGE (c1) (
  START ("2022-02-01") END ("2022-02-10") EVERY (INTERVAL 1 DAY)
)
DISTRIBUTED BY HASH(`c0`) BUCKETS 1 
PROPERTIES (
"replication_num" = "1",
"in_memory" = "false",
"storage_format" = "DEFAULT"
);


insert into sr_on_mac values (1, '2022-02-01', '2022-02-01 10:47:57', '111');
insert into sr_on_mac values (2, '2022-02-02', '2022-02-02 10:47:57', '222');
insert into sr_on_mac values (3, '2022-02-03', '2022-02-03 10:47:57', '333');


select * from sr_on_mac where c1 >= '2022-02-02';
```

4. If there is no error displayed, that means you have run it successfully!👏

## Build Docker image by myself

1. Pull this repository
2. Run docker build command

```shell
docker build --no-cache --progress=plain -t starrocks-starter:2.5.0 .
```
