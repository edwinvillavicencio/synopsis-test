package ws.synopsis.springboot.apifirst.service.impl;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import ws.synopsis.springboot.apifirst.repository.UserRepository;
import ws.synopsis.springboot.apifirst.service.UserService;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Override
    public Mono<Void> createUser(String username, String firstName, String lastName, String email, String password, String phone, int userStatus) {
        return userRepository.createUser(username, firstName, lastName, email, password, phone, userStatus);
    }

}
