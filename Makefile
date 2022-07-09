postgres:
	docker run --name postgres14 -p 5431:5431 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:latest
createdb:
	docker exec -it postgres14 createdb --username=root --owner=root simple_bank

drop db:
	docker exec -it posgres14 drop db simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@172.17.0.3:5432/simple_bank?sslmode=disable" --verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@172.17.0.3:5432/simple_bank?sslmode=disable" --verbose down
sqlc:
	sqlc generate
test:
	go test -v ./...
.PHONY: postgres createdb drop db migrateup migratedown sqlc test