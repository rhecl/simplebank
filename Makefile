postgres:
	docker run --name bank_postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=password postgres:12-alpine
createdb:
	docker exec -it bank_postgres createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it bank_postgres dropdb simple_bank
migrateup:
	migrate -path db/migrations -database "postgres://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migrations -database "postgres://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test