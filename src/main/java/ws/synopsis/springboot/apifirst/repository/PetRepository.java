package ws.synopsis.springboot.apifirst.repository;

import org.springframework.r2dbc.core.DatabaseClient;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Mono;

@Repository
public class PetRepository {

    private final DatabaseClient databaseClient;

    public PetRepository(DatabaseClient databaseClient) {
        this.databaseClient = databaseClient;
    }

    public Mono<Long> createPet(String name, Long categoryId, String status) {
        return databaseClient.sql("select id from firstapi.create_pet(:name, :categoryId, :status)")
                .bind("name", name)
                .bind("categoryId", categoryId)
                .bind("status", status)
                .map((row, metadata) -> row.get("id", Long.class))
                .one();
    }

}
