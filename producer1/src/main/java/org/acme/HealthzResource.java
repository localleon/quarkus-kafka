package org.acme;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

// Adding Health Endpoint for deployment 
@Path("/healthz")
public class HealthzResource {

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String health() {
        System.out.println("/healthz hit on producer1");
        return "Healthy!";
    }
}
