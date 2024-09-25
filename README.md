# schema-driving-developer-swagger
- Swaggerを使ってRestAPIスキーマ駆動開発

## OpenApi Mock Build Container Start

``` sh
 docker build -t openapi-tools . 
 docker run --name openapi-mock-server  -d -p 4010:4010 -v$(pwd):/workspace openapi-tools 
```

## Curlコマンドでモックサーバ疎通確認
``` sh
curl -X 'POST' \
  'http://localhost:4010/user' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "id": 10,
  "username": "theUser",
  "firstName": "John",
  "lastName": "James",
  "email": "john@email.com",
  "password": "12345",
  "phone": "12345",
  "userStatus": 1
}'
```

## OpenApi Ganerator Command Lines

``` sh
# typescript/fetch
docker exec openapi-mock-server openapi-generator-cli generate -c /workspace/openapitools-fetch-api.json -o /workspace/output/typescript/fetch
# typescript/axios
docker exec openapi-mock-server openapi-generator-cli generate -c /workspace/openapitools-axios.json -o /workspace/output/typescript/axios
# java/springboot
docker exec openapi-mock-server openapi-generator-cli generate -c /workspace/openapitools-spring.json -o /workspace/output/java
```

