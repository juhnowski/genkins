package net.phreebie.genkins;


import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

public class DebProducer extends Thread {

    private BuildContext bctx;

    public DebProducer(BuildContext b_ctx) {
        super(b_ctx.name);
        this.bctx = b_ctx;
    }

    public void run() {
        System.out.println("Process started: " + getName());
        
        try {
            ProcessBuilder builder = new ProcessBuilder("sh", "ci.sh " + bctx.workdir);
            builder.redirectOutput(new File(bctx.name + "_out.txt"));
            builder.redirectError(new File(bctx.name + "_err.txt"));
            Process p = builder.start();
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        System.out.println("Process finished: " + getName());
    }
}
