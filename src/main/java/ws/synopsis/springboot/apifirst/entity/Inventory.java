package ws.synopsis.springboot.apifirst.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Inventory {
    private String status;
    private int count;
}
