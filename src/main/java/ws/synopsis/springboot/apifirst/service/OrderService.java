package ws.synopsis.springboot.apifirst.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import reactor.core.publisher.Mono;
import ws.synopsis.petstoreapi.model.Order;

public interface OrderService {
    Mono<String> createOrder(Order name) throws JsonProcessingException;
}
