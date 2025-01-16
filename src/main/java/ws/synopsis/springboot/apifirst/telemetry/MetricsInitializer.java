package ws.synopsis.springboot.apifirst.telemetry;

import io.micrometer.core.instrument.MeterRegistry;
import io.micrometer.core.instrument.Counter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class MetricsInitializer {

    private final MeterRegistry meterRegistry;

    public MetricsInitializer(MeterRegistry meterRegistry, String channelsEnv,String nameContainer) {
        this.meterRegistry = meterRegistry;
        initializeMetrics(channelsEnv,nameContainer);
    }

    private void initializeMetrics(String channelsEnv,String nameContainer ) {
        // Leer la variable de entorno

        if (channelsEnv == null || channelsEnv.isEmpty()) {
            throw new IllegalArgumentException("La variable de entorno CHANNELS no esta definida.");
        }

        if (nameContainer == null || nameContainer.isEmpty()) {
            throw new IllegalArgumentException("La variable de entorno NAME_CONTAINER no esta definida.");
        }

        // Convertir la lista de canales en un arreglo
        List<String> channels = Arrays.asList(channelsEnv.split(","));

        // Exponer una métrica personalizada para cada canal
        for (String channel : channels) {
            Counter.builder("custom_channel_container")
                    .tag("channel", channel.trim())
                    .tag("container_name",nameContainer.trim())
                    .description("Container for channel")
                    .register(meterRegistry);
        }
    }
}
