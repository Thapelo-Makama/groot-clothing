/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package groot.util;

import java.text.Normalizer;
import java.util.Locale;

/**
 *
 * @author thapelo
 */


public class SlugUtil {

    public static String toSlug(String input) {
        if (input == null || input.isEmpty()) return "";

        String nowhitespace = input.trim().replaceAll("\\s+", "-");
        String normalized = Normalizer.normalize(nowhitespace, Normalizer.Form.NFD);
        String slug = normalized.replaceAll("[^\\w-]", "").toLowerCase(Locale.ENGLISH);

        // Collapse multiple dashes into one
        slug = slug.replaceAll("-+", "-").replaceAll("^-|-$", "");

        return slug;
    }
}