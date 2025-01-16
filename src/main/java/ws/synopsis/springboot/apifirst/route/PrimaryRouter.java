package ws.synopsis.springboot.apifirst.route;

import io.micrometer.core.instrument.MeterRegistry;
import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.trace.Tracer;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.model.rest.RestBindingMode;
import org.apache.camel.opentelemetry.OpenTelemetryTracer;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.actuate.autoconfigure.metrics.MeterRegistryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import ws.synopsis.integration.fwk.config.ControlInitial;
import ws.synopsis.integration.fwk.telemetry.CustomOpenTelemetry;
import ws.synopsis.springboot.apifirst.controller.OrderController;
import ws.synopsis.springboot.apifirst.controller.PetController;

import java.io.IOException;
import java.nio.file.Paths;

/**
 * A simple Camel route that triggers from a timer and calls a bean and prints to system out.
 * <p/>
 * Use <tt>@Component</tt> to make Camel auto detect this route when starting.
 */
@Component
public class PrimaryRouter extends RouteBuilder {

    final private PetController petController;
    final private OrderController orderController;
    final private String configRoute;

    public PrimaryRouter(PetController petController,
                         OrderController orderController,
                         @Value("${synopsis-fwk.config-route}") String configRoute) {
        super();
        this.petController = petController;
        this.orderController = orderController;
        this.configRoute = configRoute;
    }

    // Crear el Tracer
    private final Tracer tracer = GlobalOpenTelemetry.getTracer("PrimaryRouter");

    @Bean
    MeterRegistryCustomizer<MeterRegistry> metricsCommonTags() {
        return registry -> registry.config().commonTags("application", "synopsis-test");
    }
    @Override
    public void configure() throws IOException, ParseException {

        // Configurar el tracer de OpenTelemetry para Camel
        OpenTelemetryTracer camelTracer = new OpenTelemetryTracer();
        camelTracer.init(getContext());

        // turn on json binding and scan for POJO classes in the model package
        restConfiguration().bindingMode(RestBindingMode.json)
                .bindingPackageScan("ws.synopsis.petstoreapi");

        rest().openApi().specification("ws.synopsis.petstoreapi.json").missingOperation("ignore");

        from("direct:getPetById")
                .process(CustomOpenTelemetry.customInputDataProcessor())
                .process(petController::getPetById)
                .process(CustomOpenTelemetry.customOutputDataProcessor());

        from("direct:updatePet")
                .process(CustomOpenTelemetry.customInputDataProcessor())
                .process(petController::updatePet)
                .process(CustomOpenTelemetry.customOutputDataProcessor());

        ControlInitial ctrlInitAddPet = new ControlInitial(Paths.get(this.configRoute, "addPet").toFile().getAbsolutePath());
        from("direct:addPet")
                .process(CustomOpenTelemetry.customInputDataProcessor())
                .circuitBreaker()
                .resilience4jConfiguration(ctrlInitAddPet.circuitBreakerConfig())
                .process(petController::createPet)
                .process(CustomOpenTelemetry.customOutputDataProcessor());

        //POST /store/order
        from("direct:placeOrder")
                .process(CustomOpenTelemetry.customInputDataProcessor())
                .process(orderController::createOrder)
                .process(CustomOpenTelemetry.customOutputDataProcessor());
    }



}
