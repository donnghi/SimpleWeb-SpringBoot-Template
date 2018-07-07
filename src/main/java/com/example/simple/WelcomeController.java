package com.example.simple;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
public class WelcomeController
{
//    Inject via application.properties
    @Value("${welcome.message:test}")
    private String message = "Hello world";

    @RequestMapping("/")
    public String welcome(Map<String, Object> model)
    {
        model.put("message", this.message);
        return "welcome";
    }
}
