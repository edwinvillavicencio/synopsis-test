package ws.synopsis.springboot.apifirst.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import ws.synopsis.petstoreapi.model.Order;
import ws.synopsis.springboot.apifirst.cobol.PrepareBodyTrama;
import ws.synopsis.springboot.apifirst.service.OrderService;
@Service
@AllArgsConstructor
public class OrderServiceImpl implements OrderService {
    @Override
    public Mono<String> createOrder(Order order) throws JsonProcessingException {
        return Mono.just(PrepareBodyTrama.prepareInputBodyCobol(order));
    }
}
