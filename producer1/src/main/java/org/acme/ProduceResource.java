package org.acme;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/produce")
public class ProduceResource {
    @POST
    @Produces(MediaType.TEXT_PLAIN)
    public String produce() {
        System.out.println("/produce hit on producer1");
        return "Event produced!";
    }
}
