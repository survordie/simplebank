postgres:
	docker run --rm --name postgres13 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v ~/docker-data/postgres13-alpine/pgData:/var/lib/postgresql/data  postgres:13-alpine

createdb:
	docker exec -it postgres13 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres13 dropdb simple_bank

migrateup:
	migrate --path db/migration --database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose up	

migratedown:
	migrate --path db/migration --database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose down	
  
sqlc:
	sqlc generate

test:
	go test -v -cover ./...
.PHONY: postgres createdb dropdb migrateup migratedown sqlc test