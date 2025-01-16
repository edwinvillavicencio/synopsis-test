package ws.synopsis.springboot.apifirst.config;

import io.r2dbc.spi.ConnectionFactory;
import org.apache.camel.Configuration;
import org.springframework.context.annotation.Bean;
import org.springframework.data.r2dbc.config.AbstractR2dbcConfiguration;
import org.springframework.data.r2dbc.core.R2dbcEntityTemplate;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
public class R2dbcConfig extends AbstractR2dbcConfiguration {

    private final ConnectionFactory connectionFactory;

    public R2dbcConfig(ConnectionFactory connectionFactory) {
        this.connectionFactory = connectionFactory;
    }

    @Bean
    public R2dbcEntityTemplate r2dbcEntityTemplate() {
        return new R2dbcEntityTemplate(connectionFactory);
    }

    @Override
    public ConnectionFactory connectionFactory() {
        return this.connectionFactory;
    }

}
