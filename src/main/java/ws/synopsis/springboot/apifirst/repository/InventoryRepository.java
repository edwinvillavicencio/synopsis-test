package ws.synopsis.springboot.apifirst.repository;

import org.springframework.r2dbc.core.DatabaseClient;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import ws.synopsis.springboot.apifirst.entity.Inventory;

@Repository
public class InventoryRepository {

    private final DatabaseClient databaseClient;

    public InventoryRepository(DatabaseClient databaseClient) {
        this.databaseClient = databaseClient;
    }

    public Flux<Inventory> getInventory() {
        return databaseClient.sql("CALL get_inventory()")
                .map((row, metadata) -> new Inventory(
                        row.get("status", String.class),
                        row.get("count", Integer.class)))
                .all();
    }

}
