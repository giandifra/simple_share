package com.juanito21.simpleshare.src;

import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.support.v4.app.ShareCompat;
import android.net.Uri;
import java.util.Map;
import java.util.List;

public class ShareHelper {
    private final Registrar registrar;
    private Map params;
    private ShareCompat.IntentBuilder intentBuilder;

    public ShareHelper(Registrar registrar) {
        this.registrar = registrar;
        this.intentBuilder = ShareCompat.IntentBuilder.from(this.registrar.activity());
    }

    public void share(Map params) {
        this.params = params;
        if (checkKey("title")) {
            String title = (String) params.get("title");
            intentBuilder.setChooserTitle(title);
        }
        if (checkKey("msg")) {
            intentBuilder.setText((String) params.get("msg"));
            intentBuilder.setType("text/plain");
        }
        if (checkKey("subject")) {
            intentBuilder.setSubject((String) params.get("subject"));
        }
        if (checkKey("uri")) {
            FileHelper fileHelper = getFileHelper(params);
            if (fileHelper.isFile()) {
//                final String SHARED_PROVIDER_AUTHORITY = registrar.context().getPackageName() + ".adv_provider";
                final Uri uri = (Uri) fileHelper.getUri();
                intentBuilder.setType(fileHelper.getType());
                intentBuilder.setStream(uri);

                List<ResolveInfo> resInfoList = this.registrar.context().getPackageManager().queryIntentActivities(intentBuilder.getIntent(), PackageManager.MATCH_DEFAULT_ONLY);
                for (ResolveInfo resolveInfo : resInfoList) {
                    String packageName = resolveInfo.activityInfo.packageName;
                    this.registrar.context().grantUriPermission(packageName, uri, Intent.FLAG_GRANT_WRITE_URI_PERMISSION | Intent.FLAG_GRANT_READ_URI_PERMISSION);
                }
            }
        }

        openChooser();
    }
    private void openChooser() {
        final Intent chooser = intentBuilder.createChooserIntent();
        if (registrar.activity() == null) {
            chooser.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            registrar.context().startActivity(chooser);
        } else {
            registrar.activity().startActivity(chooser);
        }
    }

    private FileHelper getFileHelper(Map params) {
        String uri = "";
        if (checkKey("uri")) {
            uri = (String) params.get("uri");
        }
        if (checkKey("type")) {
            return new FileHelper(registrar, (String) uri, (String) params.get("type"));
        } else {
            return new FileHelper(registrar, (String) uri);
        }
    }
    private boolean checkKey(String key) {
        if (params != null && !params.isEmpty()) {
            return params.get(key) != null;
        }
        return false;
    }
}