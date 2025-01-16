package ws.synopsis.springboot.apifirst.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import org.apache.camel.Exchange;

public interface OrderController {
    void createOrder(Exchange exchange) throws JsonProcessingException;
}
