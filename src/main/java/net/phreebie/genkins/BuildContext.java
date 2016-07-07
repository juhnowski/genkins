package net.phreebie.genkins;


import java.util.Date;


public class BuildContext {

    String name;
    String repos;
    String rev;
    String user;
    String propname;
    String action;
    String workdir;

    public BuildContext(String repos,
            String rev,
            String user,
            String propname,
            String action) {
        Date dt = new Date();
        this.name = ""+dt.getTime();
        this.repos = repos;
        this.rev = rev;
        this.user = user;
        this.propname = propname;
        this.action = action;
        this.workdir = "~/tmp/svn_" + name;
    }
}
