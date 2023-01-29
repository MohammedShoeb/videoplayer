package com.android.fyi.filepathmessenger;

import org.qtproject.qt5.android.bindings.QtApplication;
import org.qtproject.qt5.android.bindings.QtActivity;

import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Log;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import android.view.WindowManager;

public class FilePathMessenger extends QtActivity
{

    public static native void fileSelected(String fileName);

    static final int REQUEST_VIDEO = 1;

    private static FilePathMessenger m_instance;

    public FilePathMessenger()
    {
        m_instance = this;
    }

@Override
public void onCreate(Bundle savedInstanceState)
{
    super.onCreate(savedInstanceState);
    getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
}

    static void selectVideo()
    {
        m_instance.dispatchOpenGallery();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
       if (resultCode == RESULT_OK)
        {
            if(requestCode == REQUEST_VIDEO)
            {
                String filePath = getRealPathFromURI(getApplicationContext(), data.getData());
                fileSelected(filePath);
            }
        }
        else
        {
            //fileSelected("");
        }

        super.onActivityResult(requestCode, resultCode, data);
    }

    private void dispatchOpenGallery()
    {
        Intent pickIntent = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
        pickIntent.setType("video/*");
        startActivityForResult(pickIntent, REQUEST_VIDEO);
    }

    public String getRealPathFromURI(Context context, Uri contentUri)
    {
        Cursor cursor = null;
        try
        {
            String[] proj = { MediaStore.Images.Media.DATA };
            cursor = context.getContentResolver().query(contentUri,  proj, null, null, null);
            int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
            cursor.moveToFirst();
            return cursor.getString(column_index);
        }
        finally
        {
            if (cursor != null)
            {
                cursor.close();
            }
        }
    }

}
