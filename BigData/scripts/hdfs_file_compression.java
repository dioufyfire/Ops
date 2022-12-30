package com.thomp.io; 
import org.apache.hadoop.conf.Configuration; 
import org.apache.hadoop.fs.FileSystem; 
import org.apache.hadoop.fs.Path; 
import org.apache.hadoop.io.IOUtils; 
import org.apache.hadoop.io.compress.BZip2Codec; 
import java.io.*; 
import java.net.URI; 


public class HdfsWrite { 
    public static void main(String args) { 
        String uriIn = args[0]; //source location 
        String uriDest = args[1]; // destinatio of compressed file 
        boolean toCompress = Boolean.parseBoolean(args[2]); // if should compress 
        Configuration conf = new Configuration(); 
        BZip2Codec codec = new BZip2Codec(); 
        try { 
            FileSystem fileSystem = FileSystem.get(URI.create(uriDest), conf); 
            InputStream inputStream = new BufferedlnputStream(new FileInputStream(uriIn)); 
            OutputStream outputStream = fileSystem.create(new Path(uriDest)); 
            if (toCompress) {
                outputStream = codec.createOutputStream(outputStream); 
            }

            IOUtils.copyBytes(inputStream, outputStream, buffSize: 4096, close: true); 
        } catch (I0Exception e) {
            e.printStackTrace(); 
        }  
    }
}    
