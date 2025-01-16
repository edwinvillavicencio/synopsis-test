package ws.synopsis.springboot.apifirst.service;

import reactor.core.publisher.Mono;

public interface UserService {

    Mono<Void> createUser(String username, String firstName, String lastName, String email, String password, String phone, int userStatus);

}
