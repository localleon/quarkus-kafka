package org.acme;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import io.smallrye.mutiny.Multi;
import org.eclipse.microprofile.reactive.messaging.Outgoing;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.reactive.messaging.Channel;
import org.eclipse.microprofile.reactive.messaging.Emitter;
import java.time.Duration;
import java.util.Random;


@Path("/produce")
@ApplicationScoped
public class ProduceResource {

    @Inject
    @Channel("producer1") // Matches the channel name in application.properties
    Emitter<String> emitter;

    @POST
    @Path("/send")
    public String produce(String message) {
        emitter.send(message); // Send the message to Kafka
        return "/produce: Message sent to Kafka: " + message;    
    }
}
