postgres:
	docker run --rm --name postgres13 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v ~/docker-data/postgres13-alpine/pgData:/var/lib/postgresql/data  postgres:13-alpine

createdb:
	docker exec -it postgres13 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres13 dropdb simple_bank

migrateup:
	migrate --path db/migration --database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose up

migrateup1:
	migrate --path db/migration --database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose up	1

migratedown:
	migrate --path db/migration --database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose down

migratedown1:
	migrate --path db/migration --database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" --verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...
	
server:	
	go run main.go

mock:
	mockgen -destination db/mock/store.go -package mockdb techschool/simplebank/db/sqlc Store	

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock