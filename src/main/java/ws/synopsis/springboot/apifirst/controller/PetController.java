package ws.synopsis.springboot.apifirst.controller;

import org.apache.camel.Exchange;

public interface PetController {

    void getPetById(Exchange e);
    void updatePet(Exchange e);
    void createPet(Exchange exchange);

}
