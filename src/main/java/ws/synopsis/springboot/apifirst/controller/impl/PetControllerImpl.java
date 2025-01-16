package ws.synopsis.springboot.apifirst.controller.impl;

import lombok.extern.log4j.Log4j2;
import org.apache.camel.Exchange;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import ws.synopsis.petstoreapi.model.Pet;
import ws.synopsis.springboot.apifirst.controller.PetController;
import ws.synopsis.springboot.apifirst.service.PetService;

import java.util.concurrent.ThreadLocalRandom;

@Controller("petController")
@Log4j2
public class PetControllerImpl implements PetController {

    private final String petName;
    private final PetService petService;
    private final Long maxDelay;

    public PetControllerImpl(@Value("${petName}") String petName, @Value("${service.thread.maxDelay:10}") Long maxDelay, PetService petService) {
        this.petName = petName;
        this.petService = petService;
        this.maxDelay = maxDelay;
        log.info("service.thread.maxDelay: {}", this.maxDelay);
    }

    public void getPetById(Exchange e) {
        // build response body as POJO
        Pet pet = new Pet();
        pet.setId(e.getMessage().getHeader("petId", long.class));
        pet.setName(petName);
        pet.setStatus(Pet.StatusEnum.AVAILABLE);
        e.getMessage().setBody(pet);
    }

    @Override
    public void updatePet(Exchange e) {
        Pet pet = e.getMessage().getBody(Pet.class);
        pet.setStatus(Pet.StatusEnum.PENDING);
        e.getMessage().setBody(pet);
    }

    @Override
    public void createPet(Exchange e) {
        Pet pet = e.getMessage().getBody(Pet.class);
        Long it = this.petService.createPet(pet.getName(), pet.getCategory().getId(), pet.getStatus().toString()).block();
        log.info(it.toString());
        pet.id(it);
        try {
            Thread.sleep(random());
        } catch (InterruptedException ex) {
            log.error(ex.getMessage(), ex);
        }
        e.getMessage().setBody(pet);
    }

    private long random() {
        if(maxDelay > 0) {
            return ThreadLocalRandom.current().nextLong(0, maxDelay) * 1000;
        } else {
            return 0;
        }
    }
}