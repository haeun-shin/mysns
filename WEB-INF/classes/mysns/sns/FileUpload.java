package mysns.sns;
import java.io.File;
import java.util.regex.Matcher;

public class FileUpload {
 public static void main(String[] args) {
	
     
     String url = FileUpload.class.getResource("").getPath();
     String url2 = FileUpload.class.getResource("/").getPath();
     
     System.out.println(url);
     System.out.println(url2);
		/* System.out.println(url.substring(1,url.indexOf("build"))); */
     
     url2 = url2.replaceAll("/", Matcher.quoteReplacement(File.separator));
     /*System.out.println(url);*/
     String l = File.separator;
     System.out.println(url2);
 }
 
}

