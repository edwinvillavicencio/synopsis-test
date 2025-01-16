package ws.synopsis.springboot.apifirst.repository;

import org.springframework.r2dbc.core.DatabaseClient;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Mono;

@Repository
public class OrderRepository {

    private final DatabaseClient databaseClient;

    public OrderRepository(DatabaseClient databaseClient) {
        this.databaseClient = databaseClient;
    }

    public Mono<Long> placeOrder(Long petId, int quantity, String shipDate, String status, boolean complete) {
        return databaseClient.sql("CALL place_order(:petId, :quantity, :shipDate, :status, :complete)")
                .bind("petId", petId)
                .bind("quantity", quantity)
                .bind("shipDate", shipDate)
                .bind("status", status)
                .bind("complete", complete)
                .map((row, metadata) -> row.get("id", Long.class))
                .one();
    }

}
