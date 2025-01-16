package ws.synopsis.springboot.apifirst.repository;

import org.springframework.r2dbc.core.DatabaseClient;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Mono;

@Repository
public class UserRepository {

    private final DatabaseClient databaseClient;

    public UserRepository(DatabaseClient databaseClient) {
        this.databaseClient = databaseClient;
    }

    public Mono<Void> createUser(String username, String firstName, String lastName, String email, String password, String phone, int userStatus) {
        return databaseClient.sql("CALL create_user(:username, :firstName, :lastName, :email, :password, :phone, :userStatus)")
                .bind("username", username)
                .bind("firstName", firstName)
                .bind("lastName", lastName)
                .bind("email", email)
                .bind("password", password)
                .bind("phone", phone)
                .bind("userStatus", userStatus)
                .then();
    }

}
