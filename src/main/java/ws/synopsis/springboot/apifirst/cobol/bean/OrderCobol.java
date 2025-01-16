package ws.synopsis.springboot.apifirst.cobol.bean;

public class OrderCobol {
    String orderId;
    String petId;
    String quantity;
    String shipDate;
    String status;
    String complete;
    public String generateString (){
        return orderId.concat(petId.concat(quantity.concat(shipDate.concat(status.concat(complete)))));
    }
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public void setPetId(String petId) {
        this.petId = petId;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public void setShipDate(String shipDate) {
        this.shipDate = shipDate;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setComplete(String complete) {
        this.complete = complete;
    }

    @Override
    public String toString() {
        return "OrderCobol{" +
                "orderId='" + orderId + '\'' +
                ", petId='" + petId + '\'' +
                ", quantity='" + quantity + '\'' +
                ", shipDate='" + shipDate + '\'' +
                ", status='" + status + '\'' +
                ", complete='" + complete + '\'' +
                '}';
    }
}
