package ws.synopsis.springboot.apifirst.service;

import reactor.core.publisher.Mono;

public interface PetService {

    Mono<Long> createPet(String name, Long categoryId, String status);

}
