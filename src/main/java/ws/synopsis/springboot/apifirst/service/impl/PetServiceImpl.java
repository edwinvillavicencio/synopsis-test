package ws.synopsis.springboot.apifirst.service.impl;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import ws.synopsis.springboot.apifirst.repository.PetRepository;
import ws.synopsis.springboot.apifirst.service.PetService;

@Service
@AllArgsConstructor
public class PetServiceImpl implements PetService {

    private final PetRepository petRepository;

    @Override
    public Mono<Long> createPet(String name, Long categoryId, String status) {
        return petRepository.createPet(name, categoryId, status);
    }

}
