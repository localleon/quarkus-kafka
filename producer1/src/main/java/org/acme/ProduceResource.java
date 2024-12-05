package org.acme;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import io.smallrye.mutiny.Multi;
import org.eclipse.microprofile.reactive.messaging.Outgoing;

import jakarta.enterprise.context.ApplicationScoped;
import java.time.Duration;
import java.util.Random;


@Path("/produce")
@ApplicationScoped
public class ProduceResource {


    @POST
    @Produces(MediaType.TEXT_PLAIN)
    @Outgoing("producer1")
    public String produce() {
        System.out.println("/produce hit on producer1");
        
        // Create random event
        Random random = new Random();
        return "Event" + random.nextDouble();
    }
}
