package ws.synopsis.springboot.apifirst.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import io.micrometer.core.instrument.MeterRegistry;
import ws.synopsis.springboot.apifirst.telemetry.MetricsInitializer;

@Configuration
public class MetricsConfig {

    @Value("${custom.metrics.export.channels}")
    private String channelsEnv;

    @Value("${custom.metrics.export.container.name}")
    private String nameContainer;
    @Bean
    public MetricsInitializer metricsInitializer(MeterRegistry meterRegistry) {
        return new MetricsInitializer(meterRegistry,channelsEnv,nameContainer);
    }
}
