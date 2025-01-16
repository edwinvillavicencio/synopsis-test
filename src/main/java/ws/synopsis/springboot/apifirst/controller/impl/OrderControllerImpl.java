package ws.synopsis.springboot.apifirst.controller.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.extern.log4j.Log4j2;
import org.apache.camel.Exchange;
import org.springframework.stereotype.Controller;
import ws.synopsis.petstoreapi.model.Order;
import ws.synopsis.springboot.apifirst.controller.OrderController;
import ws.synopsis.springboot.apifirst.service.OrderService;

@Controller("orderContoller")
@Log4j2
public class OrderControllerImpl implements OrderController {

    private final OrderService orderService;

    public OrderControllerImpl(OrderService orderService) {
        this.orderService = orderService;
    }


    @Override
    public void createOrder(Exchange exchange) throws JsonProcessingException {
        Order order = exchange.getMessage().getBody(Order.class);
        this.orderService.createOrder(order)
                .subscribe((it) -> {
                    log.info(it.toString());
                    // Lógica para enviar la cadena a AS400
                    exchange.getMessage().setBody(it.toString());
                });
    }
}
