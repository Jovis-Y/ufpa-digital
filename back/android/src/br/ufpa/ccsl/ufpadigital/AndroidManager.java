package br.ufpa.ccsl.ufpadigital;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.support.customtabs.CustomTabsIntent;

public class AndroidManager {
    public static boolean openCustomTab(Context context, String url, String colorHex) {
        try {
            int colorInt = Color.parseColor(colorHex);

            CustomTabsIntent.Builder builder = new CustomTabsIntent.Builder();
            builder.setToolbarColor(colorInt);

            CustomTabsIntent customTabsIntent = builder.setShowTitle(true).build();
            customTabsIntent.intent.setPackage("com.android.chrome");
            customTabsIntent.intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

            customTabsIntent.launchUrl(context, Uri.parse(url));
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
