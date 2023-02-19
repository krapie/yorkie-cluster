# MongoDB (6.0.1) Sharded Cluster with Docker Compose

##  Mongo Components

* Config Server (3 member replica set): `configsvr01`,`configsvr02`,`configsvr03`
* 3 Shards (each a 3 member `PSS` replica set):
	* `shard01-a`,`shard01-b`, `shard01-c`
	* `shard02-a`,`shard02-b`, `shard02-c`
	* `shard03-a`,`shard03-b`, `shard03-c`
* 2 Routers (mongos): `router01`, `router02`

<img src="https://raw.githubusercontent.com/minhhungit/mongodb-cluster-docker-compose/master/images/sharding-and-replica-sets.png" style="width: 100%;" />

##  Steps

### Step 1: Start all of the containers

Run this command:

```bash
docker-compose up -d
```

### Step 2: Initialize the replica sets (config servers and shards)

Run these command one by one:

```bash
docker-compose exec configsvr01 sh -c "mongosh < /scripts/init-configserver.js"

docker-compose exec shard01-a sh -c "mongosh < /scripts/init-shard01.js"
docker-compose exec shard02-a sh -c "mongosh < /scripts/init-shard02.js"
docker-compose exec shard03-a sh -c "mongosh < /scripts/init-shard03.js"
```

### Step 3: Initializing the router

Run this command:

```bash
docker-compose exec router01 sh -c "mongosh < /scripts/init-router.js"
```

### Step 4: Enable sharding and setup sharding-key

Run this command:

```bash
docker-compose exec router01 mongosh --port 27017

// Enable sharding for database `yorkie-meta`
sh.enableSharding("yorkie-meta")

// Setup shardingKey for yorkie-meta collections
db.adminCommand( { shardCollection: "yorkie-meta.projects", key: { _id: "hashed" } } )
db.adminCommand( { shardCollection: "yorkie-meta.users", key: { username: "hashed" } } )
db.adminCommand( { shardCollection: "yorkie-meta.clients", key: { project_id: "hashed" } } )
db.adminCommand( { shardCollection: "yorkie-meta.documents", key: { project_id: "hashed" } } )
db.adminCommand( { shardCollection: "yorkie-meta.changes", key: { doc_id: "hashed" } } )
db.adminCommand( { shardCollection: "yorkie-meta.snapshots", key: { doc_id: "hashed" } } )
db.adminCommand( { shardCollection: "yorkie-meta.syncedseqs", key: { doc_id: "hashed" } } )
```

### Step 5: Check mongodb connection & status

mongodb connection string to connect mongodb cluster:

```
mongodb://127.0.0.1:27117,127.0.0.1:27118
```

check mongodb shard status:

```bash
docker exec -it mongo-config-01 bash -c "echo 'rs.status()' | mongosh --port 27017"


docker exec -it shard-01-node-a bash -c "echo 'rs.help()' | mongosh --port 27017"
docker exec -it shard-01-node-a bash -c "echo 'rs.status()' | mongosh --port 27017" 
docker exec -it shard-01-node-a bash -c "echo 'rs.printReplicationInfo()' | mongosh --port 27017" 
docker exec -it shard-01-node-a bash -c "echo 'rs.printSlaveReplicationInfo()' | mongosh --port 27017"
```

### Step 6: Cleanup

Run these commands: 

```bash
docker-compose rm
```

```bash
docker-compose down -v --rmi all --remove-orphans
```