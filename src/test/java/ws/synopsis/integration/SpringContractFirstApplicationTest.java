package ws.synopsis.integration;

import static org.junit.jupiter.api.Assertions.assertTrue;

import org.apache.camel.CamelContext;
import org.apache.camel.ProducerTemplate;
import org.apache.camel.builder.AdviceWith;
import org.apache.camel.component.mock.MockEndpoint;
import org.apache.camel.test.spring.junit5.CamelSpringBootTest;
import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@CamelSpringBootTest
class SpringContractFirstApplicationTest {

	@Autowired
	CamelContext camelContext;

	@Autowired
	ProducerTemplate producerTemplate;

	@Test
	public void test() throws Exception {
		assertTrue(true);
	}
	
}
