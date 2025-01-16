package ws.synopsis.springboot.apifirst;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.r2dbc.repository.config.EnableR2dbcRepositories;

@SpringBootApplication
@EnableR2dbcRepositories
public class SpringBootApiFirstApplication {

    /**
     * A main method to start this application.
     */
    public static void main(String[] args) {
        SpringApplication.run(SpringBootApiFirstApplication.class, args);
    }

}
