# Yorkie Shard Cluster Docker PoC

> Warning: You need to put API Key in Yorkie Client to see proper routing!!!

## Architecture

- Router
  - envoy: router/proxy which performs ring hash algorithm based routing based on x-api-key (project_id)
- Server
  - yorkie1, yorkie2, yorkie3: normal yorkie server with 3 replica. They do **NOT** communicate with each other as previous broadcasting based cluster mode
- Database
  - mongo: stand-alone mongoDB. mongoDB with shard will be implemented soon (yorkie server's mongo client needs some shard related changes to use mongoDB shard)

## Getting Started

### Step 1. Deploy

Deploy docker based servers using docker-compose:

```
docker-compose up --build -d
```

### Step 2. Get public API key

API Key is **essential** to perform api key based routing:

```
git clone https://github.com/yorkie-team/dashboard.git

npm install

npm run start

get API key
```

### Step 3. Use any Yorkie implemented examples

Test with any Yorkie implemented examples:

```
git clone https://github.com/krapie/yorkie-tldraw

put API Key in `REACT_APP_YORKIE_API_KEY` in `.env.Production`

yarn

yarn start
```

### Step 4. Check routing behavior

Check routing behavior by watching docker logs:

```
docker compose logs
```
