package ws.synopsis.springboot.apifirst.cobol;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.opentelemetry.api.trace.Span;
import ws.synopsis.petstoreapi.model.Order;
import ws.synopsis.springboot.apifirst.cobol.bean.OrderCobol;
import ws.synopsis.springboot.apifirst.cobol.utils.Utils;

public class PrepareBodyTrama {
    public static String prepareInputBodyCobol(Order orderInput) throws JsonProcessingException {

        Span span = Span.current();

       OrderCobol bill = new OrderCobol();
       bill.setOrderId(Utils.ajustarCadena(String.valueOf(orderInput.getId()),10," ", "DER"));
       bill.setPetId(Utils.ajustarCadena(String.valueOf(orderInput.getPetId()),10," ", "DER"));
       bill.setQuantity(Utils.ajustarCadena(String.valueOf(orderInput.getQuantity()),13," ", "DER"));
       bill.setShipDate(Utils.ajustarCadena(String.valueOf(orderInput.getShipDate()),20," ", "DER"));
       bill.setStatus(Utils.ajustarCadena(String.valueOf(orderInput.getStatus()),10," ", "DER"));
       bill.setComplete((orderInput.isComplete())? "1": "0");
       span.setAttribute("TramaInput",bill.toString());
       return bill.generateString();
    }
}
