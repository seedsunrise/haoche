package com.haoche.bos.util;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.haoche.remoting.enums.BaseEnum;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * json Response自定义序列化
 * Created by Ken on 2016/7/18.
 */
@Component("customObjectMapper")
public class CustomObjectMapper extends ObjectMapper {
    public CustomObjectMapper() {
        SimpleModule module = new SimpleModule();
        module.addSerializer(BaseEnum.class, new ItemSerializer());
        module.addSerializer(Date.class, new DateSerializer());
        this.registerModule(module);
    }

    class ItemSerializer extends JsonSerializer<BaseEnum> {

        @Override
        public void serialize(BaseEnum value, JsonGenerator gen, SerializerProvider serializers) throws IOException, JsonProcessingException {
            gen.writeStartObject();
            gen.writeObjectField("id", value.getId());
            gen.writeObjectField("text", value.getText());
            gen.writeEndObject();
        }
    }
    class DateSerializer extends JsonSerializer<Date> {

        @Override
        public void serialize(Date value, JsonGenerator gen, SerializerProvider serializers) throws IOException, JsonProcessingException {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            gen.writeString(sdf.format(value));
        }
    }
}
