package com.haoche.bos.config.binder;

import com.haoche.remoting.enums.BaseEnum;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.converter.ConverterFactory;


public class StringToEnumConverter implements ConverterFactory<String, BaseEnum> {
    StringToEnumConverter() {
    }

    public <T extends BaseEnum> Converter<String, T> getConverter(Class<T> targetType) {
        return new StringToEnum(targetType);
    }

    private class StringToEnum<T extends BaseEnum> implements Converter<String, T> {
        private final Class<T> enumType;

        public StringToEnum(Class<T> var1) {
            this.enumType = var1;
        }

        public T convert(String source) {
            T[] enums = enumType.getEnumConstants();
            for (T baseEnum : enums) {
                if (baseEnum.getId() == Integer.valueOf(source)) {
                    return baseEnum;
                }
            }
            return null;
        }
    }
}
