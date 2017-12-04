import org.json.JSONObject;
import java.io.*;
import java.net.*;
import java.nio.charset.Charset;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class Server {
    long delay = 2 * 60 * 1000; // delay in milliseconds
    LoopTask task = new LoopTask();
    Timer timer = new Timer("TaskName");

    public void start() {
        timer.cancel();
        timer = new Timer("TaskName");
        Date executionDate = new Date(); // no params = now
        timer.scheduleAtFixedRate(task, executionDate, delay);
    }

    private class LoopTask extends TimerTask {
        public void run() {
            try {
                String xml = getHTML();
                String strings[] = xml.split("</item>");

                strings[0] = strings[0].substring(strings[0].indexOf("<item>"));

                String finalString[] = new String[strings.length - 1];
                System.arraycopy(strings, 0, finalString, 0, finalString.length);

                News news[] = getData(finalString);

                for (int i = 0; i < news.length; i++) {
                    JSONObject items = new JSONObject();

                    items.put("Title", news[i].getTitle());
                    items.put("Date", news[i].getDisplayedDate());
                    items.put("Creator", news[i].getCreator());
                    items.put("Description", news[i].getDescription());
                    items.put("Content", news[i].getContent());
                    items.put("Link", news[i].getLink());
                    items.put("FacebookLink", news[i].getFacebookLink());
                    items.put("TwitterLink", news[i].getTwitterLink());

                    putToFireBase(items, news[i].getDate());
                }
            } catch (Exception e) {

            }
        }
    }

    private static String getHTML() throws Exception {
        URLConnection connection = new URL("http://eltiempo.com.ve/venezuela/feed/").openConnection();
        connection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11");
        connection.connect();

        BufferedReader r  = new BufferedReader(new InputStreamReader(connection.getInputStream(), Charset.forName("UTF-8")));

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = r.readLine()) != null) {
            sb.append(line);
        }

        return sb.toString();
    }

    private static News[] getData(String strings[]) {
        News news[] = new News[strings.length];

        for (int i = 0; i < strings.length; i++) {
            String current = strings[i];

            String title = current.substring(current.indexOf("<title>"));
            title = title.substring(0, title.indexOf("</title>"));
            title = title.replace("<title>", "");

            String pubDate = current.substring(current.indexOf("<pubDate>"));
            pubDate = pubDate.substring(0, pubDate.indexOf("</pubDate>"));
            pubDate = pubDate.replace("<pubDate>", "");

            String displayedDate = pubDate.substring(0, pubDate.indexOf(":")-3);

            String creator = current.substring(current.indexOf("<dc:creator><![CDATA["));
            creator = creator.substring(0, creator.indexOf("]]></dc:creator>"));
            creator = creator.replace("<dc:creator><![CDATA[", "");

            String description = current.substring(current.indexOf("<description><![CDATA["));
            description = description.substring(0, description.indexOf("]]></description>"));
            description = description.replace("<description><![CDATA[", "");
            description = description.replaceAll("<[^>]+>", "");
            description = description.replaceAll("&#8220;", "\"");
            description = description.replaceAll("&#8221;", "\"");
            description = description.replaceAll("&#8230;", "...");

            String content = current.substring(current.indexOf("<content:encoded><![CDATA["));
            content = content.substring(0, content.indexOf("<style>"));
            content = content.replace("<content:encoded><![CDATA[", "");
            content = content.replaceAll("<[^>]+>", "");
            content = content.replaceAll("&#8220;", "\"");
            content = content.replaceAll("&#8221;", "\"");
            content = content.replaceAll("&#8230;", "...");

            String link = current.substring(current.indexOf("<link>"));
            link = link.substring(0, link.indexOf("</link>"));
            link = link.replace("<link>", "");

            String facebookLink = current.substring(current.indexOf("https://www.facebook.com/"));
            facebookLink = facebookLink.substring(0, facebookLink.indexOf("onclick=\""));
            int value = facebookLink.length()-1;
            for (int j = value; j >= 0; j--) {
                if (facebookLink.charAt(j) == '\"') {
                    break;
                }
                value--;
            }
            facebookLink = facebookLink.substring(0, value);

            String twitterLink = current.substring(current.indexOf("https://twitter.com/"));
            twitterLink = twitterLink.substring(0, twitterLink.indexOf("onclick=\""));
            value = twitterLink.length()-1;
            for (int j = value; j >= 0; j--) {
                if (twitterLink.charAt(j) == '\"') {
                    break;
                }
                value--;
            }
            twitterLink = twitterLink.substring(0, value);

            news[i] = new News(title, pubDate, creator, content, description, facebookLink, twitterLink, link, displayedDate);
        }

        return news;
    }

    private static void putToFireBase(JSONObject jsonObject, String date) throws Exception {
        URL u = new URL("https://news-venezuela.firebaseio.com/" + date + "/.json?auth=ssO16QT2L1NmXQPIP59hh8T4ZqdLDlppBkdS6nVl");
        HttpURLConnection conn = (HttpURLConnection) u.openConnection();
        conn.setDoOutput(true);
        conn.setRequestMethod("PUT");
        conn.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
        DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
        BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(wr, "UTF-8"));

        String message = jsonObject.toString();

        writer.write(message, 0, message.length());
        writer.close();
        wr.close();

        wr.flush();
        wr.close();

        System.out.println(conn.getResponseCode());
        System.out.println(jsonObject.toString());
    }

    public static void main(String[] args) throws Exception {
        Server server = new Server();
        server.start();
    }
}
