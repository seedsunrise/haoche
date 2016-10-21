package com.haoche.bos.util;

import java.util.Random;

public class RandomUtils {

    private static final Random RANDOM = new Random();

    public static final String SELECTABLE_NUMBERS = "0123456789";

    // 生成length位数字随机数字符串
    public static String nextNumbers(final Integer length) {
        if (length <= 0) {
            throw new IllegalArgumentException();
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            // 产生随机数范围：[ 0 - (canSelectedChars.length-1) ]
            Integer index = RANDOM.nextInt(SELECTABLE_NUMBERS.length());
            sb.append(String.valueOf(SELECTABLE_NUMBERS.charAt(index)));
        }
        return sb.toString();
    }

    /**
     * 生成length位数字随机数字符串并且在生成的随机数字符串之前拼接简写年份字符串
     * 比如：生成的随机数为89898989，当前简写年份为15
     * '15' + '89898989' = '1589898989'
     */
    public static String nextNumbersAndPrependShortYear(Integer length) {
        StringBuilder sb = new StringBuilder();
        sb.append(RandomUtils.nextNumbers(length));
        return sb.toString();
    }
}
